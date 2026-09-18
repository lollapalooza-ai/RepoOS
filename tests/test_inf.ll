define void @test(ptr %p) {
  store float 0xFFF0000000000000, ptr %p, align 4
  ret void
}
