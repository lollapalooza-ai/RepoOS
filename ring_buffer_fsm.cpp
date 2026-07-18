#include <sys/socket.h>
#include <stdint.h>

extern "C" void process_fsm_chunk(const char* buffer, ssize_t bytes, int* state, float* out_acc);

extern "C" void _mlir_ciface_stream_main(int socket_fd, float* out_accumulator) {
    // Phase 2: Fixed 64KB unmanaged ring buffer
    char buffer[65536]; 
    ssize_t bytes_read;
    
    // Phase 3: Stream Fusion
    // The FSM state is preserved across chunk reads
    int current_state = 0; 
    
    while ((bytes_read = recv(socket_fd, buffer, sizeof(buffer), 0)) > 0) {
        // Feed the 64KB chunk directly into the compiled MLIR FSM loop
        process_fsm_chunk(buffer, bytes_read, &current_state, out_accumulator);
    }
}
