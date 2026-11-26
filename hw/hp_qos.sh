#!/bin/sh
# hp_qos.sh - read and set the PS-side knobs on the PL -> DDR read path.
#
#   sudo ./hp_qos.sh dump                 # print everything below, change nothing
#   sudo ./hp_qos.sh issue N [ports]      # read issuing capability, N = 1..16 commands
#   sudo ./hp_qos.sh qos V [ports]        # static read QoS (AxQOS), V = 0..15
#   sudo ./hp_qos.sh pagematch on|off     # DDRC page-match on DDR ports 3-5 (see below)
#
# [ports] is a space-separated list of hpc0 hpc1 hp0 hp1 hp2 hp3 (default:
# all six). Settings last until reboot; nothing is written to flash. Run
# `dump` first and keep its output, so you can put values back by hand.
#
# AFIFM registers (one block per PL slave port, UG1087 / "Traffic Shaping of
# HP Ports on Zynq UltraScale+" on the Xilinx wiki). They're documented as
# safe to change at run time:
#   +0x00 RDCTRL   bit 2 FABRIC_QOS_EN: 0 = use RDQOS below, 1 = use the PL's
#                  ARQOS pins. Bits [1:0] are the port width; never touched here.
#   +0x04 RDISSUE  [3:0] outstanding read commands minus 1
#   +0x08 RDQOS    [3:0] static ARQOS
# The DDR controller's port arbiter uses ARQOS directly as port priority. With
# the usual PCFGQOS0 map (level1 = 3), ARQOS 0..3 all stay in the LPR (best
# effort) class, so 0..3 changes only arbitration, not the traffic class.
#
# DDRC (0xFD070000): PCCFG at +0x400, then per port n = 0..5 at stride 0xB0:
#   PCFGR_n +0x404 (bit 14 rd_port_pagematch_en, bit 13 urgent, bit 12 aging,
#   [9:0] priority), PCFGQOS0_n +0x494. `pagematch` changes the DDRC while
#   traffic is live. I haven't found a promise that this is safe at run time,
#   so it could hang the board (a power cycle fixes that). Try it last.

set -e

DEVMEM=${DEVMEM:-devmem}

afi_base() {
    case "$1" in
        hpc0) echo 0xFD360000 ;;
        hpc1) echo 0xFD370000 ;;
        hp0)  echo 0xFD380000 ;;
        hp1)  echo 0xFD390000 ;;
        hp2)  echo 0xFD3A0000 ;;
        hp3)  echo 0xFD3B0000 ;;
        *) echo "unknown port '$1' (want hpc0 hpc1 hp0 hp1 hp2 hp3)" >&2; exit 2 ;;
    esac
}

rd() { $DEVMEM "$(printf '0x%X' "$1")" 32; }
wr() { $DEVMEM "$(printf '0x%X' "$1")" 32 "$(printf '0x%08X' "$2")"; }

# Replace the bits in mask with val (already shifted), keep the rest.
rmw() {
    old=$(rd "$1")
    new=$(( (old & ~($2)) | ($3) ))
    wr "$1" "$new"
    printf '  0x%X: 0x%08X -> 0x%08X\n' "$1" "$old" "$new"
}

ALL="hpc0 hpc1 hp0 hp1 hp2 hp3"
DDRC=0xFD070000

cmd=${1:-dump}
[ $# -gt 0 ] && shift

case "$cmd" in
dump)
    printf '%-5s %-10s %-10s %-10s  %s\n' port RDCTRL RDISSUE RDQOS "-> qos source, outstanding, qos"
    for p in $ALL; do
        b=$(afi_base "$p")
        c=$(rd $((b + 0x0))); i=$(rd $((b + 0x4))); q=$(rd $((b + 0x8)))
        src=static; [ $(( c & 4 )) -ne 0 ] && src=PL
        printf '%-5s 0x%08X 0x%08X 0x%08X  -> %s, %d, %d\n' "$p" "$c" "$i" "$q" \
            "$src" $(( (i & 15) + 1 )) $(( q & 15 ))
    done
    printf '\nDDRC PCCFG 0x%08X\n' "$(rd $((DDRC + 0x400)))"
    printf '%-6s %-10s %-10s  %s\n' "port" PCFGR PCFGQOS0 "-> pagematch, priority"
    n=0
    while [ $n -le 5 ]; do
        r=$(rd $((DDRC + 0x404 + n * 0xB0))); q=$(rd $((DDRC + 0x494 + n * 0xB0)))
        printf 'ddr%-3d 0x%08X 0x%08X  -> %d, 0x%X\n' $n "$r" "$q" \
            $(( (r >> 14) & 1 )) $(( r & 0x3FF ))
        n=$((n + 1))
    done
    echo
    echo "DDR ports: 0 RPU, 1-2 CCI (CPUs, HPC0, HPC1), 3 HP0 + DisplayPort,"
    echo "           4 HP1 + HP2, 5 HP3 + FPD DMA"
    ;;
issue)
    n=${1:?usage: issue N [ports], N = 1..16}; shift
    [ "$n" -ge 1 ] && [ "$n" -le 16 ] || { echo "N must be 1..16" >&2; exit 2; }
    for p in ${*:-$ALL}; do
        echo "$p RDISSUE = $n"
        rmw $(( $(afi_base "$p") + 0x4 )) 0xF $((n - 1))
    done
    ;;
qos)
    v=${1:?usage: qos V [ports], V = 0..15}; shift
    [ "$v" -ge 0 ] && [ "$v" -le 15 ] || { echo "V must be 0..15" >&2; exit 2; }
    for p in ${*:-$ALL}; do
        b=$(afi_base "$p")
        echo "$p RDQOS = $v (static)"
        rmw $((b + 0x0)) 0x4 0     # FABRIC_QOS_EN = 0: use RDQOS, not the PL pins
        rmw $((b + 0x8)) 0xF "$v"
    done
    ;;
pagematch)
    case "${1:-}" in on) bit=0x4000 ;; off) bit=0 ;; *) echo "usage: pagematch on|off" >&2; exit 2 ;; esac
    for n in 3 4 5; do
        echo "ddr$n rd_port_pagematch_en = ${1}"
        rmw $((DDRC + 0x404 + n * 0xB0)) 0x4000 "$bit"
    done
    ;;
*)
    sed -n '2,8p' "$0" >&2; exit 2 ;;
esac
