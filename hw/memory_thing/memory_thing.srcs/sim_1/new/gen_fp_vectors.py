"""Random + edge-case vectors for tb_fp32.v: numpy float32 is the reference.
    python3 gen_fp_vectors.py <out dir> [count]
Cases whose inputs or result would be denormal (or Inf/NaN) are skipped:
the RTL flushes denormals to zero on purpose."""
import sys, os
import numpy as np
out = sys.argv[1]; n = int(sys.argv[2]) if len(sys.argv) > 2 else 200000
os.makedirs(out, exist_ok=True)
rng = np.random.default_rng(7)
TINY = np.finfo(np.float32).tiny

def ok(*vals):
    for v in vals:
        v = np.float32(v)
        if not np.isfinite(v) or (v != 0 and abs(v) < TINY): return False
    return True

def rand_f32(k):
    # random sign, exponent spread over most of the range, random mantissa
    bits = (rng.integers(0, 2, k, dtype=np.uint32) << 31) | \
           (rng.integers(1, 255, k, dtype=np.uint32) << 23) | rng.integers(0, 1 << 23, k, dtype=np.uint32)
    return bits.view(np.float32)

# ---- cvt: int44 -> fp32 * 2^-18 ----
lens = rng.integers(0, 44, n)
xs = [int(rng.integers(0, 1 << int(L))) if L else 0 for L in lens]
xs = [(-x if rng.integers(0, 2) else x) for x in xs]
xs += [0, 1, -1, (1 << 43) - 1, -(1 << 43), (1 << 24) + 1, (1 << 25) + 3, -(1 << 25) - 1, (1 << 26) + 2]
with open(f"{out}/cvt.hex", "w") as f:
    for x in xs:
        y = np.float32(np.float32(x) * np.float32(2.0 ** -18))   # int64 -> f32 is RNE
        f.write(f"{x & ((1 << 44) - 1):011x} {np.float32(y).view(np.uint32):08x}\n")

# ---- mul ----
a, b = rand_f32(n), rand_f32(n)
a2 = rand_f32(n // 4); b2 = (rng.random(n // 4) * 4).astype(np.float32)   # scale-like
a, b = np.concatenate([a, a2]), np.concatenate([b, b2])
with np.errstate(all="ignore"):
    p = (a * b).astype(np.float32)
with open(f"{out}/mul.hex", "w") as f:
    for x, y, z in zip(a, b, p):
        if ok(x, y, z):
            f.write(f"{x.view(np.uint32):08x} {y.view(np.uint32):08x} {z.view(np.uint32):08x}\n")

# ---- add: random, close exponents, near-cancellation, zeros ----
a = rand_f32(n)
b1 = rand_f32(n // 2)
b2 = (a[: n // 2] * (1 + rng.standard_normal(n // 2) * 1e-3)).astype(np.float32)   # close magnitude
b3 = (-a[: n // 4] * (1 + rng.integers(-8, 9, n // 4) * 2.0 ** -23)).astype(np.float32)  # cancellation
b4 = (a[: n // 4] * np.float32(2.0) ** rng.integers(-30, 30, n // 4).astype(np.float32)).astype(np.float32)
bb = np.concatenate([b1, b2, b3, b4]); aa = np.concatenate([a[: n // 2], a[: n // 2], a[: n // 4], a[: n // 4]])
extra = [(0.0, 0.0), (-0.0, -0.0), (0.0, -0.0), (-0.0, 0.0), (1.0, -1.0), (-2.5, 2.5), (0.0, 3.0), (-0.0, -3.0), (1.0, 2.0 ** -30)]
with np.errstate(all="ignore"):
    s = (aa + bb).astype(np.float32)
with open(f"{out}/add.hex", "w") as f:
    for x, y, z in list(zip(aa, bb, s)) + [(np.float32(x), np.float32(y), np.float32(np.float32(x) + np.float32(y))) for x, y in extra]:
        if ok(x, y, z):
            f.write(f"{np.float32(x).view(np.uint32):08x} {np.float32(y).view(np.uint32):08x} {np.float32(z).view(np.uint32):08x}\n")
for name in ("cvt", "mul", "add"):
    print(name, sum(1 for _ in open(f"{out}/{name}.hex")), "vectors")
