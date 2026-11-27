// tb_act_replay.v - activation_buffer + act_replay, end to end.
//
//   iverilog -g2012 -o tb hw/act_buf/sim/tb_act_replay.v hw/act_buf/act_replay.v \
//            hw/act_buf/sim/xpm_memory_sdpram_sim.v path/to/activation_buffer.v && vvp tb
//
// Sends packets of many lengths (1 beat, 512 like bwtest, a full 3072, and
// an over-long 3080) into the buffer with random TVALID gaps, and pulls the
// replay out with random TREADY back-pressure. Every load must come back
// exactly once, in order, with TLAST on its last word; an over-long packet
// comes back as its first 3072 words. Then checks one word per clock when
// nothing stalls.
`timescale 1ns / 1ps

module tb_act_replay;
    localparam DW = 128, AW = 12, MAXE = 3072;

    reg clk = 0, rstn = 0;
    always #2 clk = ~clk;                       // 250 MHz

    // DMA side
    reg  [DW-1:0] s_tdata = 0;
    reg           s_tlast = 0, s_tvalid = 0;
    wire          s_tready;
    // buffer <-> replay
    wire          loaded, rel, rd_en, rd_valid;
    wire [AW-1:0] beat_count, rd_addr;
    wire [DW-1:0] rd_data;
    // replay output
    wire [DW-1:0]   m_tdata;
    wire [DW/8-1:0] m_tkeep;
    wire            m_tlast, m_tvalid;
    reg             m_tready = 0;

    activation_buffer #(.MAX_ENTRIES(MAXE), .AXI_STREAM_DATA_BITS(DW), .ADDR_WIDTH(AW)) buf0 (
        .aclk(clk), .aresetn(rstn),
        .s_act_tdata(s_tdata), .s_act_tkeep({DW/8{1'b1}}), .s_act_tlast(s_tlast),
        .s_act_tvalid(s_tvalid), .s_act_tready(s_tready),
        .rd_en(rd_en), .rd_addr(rd_addr), .rd_data(rd_data), .rd_valid(rd_valid),
        .loaded(loaded), .beat_count(beat_count), .rel(rel));

    act_replay #(.DATA_WIDTH(DW), .ADDR_WIDTH(AW)) rp0 (
        .aclk(clk), .aresetn(rstn),
        .loaded(loaded), .beat_count(beat_count), .rel(rel),
        .rd_en(rd_en), .rd_addr(rd_addr), .rd_data(rd_data), .rd_valid(rd_valid),
        .m_axis_tdata(m_tdata), .m_axis_tkeep(m_tkeep), .m_axis_tlast(m_tlast),
        .m_axis_tvalid(m_tvalid), .m_axis_tready(m_tready));

    // Expected output, in order.
    localparam MAXQ = 40000;
    reg [DW-1:0] exp_d [0:MAXQ-1];
    reg          exp_l [0:MAXQ-1];
    integer n_exp = 0, n_got = 0, errors = 0, pkts_out = 0;
    integer valid_pct = 100, ready_pct = 100;

    always @(posedge clk) begin
        if (rstn && m_tvalid && m_tready) begin
            if (m_tdata !== exp_d[n_got] || m_tlast !== exp_l[n_got] || m_tkeep !== {DW/8{1'b1}}) begin
                errors = errors + 1;
                if (errors < 6)
                    $display("FAIL word %0d: got %h last=%b, want %h last=%b",
                             n_got, m_tdata, m_tlast, exp_d[n_got], exp_l[n_got]);
            end
            if (m_tlast) pkts_out = pkts_out + 1;
            n_got = n_got + 1;
        end
        #0.1 m_tready = ($urandom % 100) < ready_pct;
    end

    // One DMA transfer into the buffer.
    task send(input integer beats);
        integer i, k, keep;
        reg [DW-1:0] d;
        begin
            keep = (beats < MAXE) ? beats : MAXE;
            for (i = 0; i < beats; i = i + 1) begin
                for (k = 0; k < DW / 32; k = k + 1) d[k*32 +: 32] = $urandom;
                @(negedge clk);
                while (($urandom % 100) >= valid_pct) @(negedge clk);
                s_tdata = d; s_tlast = (i == beats - 1); s_tvalid = 1;
                if (i < keep) begin
                    exp_d[n_exp] = d;
                    exp_l[n_exp] = (i == keep - 1);
                    n_exp = n_exp + 1;
                end
                @(posedge clk); while (!s_tready) @(posedge clk);
                #0.1 s_tvalid = 0;
            end
        end
    endtask

    integer p, t0, t1;
    integer lens [0:9];
    initial begin
        lens[0] = 1;    lens[1] = 512;  lens[2] = 2;    lens[3] = 3072; lens[4] = 7;
        lens[5] = 3080; lens[6] = 100;  lens[7] = 512;  lens[8] = 3;    lens[9] = 1000;
        repeat (5) @(posedge clk);
        rstn = 1;

        // 1. random gaps and back-pressure, back-to-back loads
        valid_pct = 70; ready_pct = 40;
        for (p = 0; p < 10; p = p + 1)
            send(lens[p]);
        wait (n_got == n_exp);
        repeat (10) @(posedge clk);
        if (loaded) begin errors = errors + 1; $display("FAIL: buffer still loaded at the end"); end

        // 2. full rate: no stalls, 512 words should replay in ~512 cycles
        valid_pct = 100; ready_pct = 100;
        repeat (3) @(posedge clk);
        send(512);
        t0 = $time;                       // last beat just went in; loaded rises now
        wait (n_got == n_exp); t1 = $time;
        $display("replay of 512 words: %0d cycles", (t1 - t0) / 4);
        if ((t1 - t0) / 4 > 512 + 8) begin errors = errors + 1; $display("FAIL: not one word per clock"); end

        if (pkts_out != 11) begin errors = errors + 1; $display("FAIL: %0d packets out, want 11", pkts_out); end
        if (errors == 0) $display("PASS: %0d words in 11 loads (incl. 1, 3072 and an over-long 3080), all correct", n_got);
        else             $display("FAILED with %0d errors", errors);
        $finish;
    end

    initial begin
        #20_000_000;
        $display("FAIL: timeout (expected %0d words, got %0d, loaded=%b)", n_exp, n_got, loaded);
        $finish;
    end
endmodule
