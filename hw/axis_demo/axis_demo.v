// axis_demo.v - the smallest useful PL block with an AXI4-Stream input and
// an AXI4-Stream output. Copy it as the starting point for a new block.
//
//   s_axis  AXI4-Stream IN   data from a DMA's M_AXIS_MM2S (memory -> PL)
//   m_axis  AXI4-Stream OUT  data to a DMA's S_AXIS_S2MM   (PL -> memory)
//
// What it does: every 32-bit word of the stream gets ADD added to it
// (parameter, default 1, so out of the box it behaves like axis_incrementer).
// There are no CPU-visible registers: like lane_checker, everything the
// block needs arrives on the stream, and the DMA sets the lengths.
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
// s_axis and m_axis as one interface each, so each connects with one wire.
// hw/axis_demo/build_bd.tcl builds a whole test design around it.
`timescale 1ns / 1ps

module axis_demo #(
    parameter integer DATA_WIDTH = 128,   // stream width; a multiple of 32
    parameter [31:0]  ADD        = 32'd1  // added to every 32-bit word
) (
    // One clock and one reset for both interfaces. ASSOCIATED_BUSIF tells
    // Vivado which interfaces run on this clock.
    (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 aclk CLK" *)
    (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF s_axis:m_axis, ASSOCIATED_RESET aresetn" *)
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
    input  wire                    m_axis_tready
);
    localparam integer WORDS = DATA_WIDTH / 32;

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
            result[w*32 +: 32] = s_axis_tdata[w*32 +: 32] + ADD;
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
endmodule
