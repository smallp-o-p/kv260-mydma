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

#endif /* MYDMA_UAPI_H */
