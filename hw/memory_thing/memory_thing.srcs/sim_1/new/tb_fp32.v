`timescale 1ns / 1ps
// tb_fp32.v - checks fp32_funcs.vh against numpy (vectors from gen_fp_vectors.py),
// and that the staged cvt/add chains level2.v uses give the same bits.
//   python3 gen_fp_vectors.py fpvec && iverilog -g2005 -I ../../sources_1/new -o tbfp tb_fp32.v && vvp tbfp +dir=fpvec
module tb_fp32;
    `include "fp32_funcs.vh"
    reg [1023:0] dir, path;
    integer fd, r, n, bad;
    reg [43:0] x;
    reg [31:0] a, b, want, got;
    initial begin
        if (!$value$plusargs("dir=%s", dir)) dir = "fpvec";
        // cvt
        $sformat(path, "%0s/cvt.hex", dir); fd = $fopen(path, "r"); n = 0; bad = 0;
        while ($fscanf(fd, "%h %h\n", x, want) == 2) begin
            got = fp_cvt2(fp_cvt1(x)); n = n + 1;
            if (fp_cvt2(fp_cvt_c(fp_cvt_b(fp_cvt_a(x)))) !== got) begin bad = bad + 1; if (bad < 6) $display("cvt %h: staged chain differs", x); end
            if (got !== want) begin bad = bad + 1; if (bad < 6) $display("cvt %h: got %h want %h", x, got, want); end
        end
        $fclose(fd); $display("cvt: %0d vectors, %0d wrong", n, bad); r = bad;
        // mul
        $sformat(path, "%0s/mul.hex", dir); fd = $fopen(path, "r"); n = 0; bad = 0;
        while ($fscanf(fd, "%h %h %h\n", a, b, want) == 3) begin
            got = fp_mul2(fp_mul1(a, b)); n = n + 1;
            if (got !== want) begin bad = bad + 1; if (bad < 6) $display("mul %h * %h: got %h want %h", a, b, got, want); end
        end
        $fclose(fd); $display("mul: %0d vectors, %0d wrong", n, bad); r = r + bad;
        // add
        $sformat(path, "%0s/add.hex", dir); fd = $fopen(path, "r"); n = 0; bad = 0;
        while ($fscanf(fd, "%h %h %h\n", a, b, want) == 3) begin
            got = fp_add2(fp_add1(a, b)); n = n + 1;
            if (fp_add_h(fp_add_g(fp_add_f(fp_add_e(fp_add_d(fp_add_c(fp_add_b(fp_add_a(a, b)))))))) !== got) begin
                bad = bad + 1; if (bad < 6) $display("add %h + %h: staged chain differs", a, b); end
            if (got !== want) begin bad = bad + 1; if (bad < 6) $display("add %h + %h: got %h want %h", a, b, got, want); end
        end
        $fclose(fd); $display("add: %0d vectors, %0d wrong", n, bad); r = r + bad;
        if (r == 0) $display("PASS: fp32 functions match numpy"); else $display("FAIL");
        $finish;
    end
endmodule
