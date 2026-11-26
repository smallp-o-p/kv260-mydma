// tb_lane_checker.v - lane_checker in free-running and lockstep modes.
//
//   iverilog -g2012 -o tb -DSKEW=16 hw/tb/tb_lane_checker.v \
//       hw/memory_thing/memory_thing.srcs/sources_1/new/lane_checker.v && vvp tb
//
// Each weight lane sends one PKT-beat packet. Lane 2 is the slow one (valid
// half the time), like w2 on the long HPC1 path. MASK picks which lanes run.
// Checks: every packet's result (lane, count, XOR) is right; nothing hangs;
// with SKEW > 0 no mid-packet lane gets more than SKEW+2 beats ahead.
`timescale 1ns / 1ps
`ifndef SKEW
`define SKEW 0
`endif
`ifndef MASK
`define MASK 4'b1111
`endif

module tb;
    localparam PKT = 2000;
    reg clk = 0, rstn = 0;
    always #2 clk = ~clk;

    reg  [127:0] d   [0:3];
    reg  [3:0]   v;
    wire [3:0]   r;
    reg  [3:0]   l;
    integer      n   [0:3];      // beats sent
    reg  [63:0]  exp [0:3];

    wire [127:0] res;
    wire         res_v;

    lane_checker #(.MAX_SKEW(`SKEW)) dut (
        .aclk(clk), .aresetn(rstn),
        .s_w0_tdata(d[0]), .s_w0_tkeep(16'hFFFF), .s_w0_tlast(l[0]), .s_w0_tvalid(v[0]), .s_w0_tready(r[0]),
        .s_w1_tdata(d[1]), .s_w1_tkeep(16'hFFFF), .s_w1_tlast(l[1]), .s_w1_tvalid(v[1]), .s_w1_tready(r[1]),
        .s_w2_tdata(d[2]), .s_w2_tkeep(16'hFFFF), .s_w2_tlast(l[2]), .s_w2_tvalid(v[2]), .s_w2_tready(r[2]),
        .s_w3_tdata(d[3]), .s_w3_tkeep(16'hFFFF), .s_w3_tlast(l[3]), .s_w3_tvalid(v[3]), .s_w3_tready(r[3]),
        .s_act_tdata(128'd0), .s_act_tkeep(16'hFFFF), .s_act_tlast(1'b0), .s_act_tvalid(1'b0), .s_act_tready(),
        .m_res_tdata(res), .m_res_tkeep(), .m_res_tlast(), .m_res_tvalid(res_v), .m_res_tready(1'b1));

    function [127:0] beat(input integer lane, input integer k);
        reg [31:0] h;
        begin
            h = (k * 32'h9E3779B1) ^ (lane * 32'h85EBCA77);
            beat = {h, h * 32'hC2B2AE3D, ~h, h ^ 32'h27D4EB2F};
        end
    endfunction

    integer i, got = 0, errs = 0, cyc = 0, maxskew = 0, s, fin[0:3];
    initial begin
        for (i = 0; i < 4; i = i + 1) begin n[i] = 0; exp[i] = 0; fin[i] = 0; end
        v = 0; l = 0;
        repeat (4) @(posedge clk);
        rstn = 1;
    end

    // Sources: AXIS rules, data held while valid && !ready.
    always @(posedge clk) if (rstn) begin
        cyc <= cyc + 1;
        for (i = 0; i < 4; i = i + 1) begin
            if (v[i] && r[i]) begin
                exp[i] = exp[i] ^ d[i][127:64] ^ d[i][63:0];
                n[i] = n[i] + 1;
                if (l[i]) fin[i] = cyc;
            end
            if (!v[i] || r[i]) begin
                if (`MASK & (1 << i) && n[i] < PKT && (i != 2 || $urandom % 2)
                    && cyc > 3 * i) begin        // staggered starts
                    d[i] = beat(i, n[i]);
                    v[i] = 1;
                    l[i] = (n[i] == PKT - 1);
                end else begin
                    v[i] = 0; l[i] = 0;
                end
            end
        end
        // Skew among lanes still mid-packet.
        for (i = 0; i < 4; i = i + 1)
            for (s = 0; s < 4; s = s + 1)
                if (n[i] > 0 && n[i] < PKT && n[s] > 0 && n[s] < PKT && n[i] - n[s] > maxskew)
                    maxskew = n[i] - n[s];
        if (res_v) begin
            got = got + 1;
            if (res[127:104] != 24'hC0FFEE || res[95:64] != PKT || res[63:0] != exp[res[103:96]]) begin
                errs = errs + 1;
                $display("BAD result %h", res);
            end
        end
    end

    integer want, lanes;
    initial begin
        want = 0;
        for (lanes = 0; lanes < 4; lanes = lanes + 1) if (`MASK & (1 << lanes)) want = want + 1;
        wait (got == want || cyc > 20 * PKT);
        repeat (2) @(posedge clk);
        $display("SKEW=%0d MASK=%b: %0d/%0d results, %0d bad, max skew %0d, done at cycle w0 %0d w1 %0d w2 %0d w3 %0d",
                 `SKEW, `MASK, got, want, errs, maxskew, fin[0], fin[1], fin[2], fin[3]);
        if (got != want || errs != 0 || (`SKEW > 0 && maxskew > `SKEW + 2)) $display("FAIL");
        else $display("PASS");
        $finish;
    end
endmodule
