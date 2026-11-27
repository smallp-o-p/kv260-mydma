`timescale 1ns / 1ps
// systolic_tile.v - output-stationary systolic array of pe_mac PEs.
// Same ports as tile_ref.v, so it drops in behind axi_controller.
//
//                 b[0]   b[1]   b[2]  ...  b[N-1]     (weights, one per column)
//                  |      |      |           |
//   a[0] ------> PE00 -> PE01 -> PE02 ... -> PE0,N-1   row 0 = token 0
//                  v      v      v           v
//   a[1] ------> PE10 -> PE11 -> ...                   row 1 = token 1
//                  v      v
//   ...                                                (ROWS rows)
//
//   * a moves one PE to the right every clock, b moves one PE down every
//     clock. Each PE multiplies what passes through it and keeps its own sum
//     (output-stationary): PE(r, c) ends up with sum over k of a[r][k] * b[c][k].
//   * So that a[r][k] and b[c][k] meet in PE(r, c) on the same clock, the
//     inputs are skewed: row r's a enters r clocks late, column c's b enters
//     c clocks late. PE(r, c) then sees step k exactly r + c clocks after
//     PE(0, 0) does.
//   * Nothing ever stalls inside: data moves every clock, and a valid bit
//     travels with each step (vs). A PE only adds when its valid bit is 1.
//
// Contract with axi_controller (same as tile_ref):
//   t_valid   a step: t_a byte r = row r's activation code, t_b byte c =
//             column c's weight code (E4M3 codes).
//   t_clear   zero every sum. Only comes while the tile is idle.
//   t_done    1 = no step in flight anywhere, every sum is final.
//   t_c       row 0's sums, column c in [44c +: 44]. Held until t_clear.
//
// ROWS = 1 is all decode needs (one token): a 1 x 16 slice of the array, 16
// DSPs. With ROWS up to 16 the full array is built, but the controller only
// sends row 0 and only reads row 0 today, so Vivado removes rows 1..15 again.
//
// Latency: a step taken on clock edge T is in PE(r, c)'s sum after edge
// T + 5 + r + c (input register, decode, then the PE's 4 stages, the first of
// which lands on edge T + 2 + r + c).

module systolic_tile #(
    parameter N    = 16,              // columns (weights per step); t_b is 8*N bits
    parameter ROWS = 1                // rows (tokens), 1..N
)(
    input  wire              aclk,
    input  wire              aresetn,
    input  wire              t_valid, t_clear,
    input  wire [8*N-1:0]    t_a,
    input  wire [8*N-1:0]    t_b,
    output reg               t_done,
    output wire [N*44-1:0]   t_c
);
    // ------------------------------------------------------------------
    // Decoders: E4M3 code -> exact integer (value * 2^9).
    //   normal (e >= 1): (8 + m) << (e - 1).   subnormal (e = 0): m.
    //   NaN codes 0x7F / 0xFF -> 0.
    // The weight keeps one bit of its shift back so it fits the DSP's 18-bit
    // B port: value * 2^9 = b * (d ? 2 : 1), and the PE doubles a when d = 1.
    // ------------------------------------------------------------------
    function signed [19:0] deca(input [7:0] c);
        reg [18:0] mag;
        begin
            if (c[6:0] == 7'h7f)      mag = 19'd0;
            else if (c[6:3] == 4'd0)  mag = {16'd0, c[2:0]};
            else                      mag = {15'd0, 1'b1, c[2:0]} << (c[6:3] - 1'b1);
            deca = c[7] ? -$signed({1'b0, mag}) : $signed({1'b0, mag});
        end
    endfunction

    function [18:0] decb(input [7:0] c);     // {d, b[17:0]}
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

    // ------------------------------------------------------------------
    // Valid shift register: vs[i] = 1 in the clock after edge T + i for a
    // step taken on edge T. PE(r, c) uses vs[1 + r + c] as its ce. The far
    // corner's sum lands on edge T + ROWS + N + 3, so the step is "in flight"
    // while any of vs[0 .. ROWS+N+2] is set.
    // ------------------------------------------------------------------
    localparam VW = ROWS + N + 3;
    reg [VW-1:0] vs;
    always @(posedge aclk) begin
        if (!aresetn) begin
            vs     <= {VW{1'b0}};
            t_done <= 1'b1;
        end else begin
            vs     <= {vs[VW-2:0], t_valid};
            t_done <= !t_valid && (vs[VW-2:0] == 0);   // = "the new vs is all 0", registered
        end
    end

    // ------------------------------------------------------------------
    // Input registers, then decode (2 clocks).
    // ------------------------------------------------------------------
    reg  [8*ROWS-1:0]  a0;
    reg  [8*N-1:0]     b0;
    reg  signed [19:0] a1 [0:ROWS-1];
    reg  signed [17:0] b1 [0:N-1];
    reg  [N-1:0]       d1;
    integer i;
    always @(posedge aclk) begin
        a0 <= t_a[8*ROWS-1:0];
        b0 <= t_b;
        for (i = 0; i < ROWS; i = i + 1) a1[i] <= deca(a0[8*i +: 8]);
        for (i = 0; i < N; i = i + 1)    {d1[i], b1[i]} <= decb(b0[8*i +: 8]);
    end

    // ------------------------------------------------------------------
    // The array. PE(r, c) is entry r*N + c of these:
    //   ah / bv / dv    what the PE sees this clock
    //   ah_q            the same a one clock later, for the PE on the right
    //   bv_q / dv_q     the same b one clock later, for the PE below
    //   left edge : row r's a, delayed r clocks (the input skew)
    //   top edge  : column c's b, delayed c clocks
    // ------------------------------------------------------------------
    wire signed [19:0] a_in [0:ROWS-1];          // skewed inputs
    wire signed [17:0] b_in [0:N-1];
    wire               d_in [0:N-1];

    wire signed [19:0] ah   [0:ROWS*N-1];
    wire signed [17:0] bv   [0:ROWS*N-1];
    wire               dv   [0:ROWS*N-1];
    reg  signed [19:0] ah_q [0:ROWS*N-1];
    reg  signed [17:0] bv_q [0:ROWS*N-1];
    reg                dv_q [0:ROWS*N-1];
    wire signed [47:0] p    [0:ROWS*N-1];

    always @(posedge aclk)
        for (i = 0; i < ROWS*N; i = i + 1) begin
            ah_q[i] <= ah[i];
            bv_q[i] <= bv[i];
            dv_q[i] <= dv[i];
        end

    genvar r, c;
    generate
        // input skew, rows: r registers on row r's a
        for (r = 0; r < ROWS; r = r + 1) begin : SKA
            if (r == 0) begin : NONE
                assign a_in[r] = a1[r];
            end else begin : DLY
                reg signed [19:0] sk [0:r-1];
                integer j;
                always @(posedge aclk) begin
                    sk[0] <= a1[r];
                    for (j = 1; j < r; j = j + 1) sk[j] <= sk[j-1];
                end
                assign a_in[r] = sk[r-1];
            end
        end

        // input skew, columns: c registers on column c's b and d
        for (c = 0; c < N; c = c + 1) begin : SKB
            if (c == 0) begin : NONE
                assign b_in[c] = b1[c];
                assign d_in[c] = d1[c];
            end else begin : DLY
                reg [18:0] sk [0:c-1];
                integer j;
                always @(posedge aclk) begin
                    sk[0] <= {d1[c], b1[c]};
                    for (j = 1; j < c; j = j + 1) sk[j] <= sk[j-1];
                end
                assign b_in[c] = sk[c-1][17:0];
                assign d_in[c] = sk[c-1][18];
            end
        end

        // the PEs and the wires between them
        for (r = 0; r < ROWS; r = r + 1) begin : R
            for (c = 0; c < N; c = c + 1) begin : C
                if (c == 0) begin : LEFT
                    assign ah[r*N + c] = a_in[r];
                end else begin : FROM_LEFT
                    assign ah[r*N + c] = ah_q[r*N + c - 1];
                end
                if (r == 0) begin : TOP
                    assign bv[r*N + c] = b_in[c];
                    assign dv[r*N + c] = d_in[c];
                end else begin : FROM_ABOVE
                    assign bv[r*N + c] = bv_q[(r-1)*N + c];
                    assign dv[r*N + c] = dv_q[(r-1)*N + c];
                end

                pe_mac pe (
                    .clk(aclk), .clr(t_clear), .ce(vs[1 + r + c]),
                    .a(ah[r*N + c]), .b(bv[r*N + c]), .d_en(dv[r*N + c]), .p(p[r*N + c]));
            end
        end

        // row 0's sums out
        for (c = 0; c < N; c = c + 1) begin : OUT
            assign t_c[44*c +: 44] = p[c][43:0];
        end
    endgenerate
endmodule
