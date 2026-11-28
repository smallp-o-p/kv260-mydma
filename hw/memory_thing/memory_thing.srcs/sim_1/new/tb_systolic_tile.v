`timescale 1ns / 1ps
// tb_systolic_tile.v - checks every PE of systolic_tile.v on its own.
//
//   For each of GROUPS groups: pulse t_clear, send STEPS steps of random E4M3
//   codes (all 256 codes, NaN included) on every row and column, with random
//   gaps, wait for t_done, then compare all ROWS x N sums with
//   sum over k of value(a[r][k]) * value(b[c][k]) computed here.
//   It also checks that t_done is never 1 while a sum is still changing, and
//   that t_c is row 0.
//
//   iverilog -g2005 -o tbs tb_systolic_tile.v ../../sources_1/new/systolic_tile.v ../../sources_1/new/pe_mac.v && vvp tbs
//   (-DROWS=1 for the decode build; default 16)
`ifndef ROWS
 `define ROWS 16
`endif
module tb_systolic_tile;
    localparam N = 16, ROWS = `ROWS, GROUPS = 40, STEPS = 128;

    reg clk = 0, rstn = 0;
    always #2 clk = ~clk;

    reg              t_valid = 0, t_clear = 0;
    reg  [8*N-1:0]   t_a = 0, t_b = 0;
    wire             t_done;
    wire [N*44-1:0]  t_c;
    systolic_tile #(.N(N), .ROWS(ROWS)) tile (
        .aclk(clk), .aresetn(rstn), .t_valid(t_valid), .t_clear(t_clear),
        .t_a(t_a), .t_b(t_b), .t_done(t_done), .t_c(t_c));

    // E4M3 code -> value * 2^9 (the golden model's table), NaN -> 0
    function signed [47:0] val(input [7:0] c);
        reg [17:0] mag;
        begin
            if (c[6:0] == 7'h7f)      mag = 0;
            else if (c[6:3] == 0)     mag = c[2:0];
            else                      mag = {1'b1, c[2:0]} << (c[6:3] - 1);
            val = c[7] ? -$signed({30'd0, mag}) : $signed({30'd0, mag});
        end
    endfunction

    reg signed [47:0] want [0:ROWS*N-1];
    integer g, k, r, c, bad = 0, early = 0;
    reg [7:0] ca, cb;

    // t_done must not be 1 in a clock where some sum then changes
    reg signed [47:0] prev [0:ROWS*N-1];
    reg done_q = 0;
    integer q;
    always @(posedge clk) begin
        for (q = 0; q < ROWS*N; q = q + 1) begin
            if (done_q && !t_clear_q && tile.p[q] !== prev[q]) early = early + 1;
            prev[q] <= tile.p[q];
        end
        done_q <= t_done;
    end
    reg t_clear_q = 0;
    always @(posedge clk) t_clear_q <= t_clear;

    initial begin
        repeat (5) @(posedge clk);
        rstn = 1;
        for (g = 0; g < GROUPS; g = g + 1) begin
            @(negedge clk); t_clear = 1;
            @(negedge clk); t_clear = 0;
            for (r = 0; r < ROWS*N; r = r + 1) want[r] = 0;
            for (k = 0; k < STEPS; k = k + 1) begin
                while (($random & 3) == 0) begin t_valid = 0; @(negedge clk); end   // random gap
                for (r = 0; r < N; r = r + 1) begin
                    // groups 0/1: the largest sums (+448 * +448, -448 * +448)
                    ca = (g == 0) ? 8'h7e : (g == 1) ? 8'hfe : $random;
                    cb = (g < 2) ? 8'h7e : $random;
                    t_a[8*r +: 8] = ca;
                    t_b[8*r +: 8] = cb;
                end
                for (r = 0; r < ROWS; r = r + 1)
                    for (c = 0; c < N; c = c + 1)
                        want[r*N + c] = want[r*N + c] + val(t_a[8*r +: 8]) * val(t_b[8*c +: 8]);
                t_valid = 1;
                @(negedge clk);
            end
            t_valid = 0;
            @(negedge clk);
            while (!t_done) @(negedge clk);
            for (r = 0; r < ROWS; r = r + 1)
                for (c = 0; c < N; c = c + 1)
                    if (tile.p[r*N + c] !== want[r*N + c]) begin
                        bad = bad + 1;
                        if (bad < 6) $display("group %0d PE(%0d,%0d): got %0d, want %0d", g, r, c, tile.p[r*N + c], want[r*N + c]);
                    end
            for (c = 0; c < N; c = c + 1)
                if (t_c[44*c +: 44] !== want[c][43:0]) begin
                    bad = bad + 1;
                    if (bad < 6) $display("group %0d t_c column %0d wrong", g, c);
                end
            repeat ($random & 7) @(negedge clk);
        end
        if (early != 0) begin $display("FAIL: t_done was 1 while a sum changed (%0d times)", early); bad = bad + 1; end
        if (bad == 0) $display("PASS: %0d groups x %0d steps, all %0d x %0d sums exact, t_done never early", GROUPS, STEPS, ROWS, N);
        else          $display("FAIL: %0d errors", bad);
        $finish;
    end
endmodule
