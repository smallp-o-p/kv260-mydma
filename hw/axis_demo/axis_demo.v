// axis_demo.v - the smallest useful PL block with all three AXI interfaces
// this project needs. Copy it as the starting point for a new block.
//
//   s_axis  AXI4-Stream IN   data from a DMA's M_AXIS_MM2S (memory -> PL)
//   m_axis  AXI4-Stream OUT  data to a DMA's S_AXIS_S2MM   (PL -> memory)
//   s_axil  AXI4-Lite slave  control/status registers the CPU reads and writes
//
// What it does: every 32-bit word of the stream gets ADD added to it
// (ADD = 1 after reset, so out of the box it behaves like axis_incrementer).
// It also counts beats and packets so software can see what went through.
//
// Registers (byte offsets from the block's base address, all 32 bits):
//   0x00  ID       RO  32'hA5D0_0001, to check the address is right
//   0x04  ADD      RW  added to every 32-bit word (reset value 1)
//   0x08  BEATS    RO  input beats accepted since the last clear
//   0x0C  PACKETS  RO  output packets (TLASTs) sent since the last clear
//   0x10  CTRL     WO  write bit 0 = 1 to clear BEATS and PACKETS
//
// ---- AXI4-Stream in one paragraph ----------------------------------------
// A beat moves on a clock edge where TVALID && TREADY are both 1. The sender
// raises TVALID when it has data and must hold TDATA/TLAST steady until the
// beat moves; it may not wait for TREADY before raising TVALID. The receiver
// raises TREADY when it can take data, and may do so before or after TVALID.
// TLAST marks the last beat of a packet; the AXI DMA ends an S2MM transfer
// on it, so the output must carry a TLAST or the S2MM never completes.
// TKEEP says which bytes are valid; the AXI DMA only sends partial TKEEP on
// the last beat of a transfer whose length isn't a multiple of the width.
//
// ---- How the stream path below obeys that ---------------------------------
// One register stage (out_*) between input and output:
//   s_axis_tready = !out_valid || m_axis_tready
// i.e. "I can take a beat if my output register is empty, or it empties this
// cycle." That keeps full rate (one beat per clock) under any back-pressure
// pattern, and every output is a flop, which helps timing at 250 MHz. Any
// pipelined datapath can use the same pattern, one stage at a time.
//
// In Vivado: Add Sources > this file. In the block design, right-click >
// Add Module > axis_demo. The X_INTERFACE attributes make Vivado show
// s_axis, m_axis and s_axil as interfaces, so they connect in one wire each
// and Connection Automation can hook s_axil to the PS. hw/axis_demo/build_bd.tcl
// builds a whole test design around it.
`timescale 1ns / 1ps

module axis_demo #(
    parameter integer DATA_WIDTH = 128,   // stream width; a multiple of 32
    parameter integer ADDR_WIDTH = 12     // AXI-Lite address bits (4 KiB window)
) (
    // One clock and one reset for all three interfaces. ASSOCIATED_BUSIF
    // tells Vivado which interfaces run on this clock.
    (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 aclk CLK" *)
    (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF s_axis:m_axis:s_axil, ASSOCIATED_RESET aresetn" *)
    input  wire                    aclk,
    (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 aresetn RST" *)
    (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_LOW" *)
    input  wire                    aresetn,

    // ---- AXI4-Stream slave (input) ----
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TDATA" *)
    input  wire [DATA_WIDTH-1:0]   s_axis_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TKEEP" *)
    input  wire [DATA_WIDTH/8-1:0] s_axis_tkeep,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TLAST" *)
    input  wire                    s_axis_tlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TVALID" *)
    input  wire                    s_axis_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_axis TREADY" *)
    output wire                    s_axis_tready,

    // ---- AXI4-Stream master (output) ----
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis TDATA" *)
    output wire [DATA_WIDTH-1:0]   m_axis_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis TKEEP" *)
    output wire [DATA_WIDTH/8-1:0] m_axis_tkeep,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis TLAST" *)
    output wire                    m_axis_tlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis TVALID" *)
    output wire                    m_axis_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_axis TREADY" *)
    input  wire                    m_axis_tready,

    // ---- AXI4-Lite slave (registers) ----
    // Write address
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axil AWADDR" *)
    (* X_INTERFACE_PARAMETER = "PROTOCOL AXI4LITE" *)
    input  wire [ADDR_WIDTH-1:0]   s_axil_awaddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axil AWPROT" *)
    input  wire [2:0]              s_axil_awprot,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axil AWVALID" *)
    input  wire                    s_axil_awvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axil AWREADY" *)
    output wire                    s_axil_awready,
    // Write data
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axil WDATA" *)
    input  wire [31:0]             s_axil_wdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axil WSTRB" *)
    input  wire [3:0]              s_axil_wstrb,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axil WVALID" *)
    input  wire                    s_axil_wvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axil WREADY" *)
    output wire                    s_axil_wready,
    // Write response
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axil BRESP" *)
    output wire [1:0]              s_axil_bresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axil BVALID" *)
    output reg                     s_axil_bvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axil BREADY" *)
    input  wire                    s_axil_bready,
    // Read address
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axil ARADDR" *)
    input  wire [ADDR_WIDTH-1:0]   s_axil_araddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axil ARPROT" *)
    input  wire [2:0]              s_axil_arprot,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axil ARVALID" *)
    input  wire                    s_axil_arvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axil ARREADY" *)
    output wire                    s_axil_arready,
    // Read data
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axil RDATA" *)
    output reg  [31:0]             s_axil_rdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axil RRESP" *)
    output wire [1:0]              s_axil_rresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axil RVALID" *)
    output reg                     s_axil_rvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axil RREADY" *)
    input  wire                    s_axil_rready
);
    localparam [31:0] ID = 32'hA5D0_0001;
    localparam integer WORDS = DATA_WIDTH / 32;

    // =========================================================================
    // Registers
    // =========================================================================
    reg  [31:0] reg_add;
    reg  [31:0] reg_beats;
    reg  [31:0] reg_packets;

    // =========================================================================
    // Stream path: input -> (add ADD to each 32-bit word) -> output register
    // =========================================================================
    reg  [DATA_WIDTH-1:0]   out_data;
    reg  [DATA_WIDTH/8-1:0] out_keep;
    reg                     out_last;
    reg                     out_valid;

    assign s_axis_tready = !out_valid || m_axis_tready;
    wire   in_beat  = s_axis_tvalid && s_axis_tready;   // a beat moves in
    wire   out_beat = out_valid && m_axis_tready;       // a beat moves out

    // The "computation". Replace this with your own datapath.
    reg [DATA_WIDTH-1:0] result;
    integer w;
    always @(*) begin
        for (w = 0; w < WORDS; w = w + 1)
            result[w*32 +: 32] = s_axis_tdata[w*32 +: 32] + reg_add;
    end

    always @(posedge aclk) begin
        if (!aresetn) begin
            out_valid <= 1'b0;
        end else if (in_beat) begin
            out_data  <= result;           // load only when a beat comes in,
            out_keep  <= s_axis_tkeep;     // so the output holds steady while
            out_last  <= s_axis_tlast;     // it waits for TREADY
            out_valid <= 1'b1;
        end else if (out_beat) begin
            out_valid <= 1'b0;             // sent, and nothing new came in
        end
    end

    assign m_axis_tdata  = out_data;
    assign m_axis_tkeep  = out_keep;
    assign m_axis_tlast  = out_last;
    assign m_axis_tvalid = out_valid;

    // =========================================================================
    // AXI4-Lite slave
    //
    // Five channels, each with its own VALID/READY handshake, same rule as
    // the stream: a transfer happens when VALID && READY.
    //   Write: AW (address) and W (data) may arrive in either order or
    //   together. Take each one when it comes, do the write once both are
    //   in, then answer on B. Don't take new ones until B is accepted.
    //   Read: take AR, answer on R one cycle later. Don't take a new AR until
    //   R is accepted.
    // RESP = 2'b00 (OKAY) always; unknown addresses read 0, writes ignored.
    // =========================================================================
    reg                  aw_full, w_full;
    reg [ADDR_WIDTH-1:0] aw_addr;
    reg [31:0]           w_data;
    reg [3:0]            w_strb;

    assign s_axil_awready = !aw_full && !s_axil_bvalid;
    assign s_axil_wready  = !w_full  && !s_axil_bvalid;
    assign s_axil_bresp   = 2'b00;
    assign s_axil_arready = !s_axil_rvalid;
    assign s_axil_rresp   = 2'b00;

    // The address and data of the write, whether they arrive now or earlier.
    wire                  aw_now   = s_axil_awvalid && s_axil_awready;
    wire                  w_now    = s_axil_wvalid  && s_axil_wready;
    wire [ADDR_WIDTH-1:0] wr_addr  = aw_full ? aw_addr : s_axil_awaddr;
    wire [31:0]           wr_data  = w_full  ? w_data  : s_axil_wdata;
    wire [3:0]            wr_strb  = w_full  ? w_strb  : s_axil_wstrb;
    wire                  do_write = (aw_full || aw_now) && (w_full || w_now);
    wire                  clear    = do_write && wr_addr[4:2] == 3'd4 && wr_strb[0] && wr_data[0];

    integer b;
    always @(posedge aclk) begin
        if (!aresetn) begin
            aw_full       <= 1'b0;
            w_full        <= 1'b0;
            s_axil_bvalid <= 1'b0;
            reg_add       <= 32'd1;
        end else begin
            if (do_write) begin
                aw_full       <= 1'b0;
                w_full        <= 1'b0;
                s_axil_bvalid <= 1'b1;
                if (wr_addr[4:2] == 3'd1)              // 0x04 ADD
                    for (b = 0; b < 4; b = b + 1)
                        if (wr_strb[b])
                            reg_add[b*8 +: 8] <= wr_data[b*8 +: 8];
            end else begin
                if (aw_now) begin aw_full <= 1'b1; aw_addr <= s_axil_awaddr; end
                if (w_now)  begin w_full  <= 1'b1; w_data  <= s_axil_wdata; w_strb <= s_axil_wstrb; end
            end
            if (s_axil_bvalid && s_axil_bready)
                s_axil_bvalid <= 1'b0;
        end
    end

    always @(posedge aclk) begin
        if (!aresetn) begin
            s_axil_rvalid <= 1'b0;
            s_axil_rdata  <= 32'd0;
        end else if (s_axil_arvalid && s_axil_arready) begin
            s_axil_rvalid <= 1'b1;
            case (s_axil_araddr[4:2])
                3'd0:    s_axil_rdata <= ID;
                3'd1:    s_axil_rdata <= reg_add;
                3'd2:    s_axil_rdata <= reg_beats;
                3'd3:    s_axil_rdata <= reg_packets;
                default: s_axil_rdata <= 32'd0;
            endcase
        end else if (s_axil_rvalid && s_axil_rready) begin
            s_axil_rvalid <= 1'b0;
        end
    end

    // Status counters (cleared by CTRL bit 0).
    always @(posedge aclk) begin
        if (!aresetn || clear) begin
            reg_beats   <= 32'd0;
            reg_packets <= 32'd0;
        end else begin
            if (in_beat)
                reg_beats <= reg_beats + 32'd1;
            if (out_beat && out_last)
                reg_packets <= reg_packets + 32'd1;
        end
    end

    // Unused AXI-Lite inputs (PROT is for secure/privileged accesses).
    wire _unused = &{1'b0, s_axil_awprot, s_axil_arprot};
endmodule
