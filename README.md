# kv260-mydma

A small AI inference accelerator on an AMD Kria KV260 (PetaLinux 2022.2): a
Linux driver, `/dev/mydma`, that feeds AXI DMAs in the programmable logic,
and a matmul controller in the PL that runs one LINEAR call (`y = W x`, FP8
in, fp32 out) on the data they stream.

```
DDR --> weight DMAs w0..w3 --> FIFOs ------------------------> axi_controller <--> tile
DDR --> axi_dma_4 MM2S    --> activation_buffer ------------> axi_controller
DDR <-- axi_dma_4 S2MM    <-- level2 (fp32 results) <-------- axi_controller
```

`mydma.ko` does not touch the DMA registers. AMD's in-kernel `xilinx_dma`
driver owns the hardware; `mydma` borrows its channels through the device
tree and exposes them as `mmap` buffers plus `ioctl`s (and `read()`/`write()`).

The controller, its tile contract and its simulation are described in
[`controller_README.md`](hw/memory_thing/memory_thing.srcs/sources_1/new/controller_README.md);
the board test for it is `app/lineartest.cpp`.

## Layout

| Path | What it is |
| --- | --- |
| `driver/mydma.c` | The kernel module, heavily commented |
| `driver/mydma_uapi.h` | The `ioctl`/`mmap` interface, shared by the driver and user programs |
| `driver/Makefile`, `driver/build.sh` | Kbuild file; script that fetches the matching kernel source and builds `mydma.ko` |
| `driver/kconfig.txt` | The board kernel's config (`zcat /proc/config.gz`) |
| `app/lineartest.cpp` | One LINEAR call through the controller, every output checked |
| `app/bwtest.cpp` | Weight-lane bandwidth, checked through `lane_checker.v` |
| `app/dmatest.cpp`, `app/dmatest_rw.cpp` | Loopback tests: `mmap` + `ioctl`, and the older `read()`/`write()` one |
| `hw/memory_thing/` | The Vivado 2026.1 project (`memory_thing.xpr`, block design `memthing`) |
| `hw/memory_thing/memory_thing.srcs/sources_1/new/` | The RTL: `axi_controller.v`, `level2.v`, `tile_ref.v`, `fp32_funcs.vh`, `activation_buffer.v`, `lane_checker.v` |
| `hw/memory_thing/memory_thing.srcs/sim_1/new/` | Test benches and vector generators |
| `hw/memthing_wrapper.bit`, `hw/memory_thing/multi_hp.bit` | Committed bitstreams that CI packages (see below) |
| `hw/memory_thing.dts`, `hw/multi_hp.dts` | Device tree overlays: program the PL, describe the DMAs, bind `mydma` |
| `hw/memory_thing.dtsi`, `hw/memory_thing/dts_output/` | XSCT-generated device tree (reference for the overlays) |
| `hw/shell.json`, `hw/package.sh` | Kria app descriptor; builds the app folder from a `.bit` and an overlay |
| `tools/bit2bin.py` | `.bit` to `.bit.bin` without bootgen (prints the build date) |
| `tools/extract_bitbin.py` | Recovers a bitstream from a bootgen boot image |

## Target

| | |
| --- | --- |
| Board | Kria KV260, `xck26-sfvc784-2LV-c` |
| OS image | PetaLinux 2022.2_update-5 |
| Kernel | `5.15.36-xilinx-v2022.2` |
| Kernel source | `Xilinx/linux-xlnx`, tag `xlnx_rebase_v5.15_LTS_2022.2` |
| Vivado | 2026.1 |

The module only loads on the exact kernel it was built for. After reflashing
the board, refresh `driver/kconfig.txt` and update `KTAG` and `WANT_RELEASE`
at the top of `driver/build.sh`. Note that AMD's `xilinx-v2022.2` tag is
kernel 5.15.0 despite its name; this board runs 5.15.36.

## Build

On Ubuntu or WSL Ubuntu (the board itself needs no internet or tools):

```bash
bash driver/build.sh                                    # -> driver/mydma.ko (first run clones ~1 GB into ~/kv260-kernel)
APP=multi_hp bash hw/package.sh hw/memory_thing/multi_hp.bit   # -> out/multi_hp/{multi_hp.bit.bin, .dtbo, shell.json}
make -C app                                             # -> app/dmatest, dmatest_rw, bwtest, lineartest (static ARM64)
```

GitHub Actions runs these on every push (plus the `memory_thing` app from
`hw/memthing_wrapper.bit`). The board files are in the run's
`kv260-board-files` artifact.

**Bitstreams.** CI packages whatever is committed. After rebuilding in
Vivado, copy `hw/memory_thing/memory_thing.runs/impl_1/memthing_wrapper.bit`
to `hw/memory_thing/multi_hp.bit` and commit it. `python3 tools/bit2bin.py
<bit> /dev/null` prints which build a `.bit` is.

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
scp -r out/multi_hp driver/mydma.ko app/lineartest app/bwtest petalinux@<board-ip>:~/

# on the board
sudo cp -r ~/multi_hp /lib/firmware/xilinx/
sudo xmutil unloadapp
sudo xmutil loadapp multi_hp
sudo insmod ~/mydma.ko max_xfer=1048576
dmesg | grep mydma          # "ready" plus one "w<i>=..." line per weight engine
sudo ./lineartest           # one LINEAR call, N = K = 1024 (see the source for options)
```

## The DMA side

- Four MM2S-only weight DMAs (`w0`..`w3` in the overlay), each feeding an
  AXI4-Stream FIFO in front of the controller's `s_w0..3` lanes.
- `axi_dma_4`: the activation engine. MM2S brings activations in; S2MM is
  the single writer for results.

Driver: the weight engines are the optional channels `w0`..`w3` in
`dma-names` (missing ones are skipped). Each gets a `wbuf_mb` MiB buffer
(module parameter, default 16) mapped at `MYDMA_W_OFFSET(i)`.
`MYDMA_STREAM_CMD` starts the chosen engines together and reports when each
finished. With `MYDMA_STREAM_RESULTS` it also arms the activation S2MM for
one result per lane. `MYDMA_INFO_CMD` says which engines exist.

`bwtest` measures the weight lanes against `lane_checker.v` (a stand-in for
the array that returns one checksum beat per transfer); it needs a bitstream
built with `lane_checker` in the block design.

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
