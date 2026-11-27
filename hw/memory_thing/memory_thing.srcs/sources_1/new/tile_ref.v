`timescale 1ns / 1ps
// tile_ref.v - reference tile with the ports axi_controller expects.
//
// Decode only: it computes row 0 (one token) of the 16x16 tile, which is all
// decode needs. Use it to bring the whole chain up on the board, and as the
// contract your systolic tile has to meet:
//
//   * A step happens on a clock with t_valid = 1. Stalls (t_valid = 0) can
//     come at any time, so carry valid along with the data.
//   * t_a: byte i = A value for row i (decode: only byte 0 is real).
//     t_b: byte c = B value for column c (W[n0 + c][k]).
//     Both are E4M3 codes.
//   * t_clear (one clock) zeroes every sum. The controller sends it before a
//     group's first step, only while the tile is idle (no steps in flight,
//     t_c already read), so it needs no pipelining: apply it straight to the
//     accumulators (DSP48E2: RSTP). There are no start/end markers.
//   * Each product is exact: decode both codes to integers in units of 2^-9
//     (so the product is in units of 2^-18) and add into 44-bit signed sums.
//     That is fp8_golden.py's level 1, bit for bit.
//   * The tile's latency is fixed and known: t_c holds the final sums
//     LAT clocks after the clock edge that takes a group's last step.
//     Set the controller's TILE_LAT to it. HOLD t_c until t_clear; the
//     controller reads it before it clears.
//   * t_c: column c's sum (row 0) in bits [44c +: 44].
//
// Pipeline (one register after each step, for 250 MHz):
//   input regs -> decode -> pre-add (a or 2a) -> multiply -> accumulate
// The last step is registered on edge T and its sum lands on edge T + 4, so
// LAT = 4. Like pe_dsp48e2, the weight keeps one bit of its shift back so it
// fits the DSP's 18-bit B port, and A is doubled instead (d = 1): one
// 20 x 18 multiply per column, 16 DSPs. EXTRA_LAT delays t_c by that many
// more clocks (LAT = 4 + EXTRA_LAT), to imitate a bigger tile in simulation.

module tile_ref #(
    parameter N = 16,
    parameter EXTRA_LAT = 0
)(
    input  wire              aclk,
    input  wire              aresetn,
    input  wire              t_valid, t_clear,
    input  wire [8*N-1:0]    t_a,
    input  wire [8*N-1:0]    t_b,
    output wire [N*44-1:0]   t_c
);
    // Activation code -> value * 2^9 as a signed integer (fp8_golden E4M3_TO_INT9).
    // Normal: (8 + m) << (e - 1). Subnormal (e = 0): m. NaN codes 0x7F/0xFF -> 0.
    // Largest magnitude 448 -> 229376, so 19 bits signed.
    function signed [18:0] deca(input [7:0] c);
        reg [17:0] mag;
        begin
            if (c[6:0] == 7'h7f)      mag = 18'd0;
            else if (c[6:3] == 4'd0)  mag = {15'd0, c[2:0]};
            else                      mag = {14'd0, 1'b1, c[2:0]} << (c[6:3] - 1'b1);
            deca = c[7] ? -$signed({1'b0, mag}) : $signed({1'b0, mag});
        end
    endfunction

    // Weight code -> {d, b}: value * 2^9 = b * (d ? 2 : 1), b in 18 bits signed.
    //   e >= 2: b = (8 + m) << (e - 2), d = 1.   e = 1: b = 8 + m.   e = 0: b = m.
    function [18:0] decb(input [7:0] c);
        reg [16:0] mag;
        reg        d;
        begin
            d = (c[6:3] >= 4'd2);
            if (c[6:0] == 7'h7f)      mag = 17'd0;
            else if (c[6:3] == 4'd0)  mag = {14'd0, c[2:0]};
            else if (!d)              mag = {13'd0, 1'b1, c[2:0]};
            else                      mag = {13'd0, 1'b1, c[2:0]} << (c[6:3] - 4'd2);
            decb = {d, c[7] ? -$signed({1'b0, mag}) : $signed({1'b0, mag})};
        end
    endfunction

    reg [4:1]         v;                    // v[i]: stage i holds a real step (v[4]: m3)
    // ---- stage 1: input registers (t_a/t_b come straight from the controller's muxes) ----
    reg [7:0]         a0;
    reg [8*N-1:0]     b0;
    // ---- stage 2: decode ----
    reg signed [18:0] a1;
    reg signed [17:0] b1 [0:N-1];
    reg [N-1:0]       d1;
    // ---- stage 3: pre-add: a or 2a per column ----
    reg signed [19:0] ad2 [0:N-1];
    reg signed [17:0] b2  [0:N-1];
    // ---- stage 4: multiply ----
    reg signed [37:0] m3  [0:N-1];
    // ---- accumulate (lands on the 4th edge) ----
    reg signed [43:0] acc [0:N-1];

    integer c;
    always @(posedge aclk) begin
        if (!aresetn) v <= 0;
        else          v <= {v[3:1], t_valid};

        a0 <= t_a[7:0];
        b0 <= t_b;

        a1 <= deca(a0);
        for (c = 0; c < N; c = c + 1) {d1[c], b1[c]} <= decb(b0[8*c +: 8]);

        for (c = 0; c < N; c = c + 1) begin
            ad2[c] <= d1[c] ? (a1 <<< 1) : a1;
            b2[c]  <= b1[c];
        end

        for (c = 0; c < N; c = c + 1) m3[c] <= ad2[c] * b2[c];

        // t_clear only comes while the tile is idle, so it goes straight to the sums
        if (!aresetn || t_clear)
            for (c = 0; c < N; c = c + 1) acc[c] <= 44'sd0;
        else if (v[4])
            for (c = 0; c < N; c = c + 1) acc[c] <= acc[c] + m3[c];
    end

    wire [N*44-1:0] acc_flat;
    genvar gc;
    generate for (gc = 0; gc < N; gc = gc + 1) begin : C
        assign acc_flat[gc*44 +: 44] = acc[gc];
    end endgenerate

    // optional extra latency on t_c (simulation only)
    generate if (EXTRA_LAT == 0) begin : NO_DLY
        assign t_c = acc_flat;
    end else begin : DLY
        reg [N*44-1:0] sh [0:EXTRA_LAT-1];
        integer i;
        always @(posedge aclk) begin
            sh[0] <= acc_flat;
            for (i = 1; i < EXTRA_LAT; i = i + 1) sh[i] <= sh[i-1];
        end
        assign t_c = sh[EXTRA_LAT-1];
    end endgenerate
endmodule
