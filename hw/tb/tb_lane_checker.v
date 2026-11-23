// tb_lane_checker.v - random-traffic test for hw/lane_checker.v.
// Five sources send packets of random length with random gaps; the result
// side has random back-pressure. Every result beat must match a reference
// XOR/count computed here, per lane, in order.
// Run: iverilog -g2005 -o tb hw/lane_checker.v hw/tb/tb_lane_checker.v && vvp tb
`timescale 1ns / 1ps
module tb;
    reg clk = 0, rstn = 0;
    always #2 clk = ~clk;

    reg  [127:0] d [0:4];
    reg  [4:0]   v, l;
    wire [4:0]   r;
    wire [127:0] rd;
    wire         rv, rl;
    reg          rr;

    lane_checker dut (
        .aclk(clk), .aresetn(rstn),
        .s_w0_tdata(d[0]), .s_w0_tkeep(16'hffff), .s_w0_tlast(l[0]), .s_w0_tvalid(v[0]), .s_w0_tready(r[0]),
        .s_w1_tdata(d[1]), .s_w1_tkeep(16'hffff), .s_w1_tlast(l[1]), .s_w1_tvalid(v[1]), .s_w1_tready(r[1]),
        .s_w2_tdata(d[2]), .s_w2_tkeep(16'hffff), .s_w2_tlast(l[2]), .s_w2_tvalid(v[2]), .s_w2_tready(r[2]),
        .s_w3_tdata(d[3]), .s_w3_tkeep(16'hffff), .s_w3_tlast(l[3]), .s_w3_tvalid(v[3]), .s_w3_tready(r[3]),
        .s_act_tdata(d[4]), .s_act_tkeep(16'hffff), .s_act_tlast(l[4]), .s_act_tvalid(v[4]), .s_act_tready(r[4]),
        .m_res_tdata(rd), .m_res_tkeep(), .m_res_tlast(rl), .m_res_tvalid(rv), .m_res_tready(rr));

    localparam PKTS = 40;                  // packets per lane
    // reference: expected result per (lane, packet)
    reg [63:0] ex_x [0:4][0:PKTS-1];
    reg [31:0] ex_n [0:4][0:PKTS-1];
    integer left [0:4];                    // beats left in current packet
    integer sent_pk [0:4], got_pk [0:4];
    reg [63:0] run_x [0:4];
    reg [31:0] run_n [0:4];
    integer i, errors = 0, results = 0, seed = 7;

    initial begin
        for (i = 0; i < 5; i = i + 1) begin
            v[i] = 0; l[i] = 0; d[i] = 0; left[i] = 0;
            sent_pk[i] = 0; got_pk[i] = 0; run_x[i] = 0; run_n[i] = 0;
        end
        rr = 0;
        repeat (4) @(posedge clk);
        rstn = 1;
    end

    // sources
    always @(posedge clk) if (rstn) begin
        for (i = 0; i < 5; i = i + 1) begin
            if (v[i] && r[i]) begin                       // beat accepted
                run_x[i] = run_x[i] ^ d[i][127:64] ^ d[i][63:0];
                run_n[i] = run_n[i] + 1;
                if (l[i]) begin
                    ex_x[i][sent_pk[i]] = run_x[i];
                    ex_n[i][sent_pk[i]] = run_n[i];
                    sent_pk[i] = sent_pk[i] + 1;
                    run_x[i] = 0; run_n[i] = 0;
                end
                v[i] <= 0;
            end
            if ((!v[i] || r[i]) && sent_pk[i] < PKTS && ($random(seed) & 3) != 0) begin
                if (left[i] == 0)
                    left[i] = 1 + (($random(seed) & 32'h7fffffff) % ((i == 4) ? 5 : 40));
                d[i] <= {$random(seed), $random(seed), $random(seed), $random(seed)};
                l[i] <= (left[i] == 1);
                v[i] <= 1;
                left[i] = left[i] - 1;
            end
        end
    end

    // result side, random back-pressure
    always @(posedge clk) if (rstn) begin
        if (rv && rr) begin : chk
            integer ln;
            ln = rd[98:96];
            results = results + 1;
            if (rd[127:104] !== 24'hC0FFEE || !rl || ln > 4) begin
                $display("bad result beat %h", rd); errors = errors + 1;
            end else if (got_pk[ln] >= sent_pk[ln]) begin
                $display("lane %0d: result before its packet ended", ln); errors = errors + 1;
            end else begin
                if (rd[63:0] !== ex_x[ln][got_pk[ln]] || rd[95:64] !== ex_n[ln][got_pk[ln]]) begin
                    $display("lane %0d pkt %0d: got x=%h n=%0d, want x=%h n=%0d", ln, got_pk[ln],
                             rd[63:0], rd[95:64], ex_x[ln][got_pk[ln]], ex_n[ln][got_pk[ln]]);
                    errors = errors + 1;
                end
                got_pk[ln] = got_pk[ln] + 1;
            end
        end
        rr <= ($random(seed) & 1);
    end

    initial begin
        #200000;
        for (i = 0; i < 5; i = i + 1)
            if (got_pk[i] != PKTS) begin
                $display("lane %0d: %0d of %0d results", i, got_pk[i], PKTS); errors = errors + 1;
            end
        if (errors) $display("FAIL: %0d errors", errors);
        else        $display("PASS: %0d result beats, all 5 lanes x %0d packets match", results, PKTS);
        $finish;
    end
endmodule
