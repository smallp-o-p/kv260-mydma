`timescale 1ns / 1ps
// tb_axi_controller.v - self-checking test of axi_controller.v + level2.v.
//
//   gen_vectors.py writes the lane streams, the activation words (codes, then
//   s_a) and the expected fp32 outputs (fp8_golden.golden_linear_q). This bench:
//     * models the activation buffer (loaded / beat_count / rel, 2-clock reads)
//     * drives the 4 weight lanes with random tvalid gaps
//     * uses tile_ref.v (row-0 reference tile) with t_done delayed TILE_LAT
//       clocks, like a real 16x16 tile
//     * holds m_res_tready low at random and checks every output bit for bit, and TLAST
//   It runs CALLS calls back to back to exercise rel -> IDLE -> next load.
//
//   iverilog -g2005 -I <vecdir> -I .. -o tb tb_axi_controller.v ../axi_controller.v ../tile_ref.v ../level2.v && vvp tb
`include "params.vh"

module lane_src #(parameter FILE = "", parameter LEN = 1) (
    input  wire         clk, rstn, restart,
    output reg          tvalid,
    output wire [127:0] tdata,
    output wire         tlast,
    input  wire         tready
);
    reg [127:0] mem [0:LEN-1];
    initial $readmemh(FILE, mem);
    integer ptr;
    assign tdata = mem[ptr < LEN ? ptr : 0];
    assign tlast = (ptr == LEN - 1);
    always @(posedge clk) begin
        if (!rstn || restart) begin
            ptr <= 0; tvalid <= 0;
        end else begin
            if (tvalid && tready) ptr <= ptr + 1;
            // AXI rule: once tvalid is up it stays up until the beat moves
            if (!tvalid || tready)
                tvalid <= (((tvalid && tready) ? ptr + 1 : ptr) < LEN) && (($random & 3) != 0);
        end
    end
endmodule

module tb_axi_controller;
    localparam G = `G, LEN = `LANE_BEATS, NOUT = `NOUT;
    localparam TILE_LAT = 32, CALLS = 2;
    localparam [11:0] BEATS = 9 * G;            // what the buffer reports as beat_count

    reg clk = 0, rstn = 0;
    always #2 clk = ~clk;                       // 250 MHz

    // ---------------- activation buffer model ----------------
    reg  [127:0] act [0:9*G-1];
    initial $readmemh({`VDIR, "/act.hex"}, act);
    reg          loaded = 0;
    wire         rd_en, rel;
    wire [11:0]  rd_addr;
    reg  [127:0] d1, d2;
    reg          v1 = 0, v2 = 0;
    always @(posedge clk) begin                 // 2-clock read latency
        v1 <= rd_en;  d1 <= act[rd_addr];
        v2 <= v1;     d2 <= d1;
        if (rel) loaded <= 0;
        if (rd_en && rd_addr >= BEATS) begin $display("FAIL: read past the buffer, addr %0d", rd_addr); $finish; end
    end

    // ---------------- weight lanes ----------------
    reg restart = 0;
    wire [127:0] w_tdata [0:3];
    wire [3:0] w_tvalid, w_tlast, w_tready;
    lane_src #(.FILE({`VDIR, "/port0.hex"}), .LEN(LEN)) L0 (clk, rstn, restart, w_tvalid[0], w_tdata[0], w_tlast[0], w_tready[0]);
    lane_src #(.FILE({`VDIR, "/port1.hex"}), .LEN(LEN)) L1 (clk, rstn, restart, w_tvalid[1], w_tdata[1], w_tlast[1], w_tready[1]);
    lane_src #(.FILE({`VDIR, "/port2.hex"}), .LEN(LEN)) L2 (clk, rstn, restart, w_tvalid[2], w_tdata[2], w_tlast[2], w_tready[2]);
    lane_src #(.FILE({`VDIR, "/port3.hex"}), .LEN(LEN)) L3 (clk, rstn, restart, w_tvalid[3], w_tdata[3], w_tlast[3], w_tready[3]);

    // ---------------- tile: the synthesizable reference tile ----------------
    // EXTRA_DONE_DELAY makes t_done late, like a real 16x16 systolic tile.
    wire t_valid, t_first, t_last, t_done;
    wire [127:0] t_a, t_b;
    wire [16*44-1:0] t_c;
    integer steps = 0;
    always @(posedge clk) if (t_valid) steps = steps + 1;
    tile_ref #(.N(16), .EXTRA_DONE_DELAY(TILE_LAT)) tile (
        .aclk(clk), .aresetn(rstn), .t_valid(t_valid), .t_first(t_first), .t_last(t_last),
        .t_a(t_a), .t_b(t_b), .t_done(t_done), .t_c(t_c));

    // ---------------- results ----------------
    reg  [31:0] expf [0:NOUT-1];          // fp32 outputs, ascending n
    initial $readmemh({`VDIR, "/exp.hex"}, expf);
    localparam NWORDS = NOUT, PER_BEAT = 4;
    integer j;
    wire [127:0] m_tdata;
    wire [15:0]  m_tkeep;
    wire m_tvalid, m_tlast, err;
    reg  m_tready = 0;
    always @(posedge clk) m_tready <= ($random & 3) != 0;

    integer got_sums = 0, bad = 0, calls_done = 0, lasts = 0;
    always @(posedge clk) if (m_tvalid && m_tready) begin
        for (j = 0; j < 4; j = j + 1)
            if (m_tdata[32*j +: 32] !== expf[got_sums + j]) begin
                if (bad < 5) $display("y[%0d]: got %h, expected %h", got_sums + j,
                                      m_tdata[32*j +: 32], expf[got_sums + j]);
                bad = bad + 1;
            end
        if (m_tlast !== (got_sums + PER_BEAT == NWORDS)) begin
            $display("FAIL: TLAST %b at %0d of %0d", m_tlast, got_sums + PER_BEAT, NWORDS); bad = bad + 1;
        end
        got_sums = got_sums + PER_BEAT;
        if (m_tlast) lasts = lasts + 1;
    end

    // ---------------- DUT ----------------
    axi_controller dut (
        .aclk(clk), .aresetn(rstn),
        .loaded(loaded), .beat_count(BEATS), .rd_data(d2), .rd_valid(v2),
        .rd_en(rd_en), .rd_addr(rd_addr), .rel(rel),
        .t_valid(t_valid), .t_first(t_first), .t_last(t_last), .t_a(t_a), .t_b(t_b),
        .t_done(t_done), .t_c(t_c), .err(err),
        .s_w0_tdata(w_tdata[0]), .s_w0_tkeep(16'hffff), .s_w0_tlast(w_tlast[0]), .s_w0_tvalid(w_tvalid[0]), .s_w0_tready(w_tready[0]),
        .s_w1_tdata(w_tdata[1]), .s_w1_tkeep(16'hffff), .s_w1_tlast(w_tlast[1]), .s_w1_tvalid(w_tvalid[1]), .s_w1_tready(w_tready[1]),
        .s_w2_tdata(w_tdata[2]), .s_w2_tkeep(16'hffff), .s_w2_tlast(w_tlast[2]), .s_w2_tvalid(w_tvalid[2]), .s_w2_tready(w_tready[2]),
        .s_w3_tdata(w_tdata[3]), .s_w3_tkeep(16'hffff), .s_w3_tlast(w_tlast[3]), .s_w3_tvalid(w_tvalid[3]), .s_w3_tready(w_tready[3]),
        .m_res_tdata(m_tdata), .m_res_tkeep(m_tkeep), .m_res_tlast(m_tlast),
        .m_res_tvalid(m_tvalid), .m_res_tready(m_tready)
    );

    integer k, t0, cyc;
    initial begin
        repeat (5) @(posedge clk);
        rstn = 1;
        for (k = 0; k < CALLS; k = k + 1) begin
            got_sums = 0;
            @(posedge clk); loaded <= 1;           // the buffer has a load
            t0 = $time;
            @(posedge clk);
            while (loaded || got_sums < NWORDS) begin   // until rel and all results are out
                @(posedge clk);
                if ($time - t0 > 4 * 1000000) begin $display("FAIL: timeout in call %0d (%0d outputs, err = %b)", k, got_sums, err); $finish; end
            end
            cyc = ($time - t0) / 4;
            $display("call %0d: %0d outputs, %0d tile steps, %0d clocks, %0d lane beats each",
                     k, got_sums, steps, cyc, LEN);
            if (got_sums != NWORDS) begin $display("FAIL: expected %0d values", NWORDS); bad = bad + 1; end
            steps = 0;
            restart <= 1; @(posedge clk); restart <= 0;   // DMAs re-armed for the next call
            repeat (20) @(posedge clk);
        end
        if (err) begin $display("FAIL: err raised"); bad = bad + 1; end
        if (lasts != CALLS) begin $display("FAIL: %0d TLASTs for %0d calls", lasts, CALLS); bad = bad + 1; end
        if (bad != 0) $display("FAIL: %0d errors", bad);
        else          $display("PASS: %0d calls x %0d fp32 outputs (G = %0d), bit-exact with golden_linear_q", CALLS, NOUT, G);
        $finish;
    end
endmodule
