# Build mydma.ko natively on the board.
# Usage:  make         -> builds mydma.ko
#         make clean
obj-m := mydma.o

KDIR ?= /lib/modules/$(shell uname -r)/build
PWD  := $(shell pwd)

all:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
