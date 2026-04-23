; ModuleID = '<string>'
source_filename = "<string>"
target triple = "arm64-apple-darwin25.2.0"

define double @compute_gravity(double %.1, double %.2) {
entry:
  %.8 = fmul double %.1, %.2
  %.11 = fdiv double %.8, 9.810000e+00
  %.14 = fmul double %.1, 5.000000e-01
  %.18 = fadd double %.14, %.11
  %.21 = fmul double %.2, 2.000000e-01
  %.25 = fsub double %.18, %.21
  ret double %.25
}
