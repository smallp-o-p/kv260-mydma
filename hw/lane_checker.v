// lane_checker.v - stand-in for the matmul array in the multi_hp shell.
//
// Consumes the four weight streams (w0..w3) and the activation stream (act)
// at full rate, and for every packet (one DMA transfer, ended by TLAST) it
// writes ONE 128-bit result beat to the activation DMA's S2MM. So the data
// flow is already the final one: four readers in, one writer out, and the
// S2MM completion tells the driver the "computation" is done.
//
// Result beat (128 bits, TLAST=1 on every beat):
//   [63:0]    XOR of every input beat, folded to 64 bits (beat[127:64] ^ beat[63:0])
//   [95:64]   number of beats in the packet
//   [103:96]  input: 0..3 = w0..w3, 4 = act
//   [127:104] 24'hC0FFEE, so a stale or zero buffer can't pass for a result
// Software recomputes the XOR and count over its own buffer and compares.
//
// Beats go out in the order the packets finish. While a lane's result is
// waiting to go out, that lane holds TREADY low, so nothing is lost if the
// next transfer starts before the S2MM has taken the result.
//
// In Vivado: Add Sources > this file, then Add Module > lane_checker. The
// X_INTERFACE attributes give it AXI-Stream ports s_w0..s_w3, s_act, m_res.
`timescale 1ns / 1ps

module lane_checker (
    (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 aclk CLK" *)
    (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF s_w0:s_w1:s_w2:s_w3:s_act:m_res, ASSOCIATED_RESET aresetn" *)
    input  wire         aclk,
    (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 aresetn RST" *)
    (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_LOW" *)
    input  wire         aresetn,

    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w0 TDATA" *)  input  wire [127:0] s_w0_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w0 TKEEP" *)  input  wire [15:0]  s_w0_tkeep,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w0 TLAST" *)  input  wire         s_w0_tlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w0 TVALID" *) input  wire         s_w0_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w0 TREADY" *) output wire         s_w0_tready,

    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w1 TDATA" *)  input  wire [127:0] s_w1_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w1 TKEEP" *)  input  wire [15:0]  s_w1_tkeep,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w1 TLAST" *)  input  wire         s_w1_tlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w1 TVALID" *) input  wire         s_w1_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w1 TREADY" *) output wire         s_w1_tready,

    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w2 TDATA" *)  input  wire [127:0] s_w2_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w2 TKEEP" *)  input  wire [15:0]  s_w2_tkeep,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w2 TLAST" *)  input  wire         s_w2_tlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w2 TVALID" *) input  wire         s_w2_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w2 TREADY" *) output wire         s_w2_tready,

    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w3 TDATA" *)  input  wire [127:0] s_w3_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w3 TKEEP" *)  input  wire [15:0]  s_w3_tkeep,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w3 TLAST" *)  input  wire         s_w3_tlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w3 TVALID" *) input  wire         s_w3_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w3 TREADY" *) output wire         s_w3_tready,

    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_act TDATA" *)  input  wire [127:0] s_act_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_act TKEEP" *)  input  wire [15:0]  s_act_tkeep,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_act TLAST" *)  input  wire         s_act_tlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_act TVALID" *) input  wire         s_act_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_act TREADY" *) output wire         s_act_tready,

    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_res TDATA" *)  output wire [127:0] m_res_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_res TKEEP" *)  output wire [15:0]  m_res_tkeep,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_res TLAST" *)  output wire         m_res_tlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_res TVALID" *) output wire         m_res_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_res TREADY" *) input  wire         m_res_tready
);
    localparam N = 5;

    wire [127:0] tdata  [0:N-1];
    wire [N-1:0] tvalid, tlast;
    assign tdata[0] = s_w0_tdata;  assign tdata[1] = s_w1_tdata;
    assign tdata[2] = s_w2_tdata;  assign tdata[3] = s_w3_tdata;
    assign tdata[4] = s_act_tdata;
    assign tvalid = {s_act_tvalid, s_w3_tvalid, s_w2_tvalid, s_w1_tvalid, s_w0_tvalid};
    assign tlast  = {s_act_tlast,  s_w3_tlast,  s_w2_tlast,  s_w1_tlast,  s_w0_tlast};

    wire [N-1:0] pending;                 // result latched, not yet sent
    wire [N-1:0] tready = ~pending;
    assign {s_act_tready, s_w3_tready, s_w2_tready, s_w1_tready, s_w0_tready} = tready;

    wire [63:0] res_x [0:N-1];            // finished packet, waiting to go out
    wire [31:0] res_n [0:N-1];

    // Output: lowest-numbered pending lane goes first.
    reg [2:0] sel;
    integer j;
    always @(*) begin
        sel = 3'd0;
        for (j = N - 1; j >= 0; j = j - 1)
            if (pending[j])
                sel = j;
    end
    assign m_res_tvalid = |pending;
    assign m_res_tdata  = {24'hC0FFEE, 5'd0, sel, res_n[sel], res_x[sel]};
    assign m_res_tkeep  = 16'hFFFF;
    assign m_res_tlast  = 1'b1;
    wire   sent = m_res_tvalid && m_res_tready;

    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin : lane
            reg  [63:0] acc_x, rx;        // running XOR / finished XOR
            reg  [31:0] acc_n, rn;        // beats so far / finished count
            reg         pend;
            wire        take = tvalid[i] && !pend;
            wire [63:0] fold = tdata[i][127:64] ^ tdata[i][63:0];

            assign pending[i] = pend;
            assign res_x[i]   = rx;
            assign res_n[i]   = rn;

            always @(posedge aclk) begin
                if (!aresetn) begin
                    acc_x <= 64'd0;
                    acc_n <= 32'd0;
                    rx    <= 64'd0;
                    rn    <= 32'd0;
                    pend  <= 1'b0;
                end else if (take && tlast[i]) begin
                    rx    <= acc_x ^ fold;
                    rn    <= acc_n + 32'd1;
                    acc_x <= 64'd0;
                    acc_n <= 32'd0;
                    pend  <= 1'b1;        // take is 0 while pend, so no clash with sent
                end else begin
                    if (take) begin
                        acc_x <= acc_x ^ fold;
                        acc_n <= acc_n + 32'd1;
                    end
                    if (sent && sel == i)
                        pend <= 1'b0;
                end
            end
        end
    endgenerate
endmodule
