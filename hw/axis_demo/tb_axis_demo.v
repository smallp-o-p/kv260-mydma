// tb_axis_demo.v - self-checking testbench for axis_demo.v
//
//   iverilog -g2005 -o tb hw/axis_demo/axis_demo.v hw/axis_demo/tb_axis_demo.v && vvp tb
//
// 1. AXI-Lite: read ID, write ADD with AW before W, W before AW, and both
//    together, read it back; byte-strobe write.
// 2. Stream: 40 packets of random length with random gaps on TVALID and
//    random back-pressure on TREADY. Every output beat must be input + ADD
//    per 32-bit word, with TKEEP and TLAST carried through.
// 3. Full rate: with TVALID and TREADY held high, one beat per clock.
// 4. BEATS / PACKETS match, and CTRL clears them.
`timescale 1ns / 1ps

module tb_axis_demo;
    localparam DW = 128;
    localparam NW = DW / 32;

    reg clk = 0, rstn = 0;
    always #2 clk = ~clk;   // 250 MHz

    // stream
    reg  [DW-1:0]   s_tdata;
    reg  [DW/8-1:0] s_tkeep;
    reg             s_tlast, s_tvalid;
    wire            s_tready;
    wire [DW-1:0]   m_tdata;
    wire [DW/8-1:0] m_tkeep;
    wire            m_tlast, m_tvalid;
    reg             m_tready;

    // AXI-Lite
    reg  [11:0] awaddr, araddr;
    reg         awvalid, wvalid, bready, arvalid, rready;
    reg  [31:0] wdata;
    reg  [3:0]  wstrb;
    wire        awready, wready, bvalid, arready, rvalid;
    wire [1:0]  bresp, rresp;
    wire [31:0] rdata;

    axis_demo #(.DATA_WIDTH(DW)) dut (
        .aclk(clk), .aresetn(rstn),
        .s_axis_tdata(s_tdata), .s_axis_tkeep(s_tkeep), .s_axis_tlast(s_tlast),
        .s_axis_tvalid(s_tvalid), .s_axis_tready(s_tready),
        .m_axis_tdata(m_tdata), .m_axis_tkeep(m_tkeep), .m_axis_tlast(m_tlast),
        .m_axis_tvalid(m_tvalid), .m_axis_tready(m_tready),
        .s_axil_awaddr(awaddr), .s_axil_awprot(3'd0), .s_axil_awvalid(awvalid), .s_axil_awready(awready),
        .s_axil_wdata(wdata), .s_axil_wstrb(wstrb), .s_axil_wvalid(wvalid), .s_axil_wready(wready),
        .s_axil_bresp(bresp), .s_axil_bvalid(bvalid), .s_axil_bready(bready),
        .s_axil_araddr(araddr), .s_axil_arprot(3'd0), .s_axil_arvalid(arvalid), .s_axil_arready(arready),
        .s_axil_rdata(rdata), .s_axil_rresp(rresp), .s_axil_rvalid(rvalid), .s_axil_rready(rready)
    );

    integer errors = 0;
    task check(input cond, input [8*64-1:0] msg);
        if (!cond) begin
            errors = errors + 1;
            $display("FAIL @%0t: %0s", $time, msg);
        end
    endtask

    // ---------------- AXI-Lite master tasks ----------------
    // order: 0 = AW and W together, 1 = AW first, 2 = W first
    task axil_write(input [11:0] a, input [31:0] d, input [3:0] s, input integer order);
        begin
            awaddr = a; wdata = d; wstrb = s;
            @(negedge clk);
            if (order != 2) awvalid = 1;
            if (order != 1) wvalid  = 1;
            while (awvalid || wvalid) begin : hs
                reg aw_hs, w_hs;
                @(posedge clk);
                aw_hs = awvalid && awready;      // sample both handshakes
                w_hs  = wvalid  && wready;       // at the same edge
                #0.1;
                if (aw_hs) begin awvalid = 0; if (order == 1) wvalid  = 1; end
                if (w_hs)  begin wvalid  = 0; if (order == 2) awvalid = 1; end
            end
            bready = 1;
            @(posedge clk); while (!bvalid) @(posedge clk);
            check(bresp == 2'b00, "BRESP not OKAY");
            #0.1 bready = 0;
        end
    endtask

    task axil_read(input [11:0] a, output [31:0] d);
        begin
            @(negedge clk);
            araddr = a; arvalid = 1;
            @(posedge clk); while (!arready) @(posedge clk);
            #0.1 arvalid = 0; rready = 1;
            @(posedge clk); while (!rvalid) @(posedge clk);
            d = rdata;
            check(rresp == 2'b00, "RRESP not OKAY");
            #0.1 rready = 0;
        end
    endtask

    // ---------------- stream source and checker ----------------
    localparam NPKT = 40;
    localparam MAXB = 600;
    reg [DW-1:0]   exp_data [0:NPKT*MAXB-1];
    reg [DW/8-1:0] exp_keep [0:NPKT*MAXB-1];
    reg            exp_last [0:NPKT*MAXB-1];
    integer n_sent = 0, n_recv = 0, n_pkts_out = 0;
    reg [31:0] add_val;
    integer valid_pct = 100, ready_pct = 100;

    // Sink: random TREADY, check every beat that moves.
    always @(posedge clk) begin
        if (rstn && m_tvalid && m_tready) begin
            if (m_tdata !== exp_data[n_recv] || m_tkeep !== exp_keep[n_recv] || m_tlast !== exp_last[n_recv]) begin
                errors = errors + 1;
                if (errors < 5)
                    $display("FAIL beat %0d: got %h/%h/%b want %h/%h/%b", n_recv,
                             m_tdata, m_tkeep, m_tlast, exp_data[n_recv], exp_keep[n_recv], exp_last[n_recv]);
            end
            if (m_tlast) n_pkts_out = n_pkts_out + 1;
            n_recv = n_recv + 1;
        end
        #0.1 m_tready = ($urandom % 100) < ready_pct;
    end

    // AXI-Stream rule: once TVALID is up, hold it and the data until accepted.
    task send_packet(input integer beats);
        integer i, k;
        reg [DW-1:0] d;
        begin
            for (i = 0; i < beats; i = i + 1) begin
                for (k = 0; k < NW; k = k + 1) d[k*32 +: 32] = $urandom;
                @(negedge clk);
                while (($urandom % 100) >= valid_pct) @(negedge clk);   // random gap
                s_tdata  = d;
                s_tlast  = (i == beats - 1);
                s_tkeep  = s_tlast ? ({DW/8{1'b1}} >> ($urandom % 4)) : {DW/8{1'b1}};
                s_tvalid = 1;
                for (k = 0; k < NW; k = k + 1) exp_data[n_sent][k*32 +: 32] = d[k*32 +: 32] + add_val;
                exp_keep[n_sent] = s_tkeep;
                exp_last[n_sent] = s_tlast;
                n_sent = n_sent + 1;
                @(posedge clk); while (!s_tready) @(posedge clk);
                #0.1 s_tvalid = 0;
            end
        end
    endtask

    integer p, t0, t1, i;
    reg [31:0] r;
    initial begin
        s_tvalid = 0; s_tlast = 0; s_tdata = 0; s_tkeep = 0; m_tready = 0;
        awvalid = 0; wvalid = 0; bready = 0; arvalid = 0; rready = 0;
        awaddr = 0; araddr = 0; wdata = 0; wstrb = 0;
        repeat (5) @(posedge clk);
        rstn = 1;

        // 1. registers
        axil_read(12'h000, r); check(r == 32'hA5D00001, "ID");
        axil_read(12'h004, r); check(r == 32'd1, "ADD reset value");
        axil_write(12'h004, 32'h1111_1111, 4'hF, 0); axil_read(12'h004, r); check(r == 32'h1111_1111, "write AW+W");
        axil_write(12'h004, 32'h2222_2222, 4'hF, 1); axil_read(12'h004, r); check(r == 32'h2222_2222, "write AW first");
        axil_write(12'h004, 32'h3333_3333, 4'hF, 2); axil_read(12'h004, r); check(r == 32'h3333_3333, "write W first");
        axil_write(12'h004, 32'h0000_00AB, 4'h1, 0); axil_read(12'h004, r); check(r == 32'h3333_33AB, "byte strobe");
        axil_write(12'h004, 32'h0000_0005, 4'hF, 0); add_val = 5;
        axil_read(12'h01C, r); check(r == 0, "unmapped reads 0");

        // 2. random traffic
        valid_pct = 60; ready_pct = 50;
        for (p = 0; p < NPKT - 1; p = p + 1)
            send_packet(1 + ($urandom % (MAXB - 1)));
        wait (n_recv == n_sent);

        // 3. full rate: one 512-beat packet, both sides always ready
        valid_pct = 100; ready_pct = 100;
        repeat (3) @(posedge clk);
        t0 = $time;
        send_packet(512);
        t1 = $time;
        wait (n_recv == n_sent);
        check((t1 - t0) <= 4 * 513, "not one beat per clock at full rate");
        $display("full rate: 512 beats in %0d cycles", (t1 - t0) / 4);

        // 4. counters
        repeat (2) @(posedge clk);
        axil_read(12'h008, r); check(r == n_sent, "BEATS");
        $display("BEATS = %0d (sent %0d)", r, n_sent);
        axil_read(12'h00C, r); check(r == NPKT, "PACKETS");
        $display("PACKETS = %0d (sent %0d)", r, NPKT);
        axil_write(12'h010, 32'h1, 4'hF, 0);
        axil_read(12'h008, r); check(r == 0, "BEATS cleared");
        axil_read(12'h00C, r); check(r == 0, "PACKETS cleared");

        check(n_pkts_out == NPKT, "packet count at sink");
        if (errors == 0) $display("PASS: %0d beats in %0d packets, all correct", n_sent, NPKT);
        else             $display("FAILED with %0d errors", errors);
        $finish;
    end

    initial begin
        #5_000_000;
        $display("FAIL: timeout (sent %0d, received %0d)", n_sent, n_recv);
        $finish;
    end
endmodule
