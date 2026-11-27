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
//   * t_first marks k = 0 of a K-group: start the sums from this product
//     (no separate clear). t_last marks k = 127.
//   * Each product is exact: decode both codes to integers in units of 2^-9
//     (so the product is in units of 2^-18) and add into 44-bit signed sums.
//     That is fp8_golden.py's level 1, bit for bit.
//   * Pulse t_done once the step marked t_last has been added everywhere.
//     Then HOLD t_c until the next t_first. The controller reads it after
//     t_done and won't send the next group before it has.
//   * t_c: column c's sum (row 0) in bits [44c +: 44].
//
// Pipeline: decode (1) -> multiply (1) -> accumulate (1). 16 multipliers of
// 19 x 19 bits, so 16 DSPs. EXTRA_DONE_DELAY only makes t_done later (to
// imitate a bigger tile in simulation).

module tile_ref #(
    parameter N = 16,
    parameter EXTRA_DONE_DELAY = 0
)(
    input  wire              aclk,
    input  wire              aresetn,
    input  wire              t_valid, t_first, t_last,
    input  wire [8*N-1:0]    t_a,
    input  wire [8*N-1:0]    t_b,
    output wire              t_done,
    output wire [N*44-1:0]   t_c
);
    // E4M3 code -> value * 2^9 as a signed integer (fp8_golden E4M3_TO_INT9).
    // Normal: (8 + m) << (e - 1). Subnormal (e = 0): m. NaN codes 0x7F/0xFF -> 0.
    // Largest magnitude 448 -> 229376, so 19 bits signed.
    function signed [18:0] dec(input [7:0] c);
        reg [17:0] mag;
        begin
            if (c[6:0] == 7'h7f)      mag = 18'd0;
            else if (c[6:3] == 4'd0)  mag = {15'd0, c[2:0]};
            else                      mag = {14'd0, 1'b1, c[2:0]} << (c[6:3] - 1'b1);
            dec = c[7] ? -$signed({1'b0, mag}) : $signed({1'b0, mag});
        end
    endfunction

    // ---- stage 1: decode ----
    reg               v1, f1, l1;
    reg signed [18:0] a1;
    reg signed [18:0] b1 [0:N-1];
    // ---- stage 2: multiply ----
    reg               v2, f2, l2;
    reg signed [36:0] p2 [0:N-1];
    // ---- stage 3: accumulate ----
    reg signed [43:0] acc [0:N-1];
    reg               done3;

    integer c;
    always @(posedge aclk) begin
        if (!aresetn) begin
            v1 <= 0; v2 <= 0; done3 <= 0;
        end else begin
            v1 <= t_valid; f1 <= t_first; l1 <= t_last;
            a1 <= dec(t_a[7:0]);
            for (c = 0; c < N; c = c + 1) b1[c] <= dec(t_b[8*c +: 8]);

            v2 <= v1; f2 <= f1; l2 <= l1;
            for (c = 0; c < N; c = c + 1) p2[c] <= a1 * b1[c];

            done3 <= v2 && l2;
            if (v2)
                for (c = 0; c < N; c = c + 1)
                    acc[c] <= (f2 ? 44'sd0 : acc[c]) + p2[c];
        end
    end

    genvar gc;
    generate for (gc = 0; gc < N; gc = gc + 1) begin : C
        assign t_c[gc*44 +: 44] = acc[gc];
    end endgenerate

    // optional extra latency on t_done only
    generate if (EXTRA_DONE_DELAY == 0) begin : NO_DLY
        assign t_done = done3;
    end else begin : DLY
        reg [EXTRA_DONE_DELAY-1:0] sh;
        always @(posedge aclk)
            if (!aresetn) sh <= 0;
            else          sh <= {sh, done3};      // MSB falls off
        assign t_done = sh[EXTRA_DONE_DELAY-1];
    end endgenerate
endmodule
