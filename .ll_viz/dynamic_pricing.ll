; ModuleID = '<string>'
source_filename = "<string>"
target triple = "arm64-apple-darwin25.2.0"

define double @dynamic_pricing(double %.1, double %.2) {
entry:
  %.7 = fcmp ogt double %.2, 1.000000e+00
  %.12 = select i1 %.7, double %.2, double 1.000000e+00
  %.18 = fmul double %.1, %.12
  ret double %.18
}
