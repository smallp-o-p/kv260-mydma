/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
/*
 * mydma_uapi.h - the interface between mydma.ko and user space.
 * Included by BOTH the driver (mydma.c) and user programs, so the two can
 * never disagree. Lives in driver/; user programs build with -I../driver.
 *
 * Usage from user space:
 *   fd = open("/dev/mydma", O_RDWR);
 *   tx = mmap(NULL, MYDMA_BUF_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, MYDMA_TX_OFFSET);
 *   rx = mmap(NULL, MYDMA_BUF_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, MYDMA_RX_OFFSET);
 *   ... fill tx ...
 *   mydma_xfer_args a = { .tx_bytes = n_in, .rx_bytes = n_out_max };
 *   ioctl(fd, MYDMA_XFER_CMD, &a);  // arms S2MM, runs MM2S, waits for both
 *   ... a.rx_bytes bytes of result are now in rx ...
 */
#ifndef MYDMA_UAPI_H
#define MYDMA_UAPI_H

#include <linux/ioctl.h>
#include <linux/types.h>

/* Size of each DMA buffer (tx and rx), and of each mapping. */
#define MYDMA_BUF_SIZE   (1 << 20)

/* mmap() offsets: which buffer a mapping refers to. */
#define MYDMA_TX_OFFSET  0
#define MYDMA_RX_OFFSET  MYDMA_BUF_SIZE

/*
 * Argument of MYDMA_XFER_CMD. Two __u32s: same 8-byte layout for 32- and
 * 64-bit programs, no padding.
 */
typedef struct {
	__u32 tx_bytes;   /* in:  bytes to send from the tx buffer on MM2S */
	__u32 rx_bytes;   /* in:  room in the rx buffer for S2MM;
			   * out: bytes actually received */
} mydma_xfer_args;

/*
 * One complete loopback transfer. Returns 0, or -1 with errno set.
 * MYDMA_CMD_NUM is only the command's number within the '(' magic;
 * MYDMA_XFER_CMD is the full encoded command to pass to ioctl() and to
 * compare against in the driver.
 */
#define MYDMA_CMD_NUM    0x29
#define MYDMA_XFER_CMD   _IOWR('(', MYDMA_CMD_NUM, mydma_xfer_args)

/*
 * ---- Weight engines (one MM2S-only AXI DMA per HP port) --------------------
 *
 * Present only when the device tree names them ("w0".."w3" in dma-names).
 * Each has its own buffer of wbuf_mb MiB (module parameter), mapped at
 * MYDMA_W_OFFSET(i):
 *
 *   w0 = mmap(NULL, info.w_buf_bytes[0], PROT_READ | PROT_WRITE, MAP_SHARED,
 *             fd, MYDMA_W_OFFSET(0));
 *
 * The offsets leave MYDMA_W_MAX_MB of room per engine, so the buffers can
 * grow later without changing this interface.
 */
#define MYDMA_NUM_W      4
#define MYDMA_W_MAX_MB   256
#define MYDMA_W_OFFSET(i) (((__u64)(i) + 1) * ((__u64)MYDMA_W_MAX_MB << 20))

/* Argument of MYDMA_INFO_CMD (out only). */
typedef struct {
	__u32 w_mask;                  /* bit i set = engine w<i> exists */
	__u32 w_buf_bytes[MYDMA_NUM_W]; /* size of each engine's buffer */
} mydma_info_args;

/*
 * Argument of MYDMA_STREAM_CMD: send bytes[i] from the start of w<i>'s
 * buffer on every engine in mask, all at once, and wait for all of them.
 * 64 bytes, no implicit padding.
 */
typedef struct {
	__u32 mask;                 /* in:  which engines (bit i = w<i>) */
	__u32 bytes[MYDMA_NUM_W];   /* in:  bytes per engine; keep a multiple of 4 KiB */
	__u32 reserved;             /*      set to 0 */
	__u64 elapsed_ns;           /* out: first start to last completion */
	__u64 done_ns[MYDMA_NUM_W]; /* out: first start to engine i's completion */
} mydma_stream_args;

#define MYDMA_INFO_CMD   _IOR('(', 0x2a, mydma_info_args)
#define MYDMA_STREAM_CMD _IOWR('(', 0x2b, mydma_stream_args)

#endif /* MYDMA_UAPI_H */
