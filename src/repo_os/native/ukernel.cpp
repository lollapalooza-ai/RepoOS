#include <cstdint>
#include <cblas.h>
#include <cmath>
#include <omp.h>
#include <vector>

extern "C" {

void openblas_set_num_threads(int num_threads);

// Legacy BMM UKernel
void ukernel_bmm(
    float* A, float* A_aligned, int64_t A_offset, int64_t A_s0, int64_t A_s1, int64_t A_s2, int64_t A_s3,
    float* B, float* B_aligned, int64_t B_offset, int64_t B_s0, int64_t B_s1, int64_t B_s2, int64_t B_s3,
    float* C, float* C_aligned, int64_t C_offset, int64_t C_s0, int64_t C_s1, int64_t C_s2, int64_t C_s3
) {
    int64_t batch = A_s0;
    int64_t M = A_s1;
    int64_t K = A_s2;
    int64_t N = B_s2;

    #pragma omp parallel for
    for (int64_t b = 0; b < batch; ++b) {
        cblas_sgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans,
                    M, N, K, 1.0f,
                    A_aligned + A_offset + b * (M * K), K,
                    B_aligned + B_offset + b * (K * N), N,
                    0.0f,
                    C_aligned + C_offset + b * (M * N), N);
    }
}

// Mega-UKernel: Fused Attention (FlashAttention-style macro block)
void fused_attention_ukernel(
    float* Q, float* K, float* V, float* Out, 
    int batch_size, int seq_len, int head_dim
) {
    // 1. The OpenMP God-Loop (4.0 CPUs Guaranteed)
    #pragma omp parallel for
    for (int b = 0; b < batch_size; ++b) {
        
        // Calculate memory offsets for this specific batch/head
        int offset_q = b * (seq_len * head_dim);
        int offset_k = b * (seq_len * head_dim);
        int offset_v = b * (seq_len * head_dim);
        int offset_out = b * (seq_len * head_dim);
        
        // Temporary thread-local buffer for the attention scores (Score = Q * K^T)
        // Size: seq_len * seq_len
        std::vector<float> Score(seq_len * seq_len, 0.0f);
        
        // --- STEP A: Q * K^T (Using OpenBLAS) ---
        // Q: seq_len x head_dim
        // K^T: head_dim x seq_len
        // Score: seq_len x seq_len
        cblas_sgemm(CblasRowMajor, CblasNoTrans, CblasTrans,
                    seq_len, seq_len, head_dim, 1.0f,
                    Q + offset_q, head_dim,
                    K + offset_k, head_dim,
                    0.0f,
                    Score.data(), seq_len);
        
        // --- STEP B: Softmax (Pure C++) ---
        // Because we are inside the OpenMP loop, this runs safely across cores without noalias bugs!
        float scale = 1.0f / std::sqrt((float)head_dim);
        for (int i = 0; i < seq_len; ++i) {
            float max_val = -INFINITY;
            int row_offset = i * seq_len;
            
            // Find Max (Causal Mask: only j <= i)
            for (int j = 0; j <= i; ++j) {
                float val = Score[row_offset + j] * scale;
                Score[row_offset + j] = val; // apply scale inline
                if (val > max_val) max_val = val;
            }
            // Apply mask to future tokens
            for (int j = i + 1; j < seq_len; ++j) {
                Score[row_offset + j] = -INFINITY;
            }
            
            // Calculate Exp and Sum
            float sum = 0.0f;
            for (int j = 0; j <= i; ++j) {
                float e = std::exp(Score[row_offset + j] - max_val);
                Score[row_offset + j] = e;
                sum += e;
            }
            // Masked elements exp(-inf) = 0
            for (int j = i + 1; j < seq_len; ++j) {
                Score[row_offset + j] = 0.0f;
            }
            
            // Divide by Sum
            float inv_sum = 1.0f / sum;
            for (int j = 0; j <= i; ++j) {
                Score[row_offset + j] *= inv_sum;
            }
        }
        
        // --- STEP C: Score * V (Using OpenBLAS) ---
        // Score: seq_len x seq_len
        // V: seq_len x head_dim
        // Out: seq_len x head_dim
        cblas_sgemm(CblasRowMajor, CblasNoTrans, CblasNoTrans,
                    seq_len, head_dim, seq_len, 1.0f,
                    Score.data(), seq_len,
                    V + offset_v, head_dim,
                    0.0f,
                    Out + offset_out, head_dim);
    }
}

} // extern "C"
