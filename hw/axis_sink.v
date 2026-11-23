// axis_sink.v - an AXI4-Stream slave that accepts every beat and drops it.
//
// Put one on each weight engine's M_AXIS_MM2S while measuring bandwidth, so
// the stream side never slows the DMA down and only the HP port and DDR set
// the rate. The counters are there for an ILA (or a later AXI-Lite readout):
// beats and a running XOR of the data, cleared by reset.
//
// In Vivado: Add Sources > this file, then right-click the block design >
// Add Module > axis_sink. The X_INTERFACE attributes make Vivado show
// s_axis as one AXI-Stream port you can wire to M_AXIS_MM2S in one go.
`timescale 1ns / 1ps

module axis_sink #(
    parameter integer DATA_WIDTH = 128
) (
    (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 aclk CLK" *)
    (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF s_axis, ASSOCIATED_RESET aresetn" *)
    input  wire                    aclk,
    (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 aresetn RST" *)
    (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_LOW" *)
    input  wire                    aresetn,

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

    output reg  [31:0]             beats,     // beats accepted since reset
    output reg  [31:0]             packets,   // TLASTs seen (one per transfer)
    output reg  [DATA_WIDTH-1:0]   xor_acc    // XOR of all accepted data
);
    assign s_axis_tready = 1'b1;

    always @(posedge aclk) begin
        if (!aresetn) begin
            beats   <= 32'd0;
            packets <= 32'd0;
            xor_acc <= {DATA_WIDTH{1'b0}};
        end else if (s_axis_tvalid) begin
            beats   <= beats + 32'd1;
            packets <= packets + {31'd0, s_axis_tlast};
            xor_acc <= xor_acc ^ s_axis_tdata;
        end
    end
endmodule
