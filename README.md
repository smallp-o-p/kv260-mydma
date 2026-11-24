# kv260-mydma

A Linux driver and test setup for an AXI DMA in the programmable logic of an
AMD Kria KV260, running PetaLinux 2022.2. User space reads and writes
`/dev/mydma`; the DMA streams the data through a 32-bit AXI-Stream block in
the PL and back to memory. The PL block here is a test incrementer (adds 1 to
every word), the first step towards a tiled matrix-multiply accelerator.

```
your program --write()--> mydma.ko --dmaengine--> xilinx_dma --> AXI DMA MM2S
                                                                     |
                                                              axis_incrementer
                                                                     |
your program <--read()--- mydma.ko <--dmaengine--- xilinx_dma <-- AXI DMA S2MM
```

`mydma.ko` does not touch the DMA's registers. AMD's in-kernel `xilinx_dma`
driver owns the hardware; `mydma` borrows its two channels through the device
tree and turns `write()` into an MM2S transfer and `read()` into an S2MM one.

## Layout

| Path | What it is |
| --- | --- |
| `driver/mydma.c` | The kernel module, heavily commented |
| `driver/mydma_uapi.h` | The `ioctl`/`mmap` interface, shared by the driver and user programs |
| `driver/Makefile` | Kbuild file for the module |
| `driver/build.sh` | Fetches the matching kernel source and builds `mydma.ko` |
| `driver/kconfig.txt` | The board kernel's config (`zcat /proc/config.gz`) |
| `hw/axis_incrementer.vhd` | The PL stream block (adds 1 per 32-bit word; `DATA_WIDTH` 32 or 128) |
| `hw/memthing_wrapper.bit` | Vivado bitstream for the current design |
| `hw/memory_thing.dtsi` | XSCT-generated device tree for that design (reference) |
| `hw/memory_thing.dts` | Device tree overlay: programs the PL, describes the DMA, binds `mydma` |
| `hw/shell.json` | Kria app descriptor (flat design) |
| `hw/package.sh` | Builds the Kria app folder from the `.bit` and overlay |
| `tools/bit2bin.py` | `.bit` to `.bit.bin` without bootgen |
| `tools/extract_bitbin.py` | Recovers a bitstream from a bootgen boot image |
| `app/dmatest.cpp` | C++ loopback test using `mmap` + `ioctl` (single-threaded) |
| `app/dmatest_rw.cpp` | Older C++ test using `read()`/`write()` on two threads |
| `app/bwtest.cpp` | Parallel DDR read bandwidth over the weight engines |
| `hw/multi_hp.dts` | Overlay for the four-weight-engine design |
| `hw/axis_sink.v` | Stream sink for read-only bandwidth tests |
| `hw/lane_checker.v` | Stand-in for the array: 5 streams in, one result per transfer out |
| `hw/tb/tb_lane_checker.v` | Random-traffic testbench for it (Icarus) |

## Target

| | |
| --- | --- |
| Board | Kria KV260, `xck26-sfvc784-2LV-c` |
| OS image | PetaLinux 2022.2_update-5 |
| Kernel | `5.15.36-xilinx-v2022.2` |
| Kernel source | `Xilinx/linux-xlnx`, tag `xlnx_rebase_v5.15_LTS_2022.2` |
| Vivado / XSCT | 2022.1 |

The module only loads on the exact kernel it was built for. After reflashing
the board, refresh `driver/kconfig.txt` and update `KTAG` and `WANT_RELEASE`
at the top of `driver/build.sh`. Note that AMD's `xilinx-v2022.2` tag is
kernel 5.15.0 despite its name; this board runs 5.15.36.

## Build

On Ubuntu or WSL Ubuntu (the board itself needs no internet or tools):

```bash
bash driver/build.sh      # -> driver/mydma.ko (first run clones ~1 GB into ~/kv260-kernel)
bash hw/package.sh        # -> out/memory_thing/{memory_thing.bit.bin, .dtbo, shell.json}
make -C app               # -> app/dmatest (static ARM64)
```

GitHub Actions runs the same three steps on every push. The board files are in
the run's `kv260-board-files` artifact.

### Editor setup (clangd)

`driver/build.sh` writes `driver/compile_commands.json` after each build
(it points into `~/kv260-kernel`, so keep that tree), and
`make -C app compile_commands` writes one for `app/`. The repo's `.clangd`
strips the kernel's GCC-only flags that would otherwise make clang give up.
Run clangd inside WSL (VS Code: "WSL: Connect to WSL"), and point it at the
cross compiler so C++ files use the ARM64 headers:

```json
"clangd.arguments": ["--query-driver=/usr/bin/aarch64-linux-gnu-*"]
```

## Deploy and test on the board

```bash
scp -r out/memory_thing driver/mydma.ko app/dmatest petalinux@<board-ip>:~/

# on the board
sudo cp -r ~/memory_thing /lib/firmware/xilinx/
sudo xmutil unloadapp
sudo xmutil loadapp memory_thing
sudo devmem 0xa0000004 32                        # 0x00010009 = halted, scatter-gather included
sudo insmod ~/mydma.ko max_xfer=1048576
dmesg | tail -1                                  # mydma axi:mydma: ready: ... /dev/mydma
```

Loopback test with `dd` (the reader starts first so S2MM is armed):

```bash
head -c 1048576 /dev/urandom > /tmp/in
sudo dd if=/dev/mydma of=/tmp/out bs=1048576 count=1 &
sleep 0.5
sudo dd if=/tmp/in of=/dev/mydma bs=1048576 count=1
wait
paste -d' ' <(od -A n -v -t u4 /tmp/in) <(od -A n -v -t u4 /tmp/out) | awk '{n+=4; for(i=1;i<=4;i++) if (($i+1)%4294967296 != $(i+4)) bad++} END {print bad ? bad" of "n" words wrong" : "all "n" words = input + 1"}'
```

## Four readers, one writer (multi_hp)

The `multi_hp` design is the shape of the LLM accelerator's memory system:

```
DDR --HP0--> dma_w0 MM2S --\
DDR --HP1--> dma_w1 MM2S ---\
DDR --HP2--> dma_w2 MM2S ----> lane_checker (stand-in for the array) --> axi_dma_0 S2MM --HPC0--> DDR
DDR --HP3--> dma_w3 MM2S ---/
DDR --HPC0-> axi_dma_0 MM2S /     (activations in)                          (results out)
```

- `dma_w0`..`dma_w3`: MM2S-only AXI DMAs, one per HP port, 128-bit at
  250 MHz with 256-beat bursts. They stream weights.
- `axi_dma_0`: the old loopback DMA, now 128-bit on HPC0. It is the activation
  engine: MM2S brings activations in, and S2MM is the single writer.
- `hw/lane_checker.v`: takes all five streams at full rate and, for each
  finished transfer, writes one 16-byte result (magic `C0FFEE`, lane id,
  beat count, XOR of the data) through the S2MM. Swap it for the matmul array
  later; the DMA side stays the same. `hw/tb/tb_lane_checker.v` tests it
  (`iverilog -g2005 -o tb hw/lane_checker.v hw/tb/tb_lane_checker.v && vvp tb`).

Overlay: `hw/multi_hp.dts`. Package with
`APP=multi_hp bash hw/package.sh path/to/multi_hp.bit`.

Driver: the weight engines are the optional channels `w0`..`w3` in
`dma-names` (missing ones are skipped, so it still runs on `memory_thing`).
Each gets a `wbuf_mb` MiB buffer (module parameter, default 16) mapped at
`MYDMA_W_OFFSET(i)`. `MYDMA_STREAM_CMD` starts the chosen engines together
and reports when each finished. With `MYDMA_STREAM_RESULTS` it also arms the
activation S2MM for one result per lane; results land at the start of the rx
buffer, and the call returns when the last one is in memory.
`MYDMA_INFO_CMD` says which engines exist. Optional `w<i>rx` channels turn a
lane into a loopback debug lane through `axis_incrementer` (`DATA_WIDTH=128`).

```bash
sudo xmutil unloadapp && sudo xmutil loadapp multi_hp
sudo insmod ~/mydma.ko max_xfer=1048576
dmesg | grep mydma          # one "w<i>=..." line per weight engine
sudo ./bwtest 16 20         # each engine alone, every pair, all four; checks every result
```

## Using `/dev/mydma`

**`mmap` + `ioctl` (zero-copy, no race).** Defined in `driver/mydma_uapi.h`:

```c
tx = mmap(NULL, MYDMA_BUF_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, MYDMA_TX_OFFSET);
rx = mmap(NULL, MYDMA_BUF_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, MYDMA_RX_OFFSET);
/* fill tx */
mydma_xfer_args a = { .tx_bytes = n_in, .rx_bytes = n_out_max };
ioctl(fd, MYDMA_XFER_CMD, &a);   /* arms S2MM, runs MM2S, waits for both */
/* a.rx_bytes bytes of result are now in rx */
```

The buffers belong to the DMA while the `ioctl` runs. They are uncached on
this board: fine to fill and check, slow for heavy CPU processing.

**`read()` / `write()` (copies through the driver).**

- `write(fd, buf, n)` sends `n` bytes on MM2S and blocks until they have left.
- `read(fd, buf, n)` arms S2MM for up to `n` bytes, blocks until a packet
  (TLAST) or `n` bytes arrive, and returns the bytes received.

Both paths fail with `ETIMEDOUT` after 3 s, and move at most `max_xfer` bytes
per call (module parameter, default 16383).

## Known issues

- **S2MM must be armed before MM2S starts.** If stream data reaches an unarmed
  S2MM, the received data is silently corrupted while the full length is
  reported. `MYDMA_XFER_CMD` guarantees the order. With `read()`/`write()`, a
  loopback needs `read()` running on another thread before `write()` starts,
  and user space can't know when that has happened, so `app/dmatest_rw.cpp`
  can lose this race.
- `driver/mydma.c` still has its own copy of the interface definitions and
  compares the `ioctl` command against `MYDMA_CMD_NUM` (the bare number)
  instead of `MYDMA_XFER_CMD`. Until it includes `mydma_uapi.h` and compares
  against `MYDMA_XFER_CMD`, `app/dmatest` gets `ENOTTY`.
- The Vivado project itself is not in this repository yet, only its
  bitstream. Exporting the block design (`write_bd_tcl`) would make the
  hardware rebuildable.
