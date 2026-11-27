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
// a 16-stage pipeline, one per clock: convert (4), multiply (3), acc read (1),
// add (8). Each stage is a few LUTs deep so it meets 250 MHz. About 35 clocks
// per granule; a granule takes 130+ to compute, so level 2 never slows the
// controller down.
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
                sums_r <= sums_r >> 44;          // column c is always in sums_r[43:0]: no 16:1 mux
                if (c == 4'd15) st <= S_IDLE;
            end
            endcase
        end
    end

    // ---------------- the pipeline, one value per clock ----------------
    // tag = {bank, c, first_g, last_g, last_call && c == 15}, carried with the value
    //   stage  1- 4  convert: |x|, leading zeros, normalise, round  -> p = fp32(sum) * 2^-18
    //   stage  5- 7  multiply: mantissa product, extra register (DSP M/P regs), round -> t = p * s
    //   stage  8     read acc[bank][c] (or +0.0 on the first group)
    //   stage  9-16  add: order, exponent difference, align, sticky, add, leading
    //                zeros, normalise, round -> acc + t, written back at stage 16
    localparam TW = 2 + 4 + 3;
    localparam NS = 16;
    wire [TW-1:0] tag0 = {bank_r, c, first_r, lastg_r, lastcall_r && (c == 4'd15)};

    reg [NS:1]   v;                       // v[i]: stage i holds a value
    reg [TW-1:0] g [1:NS];                // its tag
    reg [31:0]   s1, s2, s3, s4;          // s rides along until the multiply

    reg [44:0]   k1;                      // cvt: {s, |x|}
    reg [50:0]   k2;                      //      + leading zeros
    reg [57:0]   k3;                      //      normalised
    reg [31:0]   p4;                      // p = fp32(sum) * 2^-18
    reg [61:0]   m5, m6;                  // mantissa product (m6: pipeline register for the DSPs)
    reg [31:0]   t7, t8;                  // t = p * s
    reg [31:0]   a8;                      // acc[bank][c], or +0.0
    reg [63:0]   d9;                      // add: {L, S}
    reg [64:0]   d10;                     //      exponent difference, mantissas
    reg [85:0]   d11;                     //      aligned
    reg [64:0]   d12;                     //      + sticky
    reg [38:0]   d13;                     //      sum
    reg [43:0]   d14;                     //      + leading zeros
    reg [41:0]   d15;                     //      normalised
    reg [31:0]   r16;                     // acc + t

    reg [31:0]   acc [0:63];              // 4 banks x 16 columns
    wire [5:0]   a7  = {g[7][TW-1 -: 2],  g[7][TW-3 -: 4]};   // {bank, c} entering stage 8
    wire [5:0]   a16 = {g[16][TW-1 -: 2], g[16][TW-3 -: 4]};
    wire         first7 = g[7][2], lastg16 = g[16][1], lastc16 = g[16][0];

    integer i;
    always @(posedge aclk) begin
        if (!aresetn) v <= 0;
        else          v <= {v[NS-1:1], st == S_RUN};
        g[1] <= tag0;
        for (i = 2; i <= NS; i = i + 1) g[i] <= g[i-1];

        k1  <= fp_cvt_a(sums_r[43:0]);   s1 <= s_r;
        k2  <= fp_cvt_b(k1);             s2 <= s1;
        k3  <= fp_cvt_c(k2);             s3 <= s2;
        p4  <= fp_cvt2(k3);              s4 <= s3;
        m5  <= fp_mul1(p4, s4);
        m6  <= m5;
        t7  <= fp_mul2(m6);
        a8  <= first7 ? 32'd0 : acc[a7]; t8 <= t7;   // +0.0 + t on the first group
        d9  <= fp_add_a(a8, t8);
        d10 <= fp_add_b(d9);
        d11 <= fp_add_c(d10);
        d12 <= fp_add_d(d11);
        d13 <= fp_add_e(d12);
        d14 <= fp_add_f(d13);
        d15 <= fp_add_g(d14);
        r16 <= fp_add_h(d15);

        if (v[NS]) acc[a16] <= r16;       // the next read of this entry is >= 4 granules away
    end

    // ---------------- pack 4 results per beat, into the FIFO ----------------
    reg  [95:0]  pk;                      // results c%4 = 0, 1, 2 of the current beat
    wire         push = v[NS] && lastg16 && (a16[1:0] == 2'd3);
    wire [128:0] push_beat = {lastc16, r16, pk};

    always @(posedge aclk)
        if (v[NS] && lastg16 && a16[1:0] != 2'd3) pk[32*a16[1:0] +: 32] <= r16;   // slot 3 goes straight into push_beat

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
