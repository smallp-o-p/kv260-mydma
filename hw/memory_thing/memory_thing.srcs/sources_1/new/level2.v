`timescale 1ns / 1ps
// level2.v - fp8_golden.py's level 2 on chip: turns each granule's 16 exact
// integer sums into fp32 and accumulates them over the K-groups.
//
// For every output column c of every granule (lane/bank p, group g):
//     p_c = fp32(sum_c) * 2^-18          (one rounding; the 2^-18 is exact)
//     s   = fp32(s_a[g] * s_w)           (once per granule)
//     t_c = fp32(p_c * s)
//     acc[p][c] = fp32(acc[p][c] + t_c)  (acc starts at +0.0 when g = 0)
// Same order, same roundings, no fused multiply-add: bit-exact with the
// golden model (denormals are flushed to zero, see fp32_funcs.vh).
// On the last group the 16 results go out as 4 beats, fp32 c in bits
// [32*(c%4) +: 32] of beat c/4, i.e. ascending n in memory.
//
// Timing: a granule is accepted only when idle, then its 16 values go through
// a 6-stage pipeline (convert, multiply, add, each in two halves), one per
// clock. About 25 clocks per granule; a granule takes 130+ to compute, so
// level 2 never slows the controller down.
// Output back-pressure: a granule that will produce output is accepted only
// if the output FIFO has room for its 4 beats, counting beats already promised.

module level2 #(
    parameter OUT_DEPTH = 16          // output FIFO, in 128-bit beats (multiple of 4)
)(
    input  wire           aclk,
    input  wire           aresetn,

    // one granule from the controller (valid/ready handshake)
    input  wire           in_valid,
    output wire           in_ready,
    input  wire [16*44-1:0] in_sums,  // row 0's 16 sums, column c in [44c +: 44]
    input  wire [31:0]    in_sa,      // activation scale s_a[g]
    input  wire [31:0]    in_sw,      // weight scale from the granule's scale beat
    input  wire [1:0]     in_bank,    // lane p = which of the quad's 4 output tiles
    input  wire           in_first_g, // g = 0: start from +0.0
    input  wire           in_last_g,  // g = G-1: send the results
    input  wire           in_last_call, // last granule of the call: TLAST on its last beat

    // fp32 results to S2MM
    output wire [127:0]   m_tdata,
    output wire           m_tvalid,
    output wire           m_tlast,
    input  wire           m_tready
);
    `include "fp32_funcs.vh"

    localparam [1:0] S_IDLE = 2'd0, S_SC1 = 2'd1, S_SC2 = 2'd2, S_RUN = 2'd3;
    reg [1:0] st;

    // ---------------- captured granule ----------------
    reg [16*44-1:0] sums_r;
    reg [31:0]      sa_r, sw_r, s_r;
    reg [61:0]      s_h;
    reg [1:0]       bank_r;
    reg             first_r, lastg_r, lastcall_r;
    reg [3:0]       c;

    // ---------------- output credits ----------------
    reg  [5:0] committed;                    // beats promised to the FIFO and not yet sent
    wire       out_beat = m_tvalid && m_tready;
    assign in_ready = (st == S_IDLE) && (committed + 6'd4 <= OUT_DEPTH);
    wire   accept   = in_valid && in_ready;

    always @(posedge aclk) begin
        if (!aresetn) begin
            st <= S_IDLE; c <= 4'd0; committed <= 6'd0;
        end else begin
            committed <= committed + ((accept && in_last_g) ? 6'd4 : 6'd0) - (out_beat ? 6'd1 : 6'd0);
            case (st)
            S_IDLE: if (accept) begin
                sums_r <= in_sums; sa_r <= in_sa; sw_r <= in_sw; bank_r <= in_bank;
                first_r <= in_first_g; lastg_r <= in_last_g; lastcall_r <= in_last_call;
                st <= S_SC1;
            end
            S_SC1: begin s_h <= fp_mul1(sa_r, sw_r); st <= S_SC2; end
            S_SC2: begin s_r <= fp_mul2(s_h); c <= 4'd0; st <= S_RUN; end
            S_RUN: begin
                c <= c + 1'b1;
                if (c == 4'd15) st <= S_IDLE;
            end
            endcase
        end
    end

    // ---------------- the pipeline, one value per clock ----------------
    // tag = {bank, c, first_g, last_g, last_call && c == 15}
    localparam TW = 2 + 4 + 3;
    wire [TW-1:0] tag0 = {bank_r, c, first_r, lastg_r, lastcall_r && (c == 4'd15)};

    reg            v1, v2, v3, v4, v5, v6;
    reg [TW-1:0]   g1, g2, g3, g4, g5, g6;
    reg [57:0]     h1;                    // convert, half 1
    reg [31:0]     p2, s1, s2;            // p = fp32(sum) * 2^-18, and s riding along
    reg [61:0]     h3;                    // multiply, half 1
    reg [31:0]     t4;                    // t = p * s
    reg [64:0]     h5;                    // add, half 1
    reg [31:0]     r6;                    // acc + t

    reg [31:0]     acc [0:63];            // 4 banks x 16 columns
    wire [5:0]     a4 = {g4[TW-1 -: 2], g4[TW-3 -: 4]};      // {bank, c} of the value in stage 4
    wire [5:0]     a6 = {g6[TW-1 -: 2], g6[TW-3 -: 4]};
    wire           first4 = g4[2], lastg6 = g6[1], lastc6 = g6[0];

    always @(posedge aclk) begin
        if (!aresetn) begin
            v1 <= 0; v2 <= 0; v3 <= 0; v4 <= 0; v5 <= 0; v6 <= 0;
        end else begin
            v1 <= (st == S_RUN); v2 <= v1; v3 <= v2; v4 <= v3; v5 <= v4; v6 <= v5;
        end
        g1 <= tag0; g2 <= g1; g3 <= g2; g4 <= g3; g5 <= g4; g6 <= g5;

        h1 <= fp_cvt1(sums_r[c*44 +: 44]);  s1 <= s_r;
        p2 <= fp_cvt2(h1);                  s2 <= s1;
        h3 <= fp_mul1(p2, s2);
        t4 <= fp_mul2(h3);
        h5 <= fp_add1(first4 ? 32'd0 : acc[a4], t4);  // +0.0 + t on the first group
        r6 <= fp_add2(h5);

        if (v6) acc[a6] <= r6;            // a later read of this entry is >= 4 granules away
    end

    // ---------------- pack 4 results per beat, into the FIFO ----------------
    reg  [95:0]  pk;                      // results c%4 = 0, 1, 2 of the current beat
    wire         push = v6 && lastg6 && (a6[1:0] == 2'd3);
    wire [128:0] push_beat = {lastc6, r6, pk};

    always @(posedge aclk)
        if (v6 && lastg6 && a6[1:0] != 2'd3) pk[32*a6[1:0] +: 32] <= r6;   // slot 3 goes straight into push_beat

    reg [128:0] fifo [0:OUT_DEPTH-1];
    reg [$clog2(OUT_DEPTH)-1:0] wp, rp;
    reg [$clog2(OUT_DEPTH):0]   count;

    always @(posedge aclk) begin
        if (!aresetn) begin
            wp <= 0; rp <= 0; count <= 0;
        end else begin
            if (push) begin fifo[wp] <= push_beat; wp <= wp + 1'b1; end
            if (out_beat) rp <= rp + 1'b1;
            count <= count + (push ? 1'b1 : 1'b0) - (out_beat ? 1'b1 : 1'b0);
        end
    end

    assign m_tvalid = (count != 0);
    assign m_tdata  = fifo[rp][127:0];
    assign m_tlast  = fifo[rp][128];
endmodule
