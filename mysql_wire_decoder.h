#ifndef MYSQL_WIRE_DECODER_H
#define MYSQL_WIRE_DECODER_H

#include <stdint.h>
#include <sys/socket.h>
#include <iostream>
#include <vector>
#include <string>

// Helper to read exactly N bytes from socket
static inline bool read_exact(int sock, void* buf, size_t count) {
    size_t total = 0;
    char* p = (char*)buf;
    while (total < count) {
        ssize_t r = recv(sock, p + total, count - total, MSG_WAITALL);
        if (r <= 0) {
            return false;
        }
        total += r;
    }
    return true;
}

// Reads one MySQL packet
static inline bool read_mysql_packet(int sock, std::vector<uint8_t>& payload, uint8_t& seq_id) {
    uint8_t header[4];
    if (!read_exact(sock, header, 4)) return false;
    
    uint32_t len = header[0] | (header[1] << 8) | (header[2] << 16);
    seq_id = header[3];
    
    payload.resize(len);
    if (len > 0) {
        if (!read_exact(sock, payload.data(), len)) return false;
    }
    return true;
}

// Decodes a Length-Encoded integer
static inline uint64_t decode_lenenc_int(const std::vector<uint8_t>& payload, size_t& offset, bool& is_null) {
    is_null = false;
    if (offset >= payload.size()) return 0;
    
    uint8_t first = payload[offset++];
    if (first < 0xfb) {
        return first;
    } else if (first == 0xfb) {
        is_null = true;
        return 0;
    } else if (first == 0xfc) {
        if (offset + 1 >= payload.size()) return 0;
        uint64_t val = payload[offset] | (payload[offset+1] << 8);
        offset += 2;
        return val;
    } else if (first == 0xfd) {
        if (offset + 2 >= payload.size()) return 0;
        uint64_t val = payload[offset] | (payload[offset+1] << 8) | (payload[offset+2] << 16);
        offset += 3;
        return val;
    } else if (first == 0xfe) {
        if (offset + 7 >= payload.size()) return 0;
        uint64_t val = 0;
        for (int i=0; i<8; ++i) {
            val |= ((uint64_t)payload[offset+i]) << (8*i);
        }
        offset += 8;
        return val;
    }
    return 0;
}

// Reads packets until it consumes the column definitions and any intermediate EOF.
static inline bool consume_mysql_result_headers(int sock, std::vector<uint8_t>& first_row_payload) {
    uint8_t seq = 0;
    std::vector<uint8_t> payload;
    
    if (!read_mysql_packet(sock, payload, seq)) return false;
    
    // An OK packet or Error packet at the beginning of a result means no columns
    if (payload.size() > 0 && (payload[0] == 0x00 || payload[0] == 0xff)) {
        first_row_payload = payload;
        return true;
    }
    
    bool is_null;
    size_t offset = 0;
    uint64_t col_count = decode_lenenc_int(payload, offset, is_null);
    
    // Read column definitions
    for (uint64_t i = 0; i < col_count; ++i) {
        if (!read_mysql_packet(sock, payload, seq)) return false;
    }
    
    // Read the next packet. It might be an intermediate EOF or the first row.
    if (!read_mysql_packet(sock, payload, seq)) return false;
    
    if (payload.size() > 0 && payload[0] == 0xfe && payload.size() < 9) {
        // It was an intermediate EOF, read the next one which is the first row
        first_row_payload.clear();
        return true;
    }
    
    // It was already the first row
    first_row_payload = payload;
    return true;
}

// Parses a row payload into column strings
static inline bool parse_row(const std::vector<uint8_t>& payload, std::vector<std::string>& columns) {
    size_t offset = 0;
    while (offset < payload.size()) {
        bool is_null;
        uint64_t len = decode_lenenc_int(payload, offset, is_null);
        if (is_null) {
            columns.push_back("");
        } else {
            if (offset + len <= payload.size()) {
                columns.push_back(std::string((char*)payload.data() + offset, len));
                offset += len;
            } else {
                return false;
            }
        }
    }
    return true;
}

#endif
