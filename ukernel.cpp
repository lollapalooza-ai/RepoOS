#include <cstdint>
#include <cblas.h>
#include <iostream>

extern "C" {

void ukernel_bmm(
    float* A_alloc, float* A_align, int64_t A_off, int64_t A_s0, int64_t A_s1, int64_t A_s2, int64_t A_st0, int64_t A_st1, int64_t A_st2,
    float* B_alloc, float* B_align, int64_t B_off, int64_t B_s0, int64_t B_s1, int64_t B_s2, int64_t B_st0, int64_t B_st1, int64_t B_st2,
    float* C_alloc, float* C_align, int64_t C_off, int64_t C_s0, int64_t C_s1, int64_t C_s2, int64_t C_st0, int64_t C_st1, int64_t C_st2
) {
    int64_t batch = A_s0;
    int64_t M = A_s1;
    int64_t K = A_s2;
    int64_t N = B_s2;

    for (int64_t b = 0; b < batch; ++b) {
        cblas_sgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans,
                    M, N, K, 1.0f,
                    A_align + A_off + b * A_st0, A_st1,
                    B_align + B_off + b * B_st0, B_st1,
                    0.0f,
                    C_align + C_off + b * C_st0, C_st1);
    }
}

}
