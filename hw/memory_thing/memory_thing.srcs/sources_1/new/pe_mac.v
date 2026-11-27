`timescale 1ns / 1ps
// pe_mac.v - one processing element (PE) = one multiply-accumulate.
//
// It has exactly the DSP48E2's pipeline, so Vivado packs each PE into one DSP:
//   stage 1  register a, b, d_en                (AREG/DREG, BREG, INMODEREG)
//   stage 2  pre-add: ad = d_en ? 2a : a        (ADREG)
//   stage 3  multiply: m = ad * b               (MREG)
//   stage 4  accumulate: p = p + m              (PREG)
// One new product can enter every clock. A product presented with ce = 1
// before clock edge E is in p after edge E + 3 (the 4th edge).
//
// a and b are exact integers (E4M3 value * 2^9, see systolic_tile.v), so the
// product and the sum are exact too. clr zeroes the sum; the tile only pulses
// it while nothing is in flight (on a DSP48E2 this is RSTP).
// Same PE as fp8-flow/rtl/pe_mac.v, with clr in place of `first`.

module pe_mac (
    input  wire               clk,
    input  wire               clr,     // 1 = zero the sum (only when idle)
    input  wire               ce,      // 1 = a real k-step is entering this clock
    input  wire signed [19:0] a,       // activation, from the row decoder
    input  wire signed [17:0] b,       // weight, from the column decoder
    input  wire               d_en,    // weight decoder: double a
    output reg  signed [47:0] p        // the sum (exact)
);
    reg signed [19:0] a1;
    reg signed [17:0] b1, b2;
    reg               d1, v1, v2, v3;
    reg signed [20:0] ad2;
    reg signed [38:0] m3;

    initial begin v1 = 0; v2 = 0; v3 = 0; end   // FPGA registers power up at 0

    always @(posedge clk) begin
        // stage 1
        a1 <= a;  b1 <= b;  d1 <= d_en;  v1 <= ce;
        // stage 2
        ad2 <= d1 ? (a1 <<< 1) : a1;  b2 <= b1;  v2 <= v1;
        // stage 3
        m3 <= ad2 * b2;  v3 <= v2;
        // stage 4
        if (clr)     p <= 48'sd0;
        else if (v3) p <= p + m3;
    end
endmodule
