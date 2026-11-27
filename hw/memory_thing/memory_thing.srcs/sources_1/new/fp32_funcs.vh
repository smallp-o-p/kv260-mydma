// fp32_funcs.vh - the three fp32 operations level 2 needs, as Verilog
// functions, each split in two halves so a register can sit between them.
// `include this inside a module.
//
// All results are IEEE-754 binary32 with round-to-nearest-even, matching
// numpy's float32 bit for bit, with one exception: denormals are flushed to
// zero (inputs and results), like Xilinx's Floating-Point IP. Level 2 never
// gets near 1e-38, so this doesn't change any real result. No NaN or Inf
// inputs are expected (scales are finite and positive).
//
//   cvt  : 44-bit signed integer x -> fp32(x) * 2^-18    (level-1 sum to float)
//   fmul : a * b
//   fadd : a + b
//
// Shared rounding: {exp, frac} + round-up bit. A carry out of the fraction
// bumps the exponent, which is exactly the right result (including 254 -> 255
// = Inf on overflow).

// ---- leading zeros of a 44-bit value (44 if zero) ----
function [5:0] fp_lzc44(input [43:0] v);
    integer i;
    reg     found;
    begin
        fp_lzc44 = 6'd44;
        found = 1'b0;
        for (i = 43; i >= 0; i = i - 1)
            if (!found && v[i]) begin
                fp_lzc44 = 6'd43 - i[5:0];
                found = 1'b1;
            end
    end
endfunction

// ---- leading zeros of a 27-bit value (27 if zero) ----
function [4:0] fp_lzc27(input [26:0] v);
    integer i;
    reg     found;
    begin
        fp_lzc27 = 5'd27;
        found = 1'b0;
        for (i = 26; i >= 0; i = i - 1)
            if (!found && v[i]) begin
                fp_lzc27 = 5'd26 - i[4:0];
                found = 1'b1;
            end
    end
endfunction

// ---- pack: sign, biased exponent (signed, may be out of range), 23-bit
//      fraction, guard bit, sticky bit -> rounded fp32 (FTZ, overflow -> Inf) ----
function [31:0] fp_round(input s, input signed [11:0] e, input [22:0] f, input g, input st);
    reg        up;
    reg [31:0] r;
    begin
        up = g & (st | f[0]);                       // round to nearest, ties to even
        if (e <= 0)        fp_round = {s, 31'd0};   // underflow: flush to zero
        else if (e >= 255) fp_round = {s, 8'hff, 23'd0};
        else begin
            r = {1'b0, e[7:0], f} + up;             // carry ripples into the exponent
            fp_round = {s, r[30:0]};
        end
    end
endfunction

// =====================================================================
// cvt: x (44-bit signed, units of 2^-18) -> fp32
//   half 1: magnitude, normalise.  half 2: round.
//   Packed between halves: {zero, sign, exp[11:0], norm[43:0]} = 58 bits
// =====================================================================
function [57:0] fp_cvt1(input [43:0] x);
    reg        s;
    reg [43:0] mag, norm;
    reg [5:0]  lz;
    reg signed [11:0] e;
    begin
        s    = x[43];
        mag  = s ? (~x + 1'b1) : x;                 // |x|; -2^43 gives 2^43, still fits
        lz   = fp_lzc44(mag);
        norm = mag << lz;                           // leading 1 at bit 43
        e    = 12'sd152 - $signed({6'd0, lz});      // 127 + 43 - 18 - lz
        fp_cvt1 = {(mag == 44'd0), s, e, norm};
    end
endfunction

function [31:0] fp_cvt2(input [57:0] h);
    reg        zero, s;
    reg signed [11:0] e;
    reg [43:0] norm;
    begin
        {zero, s, e, norm} = h;
        if (zero) fp_cvt2 = 32'd0;
        else      fp_cvt2 = fp_round(s, e, norm[42:20], norm[19], |norm[18:0]);
    end
endfunction

// =====================================================================
// fmul: a * b
//   half 1: multiply the 24-bit mantissas (one DSP pair).  half 2: normalise, round.
//   Packed: {zero, sign, exp[11:0], prod[47:0]} = 62 bits
// =====================================================================
function [61:0] fp_mul1(input [31:0] a, input [31:0] b);
    reg [47:0] prod;
    reg signed [11:0] e;
    begin
        prod = {1'b1, a[22:0]} * {1'b1, b[22:0]};
        e    = $signed({4'd0, a[30:23]}) + $signed({4'd0, b[30:23]}) - 12'sd127;
        fp_mul1 = {(a[30:23] == 8'd0) || (b[30:23] == 8'd0), a[31] ^ b[31], e, prod};
    end
endfunction

function [31:0] fp_mul2(input [61:0] h);
    reg        zero, s;
    reg signed [11:0] e;
    reg [47:0] prod;
    begin
        {zero, s, e, prod} = h;
        if (zero)          fp_mul2 = {s, 31'd0};
        else if (prod[47]) fp_mul2 = fp_round(s, e + 12'sd1, prod[46:24], prod[23], |prod[22:0]);
        else               fp_mul2 = fp_round(s, e,          prod[45:23], prod[22], |prod[21:0]);
    end
endfunction

// =====================================================================
// fadd: a + b
//   half 1: order by magnitude, align the smaller (guard, round, sticky bits).
//   half 2: add or subtract, normalise, round.
//   Packed: {zeroL, sL, sS, eL[7:0], mL[26:0], mS[26:0]} = 65 bits
//   (mantissas are {hidden 1, 23 fraction bits, guard, round, sticky})
// =====================================================================
function [64:0] fp_add1(input [31:0] a_in, input [31:0] b_in);
    reg [31:0] a, b, L, S;
    reg [7:0]  d;
    reg [23:0] mLs, mSs;
    reg [50:0] sh;
    begin
        // flush denormal inputs to signed zero first
        a = (a_in[30:23] == 8'd0) ? {a_in[31], 31'd0} : a_in;
        b = (b_in[30:23] == 8'd0) ? {b_in[31], 31'd0} : b_in;
        if (a[30:0] >= b[30:0]) begin L = a; S = b; end
        else                    begin L = b; S = a; end
        mLs = (L[30:23] == 8'd0) ? 24'd0 : {1'b1, L[22:0]};
        mSs = (S[30:23] == 8'd0) ? 24'd0 : {1'b1, S[22:0]};
        d   = L[30:23] - S[30:23];
        sh  = {mSs, 27'd0} >> ((d > 8'd50) ? 8'd50 : d);
        fp_add1 = {(L[30:23] == 8'd0), L[31], S[31], L[30:23],
                   {mLs, 3'b000},
                   {sh[50:25], |sh[24:0]}};         // 24 + guard + round, then sticky
    end
endfunction

function [31:0] fp_add2(input [64:0] h);
    reg        zeroL, sL, sS;
    reg [7:0]  eL;
    reg [26:0] mL, mS, m;
    reg [27:0] sum;
    reg [4:0]  lz;
    reg signed [11:0] e;
    begin
        {zeroL, sL, sS, eL, mL, mS} = h;
        if (zeroL)                                  // both zero: -0 only if both are -0
            fp_add2 = {sL & sS, 31'd0};
        else begin
            sum = (sL == sS) ? ({1'b0, mL} + {1'b0, mS}) : ({1'b0, mL} - {1'b0, mS});
            if (sum == 28'd0)
                fp_add2 = 32'd0;                    // exact cancellation is +0
            else if (sum[27]) begin                 // carry: shift right one
                m = {sum[27:2], sum[1] | sum[0]};
                e = $signed({4'd0, eL}) + 12'sd1;
                fp_add2 = fp_round(sL, e, m[25:3], m[2], |m[1:0]);
            end else begin                          // normalise left
                lz = fp_lzc27(sum[26:0]);
                m  = sum[26:0] << lz;
                e  = $signed({4'd0, eL}) - $signed({7'd0, lz});
                fp_add2 = fp_round(sL, e, m[25:3], m[2], |m[1:0]);
            end
        end
    end
endfunction

// =====================================================================
// Finer stages, for 250 MHz (Nov 27). Same arithmetic as the functions
// above, cut into pieces with a register between each. level2.v uses these;
// tb_fp32.v checks that each chain gives exactly the same bits.
//
//   cvt : fp_cvt_a -> fp_cvt_b -> fp_cvt_c -> fp_cvt2            (= fp_cvt2(fp_cvt1(x)))
//   fmul: fp_mul1  -> (extra register, for the DSP) -> fp_mul2   (unchanged)
//   fadd: fp_add_a -> fp_add_b -> fp_add_c -> fp_add_d -> fp_add_e
//         -> fp_add_f -> fp_add_g -> fp_add_h                    (= fp_add2(fp_add1(a, b)))
// =====================================================================

// ---- cvt a: magnitude.  Packed {s, mag[43:0]} = 45 bits ----
function [44:0] fp_cvt_a(input [43:0] x);
    begin
        fp_cvt_a = {x[43], x[43] ? (~x + 1'b1) : x};
    end
endfunction

// ---- cvt b: leading zeros.  Packed {s, lz[5:0], mag[43:0]} = 51 bits ----
function [50:0] fp_cvt_b(input [44:0] h);
    begin
        fp_cvt_b = {h[44], fp_lzc44(h[43:0]), h[43:0]};
    end
endfunction

// ---- cvt c: normalise.  Packed like fp_cvt1: {zero, s, e[11:0], norm[43:0]} ----
function [57:0] fp_cvt_c(input [50:0] h);
    reg        s;
    reg [5:0]  lz;
    reg [43:0] mag;
    begin
        {s, lz, mag} = h;
        fp_cvt_c = {(mag == 44'd0), s, 12'sd152 - $signed({6'd0, lz}), mag << lz};
    end
endfunction

// ---- add a: flush denormal inputs, order by magnitude.  Packed {L, S} = 64 bits ----
function [63:0] fp_add_a(input [31:0] a_in, input [31:0] b_in);
    reg [31:0] a, b;
    begin
        a = (a_in[30:23] == 8'd0) ? {a_in[31], 31'd0} : a_in;
        b = (b_in[30:23] == 8'd0) ? {b_in[31], 31'd0} : b_in;
        fp_add_a = (a[30:0] >= b[30:0]) ? {a, b} : {b, a};
    end
endfunction

// ---- add b: exponent difference (clamped to 50), mantissas.
//      Packed {zeroL, sL, sS, eL[7:0], mL[23:0], mS[23:0], d[5:0]} = 65 bits ----
function [64:0] fp_add_b(input [63:0] h);
    reg [31:0] L, S;
    reg [7:0]  d;
    begin
        {L, S} = h;
        d = L[30:23] - S[30:23];
        fp_add_b = {(L[30:23] == 8'd0), L[31], S[31], L[30:23],
                    (L[30:23] == 8'd0) ? 24'd0 : {1'b1, L[22:0]},
                    (S[30:23] == 8'd0) ? 24'd0 : {1'b1, S[22:0]},
                    (d > 8'd50) ? 6'd50 : d[5:0]};
    end
endfunction

// ---- add c: align the smaller mantissa.
//      Packed {zeroL, sL, sS, eL[7:0], mL[23:0], sh[50:0]} = 86 bits ----
function [85:0] fp_add_c(input [64:0] h);
    begin
        fp_add_c = {h[64:30], {h[29:6], 27'd0} >> h[5:0]};
    end
endfunction

// ---- add d: sticky bit.  Packed like fp_add1 (65 bits) ----
function [64:0] fp_add_d(input [85:0] h);
    begin
        fp_add_d = {h[85:51], 3'b000, h[50:25], |h[24:0]};
    end
endfunction

// ---- add e: add or subtract.  Packed {zeroL, sL, sS, eL[7:0], sum[27:0]} = 39 bits ----
function [38:0] fp_add_e(input [64:0] h);
    reg        zeroL, sL, sS;
    reg [7:0]  eL;
    reg [26:0] mL, mS;
    begin
        {zeroL, sL, sS, eL, mL, mS} = h;
        fp_add_e = {zeroL, sL, sS, eL,
                    (sL == sS) ? ({1'b0, mL} + {1'b0, mS}) : ({1'b0, mL} - {1'b0, mS})};
    end
endfunction

// ---- add f: leading zeros.  Packed {zeroL, sL, sS, eL[7:0], sum[27:0], lz[4:0]} = 44 bits ----
function [43:0] fp_add_f(input [38:0] h);
    begin
        fp_add_f = {h, fp_lzc27(h[26:0])};
    end
endfunction

// ---- add g: normalise.  Packed {special, rsign, s, e[11:0], m[26:0]} = 42 bits
//      special = the result is a zero (sign rsign) and needs no rounding ----
function [41:0] fp_add_g(input [43:0] h);
    reg        zeroL, sL, sS;
    reg [7:0]  eL;
    reg [27:0] sum;
    reg [4:0]  lz;
    begin
        {zeroL, sL, sS, eL, sum, lz} = h;
        if (zeroL)                                  // both zero: -0 only if both are -0
            fp_add_g = {1'b1, sL & sS, 40'd0};
        else if (sum == 28'd0)                      // exact cancellation is +0
            fp_add_g = {1'b1, 1'b0, 40'd0};
        else if (sum[27])                           // carry: shift right one
            fp_add_g = {1'b0, 1'b0, sL, $signed({4'd0, eL}) + 12'sd1, {sum[27:2], sum[1] | sum[0]}};
        else                                        // normalise left
            fp_add_g = {1'b0, 1'b0, sL, $signed({4'd0, eL}) - $signed({7'd0, lz}), sum[26:0] << lz};
    end
endfunction

// ---- add h: round ----
function [31:0] fp_add_h(input [41:0] h);
    reg        special, rs, s;
    reg signed [11:0] e;
    reg [26:0] m;
    begin
        {special, rs, s, e, m} = h;
        if (special) fp_add_h = {rs, 31'd0};
        else         fp_add_h = fp_round(s, e, m[25:3], m[2], |m[1:0]);
    end
endfunction
