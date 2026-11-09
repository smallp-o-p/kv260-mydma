// SPDX-License-Identifier: GPL-2.0
/*
 * mydma.c - ANNOTATED copy. Same code as the working driver, with comments
 * explaining what each part does and why. Builds and behaves identically.
 *
 * ============================================================================
 * THE BIG PICTURE
 * ============================================================================
 *
 * Three layers are involved when your program calls write() on /dev/mydma:
 *
 *   your program
 *       |  write(fd, buf, n)            <- ordinary system call
 *       v
 *   mydma.ko  (this file)               <- turns the call into a DMA request
 *       |  dmaengine_prep_slave_single(), dmaengine_submit(), ...
 *       v
 *   xilinx_dma  (AMD's driver, in the kernel)  <- programs the AXI DMA's registers
 *       |  writes CURDESC / TAILDESC / DMACR at 0xA000_0000, handles interrupts
 *       v
 *   AXI DMA in the PL                   <- actually moves the bytes
 *
 * "dmaengine" is the kernel's generic DMA API. Any driver that needs DMA
 * (sound cards, SPI controllers, ...) talks to any DMA controller through it,
 * without knowing that controller's registers. That's why this file contains
 * no register addresses at all: xilinx_dma owns the hardware, and we are a
 * "dmaengine client" that borrows its two channels.
 *
 * The life of one write():
 *   1. Copy the user's bytes into a DMA-capable kernel buffer (tx->buf).
 *   2. Ask xilinx_dma to prepare a transfer descriptor for that buffer.
 *   3. Submit it (queue it), then issue_pending (start the hardware).
 *   4. Sleep until the DMA's completion interrupt wakes us (or 3 s pass).
 *   5. Return the byte count to the program.
 * read() is the same on the rx channel, with the copy happening at the end.
 *
 * ============================================================================
 * HOW THE KERNEL FINDS THIS DRIVER
 * ============================================================================
 *
 * The device tree overlay contains:
 *
 *   mydma {
 *       compatible = "acme,mydma";
 *       dmas = <&axi_dma_0 0>, <&axi_dma_0 1>;   // 0 = MM2S, 1 = S2MM
 *       dma-names = "tx", "rx";
 *   };
 *
 * When the overlay is applied, the kernel creates a "platform device" for
 * that node. When this module is loaded, the kernel compares the device's
 * `compatible` string against our of_match_table (near the bottom of this
 * file). A match calls mydma_probe() with that device. The `dmas` and
 * `dma-names` properties are what dma_request_chan(dev, "tx") reads later.
 */
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/version.h>
#include <linux/platform_device.h>
#include <linux/of.h>
#include <linux/dmaengine.h>      /* the dmaengine client API */
#include <linux/dma-mapping.h>    /* dma_alloc_coherent() and friends */
#include <linux/miscdevice.h>     /* the easy way to get a /dev node */
#include <linux/fs.h>             /* struct file_operations */
#include <linux/uaccess.h>        /* copy_from_user() / copy_to_user() */
#include <linux/completion.h>     /* "sleep until X happens" primitive */
#include <linux/mutex.h>
#include <linux/atomic.h>
#include <linux/jiffies.h>        /* msecs_to_jiffies(): kernel time units */

#define DRV_NAME        "mydma"
#define BUF_SIZE        (1 << 20)   /* 1 MiB per direction */
#define XFER_TIMEOUT_MS 3000

/*
 * Module parameter: settable at load time with `insmod mydma.ko max_xfer=N`,
 * readable afterwards in /sys/module/mydma/parameters/max_xfer (mode 0444 =
 * read-only there).
 *
 * Why a cap at all: in simple (non-scatter-gather) mode, xilinx_dma programs
 * only the first hardware segment of a descriptor, so anything longer than
 * the DMA's length register allows (2^width - 1 bytes) would be silently
 * truncated. 16383 is safe for the default 14-bit register.
 */
static unsigned int max_xfer = 16383;
module_param(max_xfer, uint, 0444);
MODULE_PARM_DESC(max_xfer, "Max bytes per read()/write() (default 16383, max 1 MiB)");

/*
 * Everything we keep per direction. There are two of these: tx (MM2S,
 * memory -> stream) and rx (S2MM, stream -> memory).
 */
struct mydma_chan {
	struct device *dev;          /* our platform device, for re-requesting */
	const char *name;            /* "tx" or "rx" (dma-names in the DT) */

	/*
	 * Handle to one of xilinx_dma's channels. Every dmaengine call takes
	 * this. NULL only if re-requesting it failed (see mydma_rearm).
	 */
	struct dma_chan *chan;

	/*
	 * The DMA *controller's* struct device (the a0000000.dma node), not
	 * ours. DMA memory must be allocated against the device that will
	 * actually access it, because that device carries the DMA rules:
	 * its address width (xlnx,addrwidth = 32 bits -> buffers must be below
	 * 4 GiB) and whether it is cache-coherent (here: no).
	 */
	struct device *dma_dev;

	struct mydma_chan *peer;     /* the other direction (tx <-> rx) */

	/*
	 * Set when the *other* channel was reset (see the quirk explanation
	 * above mydma_rearm). atomic_t because the tx and rx paths can run on
	 * different CPUs at the same time, each holding only its own mutex.
	 */
	atomic_t irq_lost;

	/*
	 * THE DMA BUFFER. This is the "memory designated for DMA" from your
	 * mental model. dma_alloc_coherent() returns TWO addresses for one
	 * block of memory:
	 *   buf     - a kernel virtual address: what the CPU uses (memcpy etc.)
	 *   buf_dma - the bus address: what the DMA hardware is told to use.
	 *             On this board it equals the physical address.
	 * The memory is physically contiguous (the DMA doesn't know about
	 * virtual memory pages) and, because the AXI DMA isn't cache-coherent,
	 * the CPU's view of it is uncached, so the CPU and the DMA always see
	 * the same bytes without explicit cache flushes.
	 *
	 * >>> YOUR MMAP WORK: these are the buffers you will map into user
	 * >>> space. Look at dma_mmap_coherent(): it takes exactly the
	 * >>> (dma_dev, buf, buf_dma, size) set stored here.
	 */
	void *buf;
	dma_addr_t buf_dma;

	/*
	 * A completion is a one-shot "event happened" flag that a thread can
	 * sleep on. The DMA callback calls complete(); the waiting thread is
	 * woken. reinit_completion() re-arms it before each transfer.
	 */
	struct completion done;

	/*
	 * One transfer at a time per direction: two threads both calling
	 * write() would otherwise share tx->buf and tx->done. A mutex (not a
	 * spinlock) because we sleep while holding it.
	 */
	struct mutex lock;

	/* Filled in by the completion callback, read by the waiting thread. */
	enum dmaengine_tx_result result;
	u32 residue;                 /* bytes NOT transferred (0 = all of them) */
};

/* The whole device: both directions plus the /dev node. */
struct mydma {
	struct device *dev;
	struct mydma_chan tx;
	struct mydma_chan rx;
	struct miscdevice misc;      /* embedded, so container_of() can find us */
};

/*
 * Completion callback. xilinx_dma calls this when a descriptor finishes.
 * It runs in "tasklet" context: a deferred part of the interrupt handler.
 * Rules there: no sleeping, keep it short. So it only records the result
 * and wakes the thread that's waiting in mydma_xfer().
 *
 * `arg` is whatever we put in desc->callback_param (our mydma_chan).
 * res->residue is how many bytes were NOT transferred: with scatter-gather
 * this is accurate, which is how read() reports a short packet (TLAST before
 * the buffer was full). In simple mode xilinx_dma always reports 0.
 */
static void mydma_done(void *arg, const struct dmaengine_result *res)
{
	struct mydma_chan *c = arg;

	c->result = res->result;
	c->residue = res->residue;
	complete(&c->done);
}

/*
 * ---- The AXI DMA reset quirk ----------------------------------------------
 *
 * When a transfer times out we must stop the channel and throw away its
 * descriptor (dmaengine_terminate_sync). xilinx_dma does that by resetting
 * the DMA core. But the AXI DMA's reset bit resets BOTH channels, and
 * xilinx_dma then re-enables interrupts only on the channel being stopped.
 * The other channel keeps working but never interrupts again, so its next
 * transfer completes silently and times out.
 *
 * The fix: after any terminate, flag the peer (mydma_abort). Before the
 * peer's next transfer, release and re-request it (mydma_rearm). Requesting
 * a channel runs xilinx_dma's "allocate channel resources" step, which
 * re-enables that channel's interrupts WITHOUT another reset.
 */
static int mydma_rearm(struct mydma_chan *c)
{
	struct dma_chan *chan;

	if (c->chan)
		dma_release_channel(c->chan);
	c->chan = NULL;

	/* Same lookup as at probe time: "tx"/"rx" -> dmas = <...> in the DT. */
	chan = dma_request_chan(c->dev, c->name);
	if (IS_ERR(chan)) {
		/*
		 * Kernel functions that return pointers signal errors by encoding
		 * a negative errno *in* the pointer. IS_ERR() tests for that,
		 * PTR_ERR() extracts the errno.
		 */
		dev_err(c->dev, "re-requesting '%s' DMA channel failed: %ld\n",
			c->name, PTR_ERR(chan));
		atomic_set(&c->irq_lost, 1);   /* try again next time */
		return PTR_ERR(chan);
	}
	c->chan = chan;
	return 0;
}

/* Stop our channel after a timeout or signal; this resets the peer too. */
static void mydma_abort(struct mydma_chan *c)
{
	/*
	 * _sync: also waits until our callback can no longer run, so nothing
	 * touches c->done or c->buf after we return.
	 */
	dmaengine_terminate_sync(c->chan);
	atomic_set(&c->peer->irq_lost, 1);
}

/*
 * One complete DMA transfer on one channel: prepare, submit, start, wait.
 * Returns bytes transferred, or a negative errno. Caller holds c->lock.
 *
 * >>> YOUR IOCTL WORK: this function does "start" and "wait" in one go,
 * >>> which is exactly why write()-then-read() can't work: by the time
 * >>> write() returns, MM2S has finished, and S2MM was never armed.
 * >>> To arm S2MM first and then run MM2S, you need to split this into a
 * >>> "submit + issue_pending" half and a "wait for completion" half, so
 * >>> both channels can be in flight at once. Note which steps belong to
 * >>> which half, and what each half needs to remember (the completion,
 * >>> the length, the result).
 */
static ssize_t mydma_xfer(struct mydma_chan *c, size_t len,
			  enum dma_transfer_direction dir)
{
	struct dma_async_tx_descriptor *desc;
	dma_cookie_t cookie;
	long left;
	int ret;

	/* Recover from the reset quirk (above) before using this channel. */
	if (atomic_xchg(&c->irq_lost, 0) || !c->chan) {
		ret = mydma_rearm(c);
		if (ret)
			return ret;
	}

	/*
	 * Step 1, PREPARE: ask xilinx_dma to build a descriptor for one
	 * contiguous buffer. "slave" = transfer between memory and a device
	 * port (here the AXI-Stream side), as opposed to memory-to-memory.
	 * `dir` says which way: DMA_MEM_TO_DEV (MM2S) or DMA_DEV_TO_MEM (S2MM).
	 * Flags: INTERRUPT = call our callback when done; CTRL_ACK = we won't
	 * reuse this descriptor, the driver may free it afterwards.
	 * With scatter-gather enabled, xilinx_dma writes the hardware buffer
	 * descriptors into its own DMA memory here.
	 * Nothing has touched the hardware yet.
	 */
	desc = dmaengine_prep_slave_single(c->chan, c->buf_dma, len, dir,
					   DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
	if (!desc)
		return -EIO;

	/* Re-arm the completion BEFORE the transfer can possibly finish. */
	reinit_completion(&c->done);
	desc->callback_result = mydma_done;
	desc->callback_param = c;

	/*
	 * Step 2, SUBMIT: put the descriptor in the channel's pending queue.
	 * The cookie is a ticket number for tracking it; we only check that
	 * submission succeeded. Still nothing running in hardware.
	 */
	cookie = dmaengine_submit(desc);
	if (dma_submit_error(cookie))
		return -EIO;

	/*
	 * Step 3, ISSUE: "start everything pending now". This is the moment
	 * xilinx_dma writes the AXI DMA's registers and the channel starts:
	 * for MM2S, data begins flowing out; for S2MM, the channel is now
	 * ARMED and accepts stream data into c->buf.
	 */
	dma_async_issue_pending(c->chan);

	/*
	 * Step 4, WAIT: sleep until mydma_done() calls complete(), up to 3 s.
	 * "interruptible" = a signal (Ctrl-C) also wakes us.
	 * Return value: >0 jiffies left (success), 0 = timed out,
	 * <0 = interrupted by a signal (-ERESTARTSYS).
	 * While sleeping here, the thread uses no CPU.
	 */
	left = wait_for_completion_interruptible_timeout(&c->done,
				msecs_to_jiffies(XFER_TIMEOUT_MS));
	if (left <= 0) {
		/*
		 * The transfer is still queued in hardware; we must cancel it
		 * before returning, or a late completion could write into
		 * c->buf / c->done after we've moved on.
		 */
		mydma_abort(c);
		return left ? left : -ETIMEDOUT;
	}

	if (c->result != DMA_TRANS_NOERROR)
		return -EIO;

	/* Note: in simple (non-SG) mode xilinx_dma always reports residue 0. */
	return len - c->residue;
}

/* Never transfer more than the buffer holds, or than max_xfer allows. */
static size_t mydma_clamp(size_t count)
{
	return min3(count, (size_t)BUF_SIZE, (size_t)max_xfer);
}

/*
 * write() on /dev/mydma lands here. Arguments come straight from the
 * system call; `ubuf` is a USER-space pointer (marked __user), which the
 * kernel must never dereference directly: the page may not be mapped, or
 * the address may be bogus. copy_from_user() does it safely.
 */
static ssize_t mydma_write(struct file *f, const char __user *ubuf,
			   size_t count, loff_t *ppos)
{
	/*
	 * misc devices set f->private_data to the struct miscdevice when the
	 * file is opened. Our miscdevice is embedded inside struct mydma, so
	 * container_of() steps back from the member to the whole struct.
	 */
	struct mydma *md = container_of(f->private_data, struct mydma, misc);
	struct mydma_chan *c = &md->tx;
	ssize_t ret;

	count = mydma_clamp(count);
	if (!count)
		return 0;

	/* Returns non-zero if a signal arrived while waiting for the lock. */
	if (mutex_lock_interruptible(&c->lock))
		return -ERESTARTSYS;

	/* THE COPY: user buffer -> DMA buffer. This is what mmap would remove. */
	if (copy_from_user(c->buf, ubuf, count)) {
		ret = -EFAULT;   /* bad user pointer */
		goto out;
	}

	ret = mydma_xfer(c, count, DMA_MEM_TO_DEV);
out:
	mutex_unlock(&c->lock);
	return ret;          /* bytes sent; a short count if clamped */
}

/* read() on /dev/mydma: arm S2MM, wait, copy whatever arrived to the user. */
static ssize_t mydma_read(struct file *f, char __user *ubuf,
			  size_t count, loff_t *ppos)
{
	struct mydma *md = container_of(f->private_data, struct mydma, misc);
	struct mydma_chan *c = &md->rx;
	ssize_t ret;

	count = mydma_clamp(count);
	if (!count)
		return 0;

	if (mutex_lock_interruptible(&c->lock))
		return -ERESTARTSYS;

	/*
	 * Note the ORDER problem from the demo: S2MM is only armed inside this
	 * call (at issue_pending). If MM2S already started sending, the first
	 * beats reached an unarmed S2MM and the data is corrupted.
	 */
	ret = mydma_xfer(c, count, DMA_DEV_TO_MEM);

	/* THE OTHER COPY: DMA buffer -> user buffer, only the bytes received. */
	if (ret > 0 && copy_to_user(ubuf, c->buf, ret))
		ret = -EFAULT;

	mutex_unlock(&c->lock);
	return ret;
}

/*
 * The table that connects system calls on /dev/mydma to our functions.
 * Anything not listed gets a default: e.g. no .mmap means mmap() fails with
 * ENODEV, no .unlocked_ioctl means ioctl() fails with ENOTTY.
 *
 * >>> YOUR WORK: .mmap and .unlocked_ioctl are the two entries you'll add.
 * >>> An ioctl command number is built with the _IOWR() macro from a
 * >>> "magic" letter, a number and the argument struct's type; user space
 * >>> and the driver must share that definition (usually a small header).
 */
static const struct file_operations mydma_fops = {
	.owner  = THIS_MODULE,   /* keeps the module loaded while the file is open */
	.read   = mydma_read,
	.write  = mydma_write,
	.llseek = noop_llseek,   /* lseek() succeeds but does nothing: no file position */
};

/*
 * Set up one direction at probe time: get the DMA channel, then allocate
 * its buffer. Called twice: once for "tx", once for "rx".
 */
static int mydma_chan_init(struct device *dev, struct mydma_chan *c,
			   const char *name, struct mydma_chan *peer)
{
	c->dev = dev;
	c->name = name;
	c->peer = peer;
	atomic_set(&c->irq_lost, 0);

	/*
	 * Looks up `name` in our node's dma-names, takes the matching entry in
	 * `dmas` (<&axi_dma_0 0> for "tx"), and asks xilinx_dma for that
	 * channel. If xilinx_dma hasn't probed yet, this returns
	 * -EPROBE_DEFER and the kernel retries our probe later on its own;
	 * dev_err_probe() logs an error only for real failures, not deferral.
	 */
	c->chan = dma_request_chan(dev, name);
	if (IS_ERR(c->chan))
		return dev_err_probe(dev, PTR_ERR(c->chan),
				     "failed to get '%s' DMA channel\n", name);

	/*
	 * Allocate the DMA buffer against the DMA controller's device, not
	 * ours: it carries the correct DMA mask (from xlnx,addrwidth) and
	 * coherency setting. See the comment on dma_dev in the struct.
	 * GFP_KERNEL = a normal allocation that may sleep (fine in probe).
	 */
	c->dma_dev = c->chan->device->dev;
	c->buf = dma_alloc_coherent(c->dma_dev, BUF_SIZE, &c->buf_dma, GFP_KERNEL);
	if (!c->buf) {
		dma_release_channel(c->chan);
		return -ENOMEM;
	}

	init_completion(&c->done);
	mutex_init(&c->lock);
	return 0;
}

/* Undo mydma_chan_init(), in reverse order. */
static void mydma_chan_free(struct mydma_chan *c)
{
	if (c->chan) {
		dmaengine_terminate_sync(c->chan);   /* cancel anything still queued */
		dma_release_channel(c->chan);
	}
	dma_free_coherent(c->dma_dev, BUF_SIZE, c->buf, c->buf_dma);
}

/*
 * probe: called when the kernel matches our driver to the device tree node.
 * Everything the device needs is set up here; returning an error leaves the
 * device unbound (and nothing half-allocated, thanks to the goto ladder).
 */
static int mydma_probe(struct platform_device *pdev)
{
	struct device *dev = &pdev->dev;
	struct mydma *md;
	int ret;

	/*
	 * devm_ = "device-managed": freed automatically when the device is
	 * unbound, so there's no matching kfree() in remove.
	 */
	md = devm_kzalloc(dev, sizeof(*md), GFP_KERNEL);
	if (!md)
		return -ENOMEM;
	md->dev = dev;

	ret = mydma_chan_init(dev, &md->tx, "tx", &md->rx);
	if (ret)
		return ret;

	ret = mydma_chan_init(dev, &md->rx, "rx", &md->tx);
	if (ret)
		goto err_tx;

	/*
	 * A misc device is a character device with major number 10 and a
	 * dynamically chosen minor. misc_register() creates /dev/mydma
	 * (via udev) and routes its system calls to mydma_fops.
	 * After this call, user space can open the device: everything it
	 * needs must already be set up, which is why it comes last.
	 */
	md->misc.minor = MISC_DYNAMIC_MINOR;
	md->misc.name  = DRV_NAME;
	md->misc.fops  = &mydma_fops;
	md->misc.parent = dev;

	ret = misc_register(&md->misc);
	if (ret)
		goto err_rx;

	/* Stash our struct so remove() can find it from the platform device. */
	platform_set_drvdata(pdev, md);
	dev_info(dev, "ready: tx=%s rx=%s, max_xfer=%u, /dev/%s\n",
		 dma_chan_name(md->tx.chan), dma_chan_name(md->rx.chan),
		 max_xfer, DRV_NAME);
	return 0;

	/* Error unwinding: each label undoes the steps that succeeded before it. */
err_rx:
	mydma_chan_free(&md->rx);
err_tx:
	mydma_chan_free(&md->tx);
	return ret;
}

/*
 * Called on rmmod, or when the overlay is removed (xmutil unloadapp).
 * Order matters: remove /dev/mydma first so no new calls can arrive, then
 * free the channels and buffers.
 */
static void mydma_teardown(struct platform_device *pdev)
{
	struct mydma *md = platform_get_drvdata(pdev);

	misc_deregister(&md->misc);
	mydma_chan_free(&md->rx);
	mydma_chan_free(&md->tx);
}

/*
 * platform_driver.remove changed to return void in 6.11. This board runs
 * 5.15, so the int version is compiled; the #if keeps the file building on
 * newer kernels too.
 */
#if LINUX_VERSION_CODE >= KERNEL_VERSION(6, 11, 0)
static void mydma_remove(struct platform_device *pdev)
{
	mydma_teardown(pdev);
}
#else
static int mydma_remove(struct platform_device *pdev)
{
	mydma_teardown(pdev);
	return 0;
}
#endif

/*
 * The device tree match table: any node with compatible = "acme,mydma"
 * binds to this driver. MODULE_DEVICE_TABLE exports it into the .ko's
 * metadata (the "alias=of:N*T*Cacme,mydma" line modinfo shows), which is
 * what lets udev auto-load the module when the overlay creates the node.
 */
static const struct of_device_id mydma_of_match[] = {
	{ .compatible = "acme,mydma" },
	{ /* sentinel: an empty entry marks the end of the table */ }
};
MODULE_DEVICE_TABLE(of, mydma_of_match);

static struct platform_driver mydma_driver = {
	.probe  = mydma_probe,
	.remove = mydma_remove,
	.driver = {
		.name = DRV_NAME,
		.of_match_table = mydma_of_match,
	},
};

/*
 * Expands to the module's init and exit functions: register the platform
 * driver on insmod, unregister it on rmmod.
 */
module_platform_driver(mydma_driver);

MODULE_AUTHOR("Your Name");
MODULE_DESCRIPTION("dmaengine client for a PL AXI DMA on Kria KV260");
/* GPL is required to use GPL-only kernel symbols, which dmaengine is. */
MODULE_LICENSE("GPL");
