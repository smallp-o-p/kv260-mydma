`timescale 1ns / 1ps
// axi_controller.v - matmul controller for one tile.
//   LEVEL2 = 0 (version A): raw 44-bit sums out, the CPU does level 2.
//   LEVEL2 = 1 (version B): level2.v on chip, fp32 results out.
//
//   activation_buffer --rd_*--> [ controller ] --t_*--> 16x16 tile
//   weight lanes s_w0..3 -----> [            ] <--t_c-- (row 0 sums)
//                               [            ] --m_res--> axi_dma_4 S2MM
//
// Per LINEAR call:
//   * The buffer holds x as 8G words (16 codes per word, G = K/128). In
//     version B, G more words follow: s_a[g] (fp32, bytes 0-3) at word 8G + g.
//     G comes from beat_count, so there is no header.
//   * Weights arrive as granules: 1 scale beat + 128 rows (one k each).
//     Order: for quad, for g, for lane p = 0..3 (see fp8_golden.py).
//   * For every granule the tile gets 128 steps, then its 16 row-0 sums go
//     version A: out on m_res as 8 beats (two sign-extended 64-bit sums per beat)
//     version B: to level 2, which sends N fp32 results (4 per beat) at the end
//   * The call ends after lane 3's granule whose last row carries TLAST.
//
// See the "Matmul controller sketch" doc for the full design.

module axi_controller #(
    parameter AXI_STREAM_DATA_BITS = 128,
    parameter ADDR_WIDTH = 12,
    parameter N = 16,                      // tile width (outputs per granule)
    parameter LEVEL2 = 0                   // 0: version A (raw sums), 1: version B (fp32)
)(
    (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 aclk CLK" *)
    (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF s_w0:s_w1:s_w2:s_w3:m_res, ASSOCIATED_RESET aresetn" *)
    input  wire aclk,
    (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 aresetn RST" *)
    (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_LOW" *)
    input  wire aresetn,

    // ---- activation buffer (read side) ----
    input  wire                            loaded,
    input  wire [ADDR_WIDTH-1:0]           beat_count,
    input  wire [AXI_STREAM_DATA_BITS-1:0] rd_data,
    input  wire                            rd_valid,
    output wire                            rd_en,
    output wire [ADDR_WIDTH-1:0]           rd_addr,
    output reg                             rel,

    // ---- tile (plain wires, no AXI) ----
    output wire                            t_valid, t_first, t_last,
    output wire [AXI_STREAM_DATA_BITS-1:0] t_a,      // 16 x 8-bit, row i in byte i
    output wire [AXI_STREAM_DATA_BITS-1:0] t_b,      // 16 x 8-bit, column c in byte c
    input  wire                            t_done,
    input  wire [N*44-1:0]                 t_c,      // row 0's sums (decode only)

    // ---- sticky error: bad beat_count or misplaced TLAST (ILA / LED) ----
    output reg                             err,

    // ---- weight lane 0 ----
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w0 TDATA" *)  input  wire [AXI_STREAM_DATA_BITS-1:0]   s_w0_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w0 TKEEP" *)  input  wire [AXI_STREAM_DATA_BITS/8-1:0] s_w0_tkeep,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w0 TLAST" *)  input  wire                              s_w0_tlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w0 TVALID" *) input  wire                              s_w0_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w0 TREADY" *) output wire                              s_w0_tready,
    // ---- weight lane 1 ----
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w1 TDATA" *)  input  wire [AXI_STREAM_DATA_BITS-1:0]   s_w1_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w1 TKEEP" *)  input  wire [AXI_STREAM_DATA_BITS/8-1:0] s_w1_tkeep,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w1 TLAST" *)  input  wire                              s_w1_tlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w1 TVALID" *) input  wire                              s_w1_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w1 TREADY" *) output wire                              s_w1_tready,
    // ---- weight lane 2 ----
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w2 TDATA" *)  input  wire [AXI_STREAM_DATA_BITS-1:0]   s_w2_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w2 TKEEP" *)  input  wire [AXI_STREAM_DATA_BITS/8-1:0] s_w2_tkeep,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w2 TLAST" *)  input  wire                              s_w2_tlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w2 TVALID" *) input  wire                              s_w2_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w2 TREADY" *) output wire                              s_w2_tready,
    // ---- weight lane 3 ----
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w3 TDATA" *)  input  wire [AXI_STREAM_DATA_BITS-1:0]   s_w3_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w3 TKEEP" *)  input  wire [AXI_STREAM_DATA_BITS/8-1:0] s_w3_tkeep,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w3 TLAST" *)  input  wire                              s_w3_tlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w3 TVALID" *) input  wire                              s_w3_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s_w3 TREADY" *) output wire                              s_w3_tready,

    // ---- results to axi_dma_4 S2MM ----
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_res TDATA" *)  output wire [AXI_STREAM_DATA_BITS-1:0]   m_res_tdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_res TKEEP" *)  output wire [AXI_STREAM_DATA_BITS/8-1:0] m_res_tkeep,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_res TLAST" *)  output wire                              m_res_tlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_res TVALID" *) output wire                              m_res_tvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m_res TREADY" *) input  wire                              m_res_tready
);
    localparam W = AXI_STREAM_DATA_BITS;

    // ------------------------------------------------------------------
    // States. Each one does one job and says where to go next.
    // ------------------------------------------------------------------
    localparam [3:0] IDLE  = 4'd0,   // wait for the buffer to be loaded
                     LOADA = 4'd1,   // copy group g's 8 words into A_REG (+ s_a[g] in B)
                     SCALE = 4'd2,   // pop lane p's scale beat
                     RUN   = 4'd3,   // 128 steps: pop a row, feed the tile
                     WAIT  = 4'd4,   // wait for the tile's t_done
                     OUT   = 4'd5,   // version A: send 16 sums as 8 beats on m_res
                     HAND  = 4'd6,   // version B: hand the 16 sums to level 2
                     NEXT  = 4'd7,   // loop bookkeeping: next lane / group / quad / done
                     REL   = 4'd8;   // hand the buffer back
    reg [3:0] current_state;

    // ------------------------------------------------------------------
    // Loop counters (a hardware loop = a register + a state)
    //   for g in 0..G-1:        group (128 k each)
    //     for p in 0..3:        lane, i.e. output tile 4q+p
    //       for kk in 0..127:   one row/step per popped beat
    //   ...repeated per quad until lane 3's TLAST.
    // ------------------------------------------------------------------
    reg [4:0]  G;            // number of K-groups, from beat_count (K <= 3072 -> G <= 24)
    // beat_count / 9 without a divider: x * 57 >> 9 is exact for multiples of 9 below 4608
    wire [ADDR_WIDTH+5:0] bc57 = beat_count * 57;
    wire [ADDR_WIDTH-4:0] G9   = bc57[ADDR_WIDTH+5:9];
    reg [4:0]  g;
    reg [1:0]  p;
    reg [6:0]  kk;
    reg [2:0]  b;            // output beat 0..7 in OUT
    reg        saw_tlast;    // TLAST was on the last row of the granule just run

    // ------------------------------------------------------------------
    // LOADA: read words 8g .. 8g+7 into A_REG (version B: then word 8G+g,
    // the activation scale s_a[g]).
    //   issue counts requests, got counts arrivals (2 clocks later).
    //   We leave on the last ARRIVAL, so any read latency works.
    // ------------------------------------------------------------------
    localparam [3:0] LAST_WORD = LEVEL2 ? 4'd8 : 4'd7;     // 9 or 8 words per group
    reg [3:0]     issue, got;
    reg           issued_all;
    reg [8*W-1:0] A_REG;     // the 128 codes of group g, code kk in A_REG[8*kk +: 8]
    reg [31:0]    s_a;       // activation scale of group g (version B)

    assign rd_en   = (current_state == LOADA) && !issued_all;
    assign rd_addr = issue[3] ? ({G, 3'b000} + g)                      // 8G + g: s_a[g]
                              : {{(ADDR_WIDTH-8){1'b0}}, g, issue[2:0]};  // 8g + issue

    // ------------------------------------------------------------------
    // Weight lanes. "Pop" = raise tready on lane p; the beat is ours on
    // the clock edge where tvalid && tready. Other lanes wait (their FIFOs
    // fill). tready never looks at tvalid.
    // ------------------------------------------------------------------
    wire want_data = (current_state == SCALE) || (current_state == RUN);

    assign s_w0_tready = want_data && (p == 2'd0);
    assign s_w1_tready = want_data && (p == 2'd1);
    assign s_w2_tready = want_data && (p == 2'd2);
    assign s_w3_tready = want_data && (p == 2'd3);

    wire [W-1:0] lane_data  = (p == 2'd0) ? s_w0_tdata  : (p == 2'd1) ? s_w1_tdata  :
                              (p == 2'd2) ? s_w2_tdata  :               s_w3_tdata;
    wire         lane_valid = (p == 2'd0) ? s_w0_tvalid : (p == 2'd1) ? s_w1_tvalid :
                              (p == 2'd2) ? s_w2_tvalid :               s_w3_tvalid;
    wire         lane_last  = (p == 2'd0) ? s_w0_tlast  : (p == 2'd1) ? s_w1_tlast  :
                              (p == 2'd2) ? s_w2_tlast  :               s_w3_tlast;

    wire pop = want_data && lane_valid;     // the handshake on lane p this clock

    reg [31:0] s_w;          // weight scale of this granule (used by level 2 in version B)

    // ------------------------------------------------------------------
    // Tile: one k step per popped row. If the lane stalls, t_valid is 0
    // and nothing moves (the tile must carry valid along with the data).
    // ------------------------------------------------------------------
    assign t_valid = (current_state == RUN) && pop;
    assign t_first = (kk == 7'd0);
    assign t_last  = (kk == 7'd127);
    assign t_b     = lane_data;                              // row kk: W[n0+c][k] in byte c
    assign t_a     = {{(W-8){1'b0}}, A_REG[8*kk +: 8]};      // decode: only row 0 = x[k]

    // ------------------------------------------------------------------
    // Output: the tile holds its sums until the next granule starts, and
    // we don't start one until OUT is finished, so read t_c directly.
    // Beat b carries sums 2b and 2b+1, each sign-extended to 64 bits.
    // ------------------------------------------------------------------
    wire [43:0] lo = t_c[(2*b)  *44 +: 44];
    wire [43:0] hi = t_c[(2*b+1)*44 +: 44];

    wire last_granule = (p == 2'd3) && (g == G - 1'b1) && saw_tlast;
    assign m_res_tkeep = {(W/8){1'b1}};
    wire   out_beat;                     // version A: a sum beat moved on m_res
    wire   l2_ready;                     // version B: level 2 takes a granule

    generate if (LEVEL2 == 0) begin : VER_A
        assign m_res_tdata  = {{20{hi[43]}}, hi, {20{lo[43]}}, lo};
        assign m_res_tvalid = (current_state == OUT);
        assign m_res_tlast  = (current_state == OUT) && (b == 3'd7) && last_granule;
        assign out_beat     = m_res_tvalid && m_res_tready;
        assign l2_ready     = 1'b0;
    end else begin : VER_B
        // Level 2 copies the 16 sums when it accepts the granule, so the
        // tile is free for the next granule straight away.
        level2 l2 (
            .aclk(aclk), .aresetn(aresetn),
            .in_valid(current_state == HAND), .in_ready(l2_ready),
            .in_sums(t_c), .in_sa(s_a), .in_sw(s_w), .in_bank(p),
            .in_first_g(g == 5'd0), .in_last_g(g == G - 1'b1), .in_last_call(last_granule),
            .m_tdata(m_res_tdata), .m_tvalid(m_res_tvalid), .m_tlast(m_res_tlast),
            .m_tready(m_res_tready));
        assign out_beat = 1'b0;
    end endgenerate

    // ------------------------------------------------------------------
    // The state machine: everything registered lives here.
    // ------------------------------------------------------------------
    always @(posedge aclk) begin
        if (!aresetn) begin
            current_state <= IDLE;
            rel        <= 1'b0;
            err        <= 1'b0;
            G          <= 5'd0;
            g          <= 5'd0;
            p          <= 2'd0;
            kk         <= 7'd0;
            b          <= 3'd0;
            issue      <= 4'd0;
            got        <= 4'd0;
            s_a        <= 32'd0;
            issued_all <= 1'b0;
            saw_tlast  <= 1'b0;
            s_w        <= 32'd0;
        end else begin
            rel <= 1'b0;                     // default low: REL makes a 1-clock pulse

            case (current_state)
            // Wait for a load. !rel: in the clock after REL the buffer still
            // shows loaded = 1 (it clears on rel), so don't restart on it.
            IDLE: if (loaded && !rel) begin
                if (LEVEL2 == 0) begin
                    if (beat_count[2:0] != 3'd0 || beat_count == 0 || beat_count > 8 * 24)
                        err <= 1'b1;         // not 8G words with G <= 24: bad DMA length
                    G <= beat_count[7:3];    // G = beat_count / 8
                end else begin
                    if (G9 * 9 != beat_count || beat_count == 0 || beat_count > 9 * 24)
                        err <= 1'b1;         // not 9G words with G <= 24: bad DMA length
                    G <= G9[4:0];            // G = beat_count / 9
                end
                g     <= 5'd0;
                p     <= 2'd0;
                current_state <= LOADA;
            end

            // Requests and arrivals overlap: 10 clocks for 8 words.
            LOADA: begin
                if (rd_en) begin
                    issue <= issue + 1'b1;
                    if (issue == LAST_WORD) issued_all <= 1'b1;
                end
                if (rd_valid) begin
                    if (got[3]) s_a <= rd_data[31:0];         // word 8: s_a[g]
                    else        A_REG[got[2:0]*W +: W] <= rd_data;  // codes 16*got .. 16*got+15
                    got <= got + 1'b1;
                    if (got == LAST_WORD) begin      // the last word just landed
                        issue         <= 4'd0;       // ready for the next group
                        got           <= 4'd0;
                        issued_all    <= 1'b0;
                        p             <= 2'd0;
                        current_state <= SCALE;
                    end
                end
            end

            // The first beat of every granule is the scale beat.
            SCALE: if (pop) begin
                s_w <= lane_data[31:0];
                if (lane_last) err <= 1'b1;          // TLAST can't be on a scale beat
                kk  <= 7'd0;
                current_state <= RUN;
            end

            // 128 rows, one per popped beat (stalls just pause).
            RUN: if (pop) begin
                kk <= kk + 1'b1;
                if (kk == 7'd127) begin
                    saw_tlast     <= lane_last;
                    current_state <= WAIT;
                end else if (lane_last) begin
                    err <= 1'b1;                     // TLAST in the middle of a granule
                end
            end

            // The far corner of the tile finishes ~2N + pipeline clocks after t_last.
            WAIT: if (t_done) begin
                b <= 3'd0;
                current_state <= (LEVEL2 != 0) ? HAND : OUT;
            end

            // Version A: 8 beats out, two sums each.
            OUT: if (out_beat) begin
                b <= b + 1'b1;
                if (b == 3'd7) current_state <= NEXT;
            end

            // Version B: wait until level 2 takes the granule (it copies the sums).
            HAND: if (l2_ready) current_state <= NEXT;

            // The loop bookkeeping:
            //   next lane -> SCALE (same group, A_REG reused)
            //   next group -> LOADA
            //   lane 3 saw TLAST at the last group -> done
            //   otherwise -> next quad, starting again at group 0
            NEXT: begin
                if (p != 2'd3) begin
                    p <= p + 1'b1;
                    current_state <= SCALE;
                end else if (g != G - 1'b1) begin
                    if (saw_tlast) err <= 1'b1;      // lane ended before the last group
                    g <= g + 1'b1;
                    current_state <= LOADA;
                end else if (saw_tlast) begin
                    g <= 5'd0;
                    current_state <= REL;
                end else begin
                    g <= 5'd0;                       // next quad
                    current_state <= LOADA;
                end
            end

            // Release the buffer; it takes the next load from here.
            REL: begin
                rel <= 1'b1;
                current_state <= IDLE;
            end

            default: current_state <= IDLE;
            endcase
        end
    end
endmodule
