#include "circular_buffer.h"
#include <stdlib.h>
#include <errno.h>

circular_buffer_t* new_circular_buffer(size_t capacity) {
    circular_buffer_t* buffer = malloc(sizeof(circular_buffer_t) + capacity * sizeof(buffer_value_t));
    buffer->read_point = buffer->write_point = buffer->data;
    buffer->capacity = capacity;
    buffer->size = 0;
    return buffer;
}

static inline void advance_pointer(buffer_value_t** pointer, size_t length, buffer_value_t* start) {
    (*pointer)++;
    if (*pointer > start + (length - 1))
        *pointer = start;
}

int write(circular_buffer_t* buffer, buffer_value_t value) {
    if (buffer->size < buffer->capacity) {
        *(buffer->write_point) = value;
        buffer->size++;
        advance_pointer(&buffer->write_point, buffer->capacity, buffer->data);
        return EXIT_SUCCESS;
    }

    errno = ENOBUFS;
    return EXIT_FAILURE;
}

int overwrite(circular_buffer_t* buffer, buffer_value_t value) {
    if (buffer->size == buffer->capacity) {
        advance_pointer(&buffer->read_point, buffer->capacity, buffer->data);
        buffer->size--;
    }

    return write(buffer, value);
}

buffer_value_t read(circular_buffer_t* buffer, buffer_value_t* value) {
    if (buffer->size > 0) {
        *value = *buffer->read_point;
        buffer->size--;
        advance_pointer(&buffer->read_point, buffer->capacity, buffer->data);
        return EXIT_SUCCESS;
    }

    errno = ENODATA;
    return EXIT_FAILURE;
}

void clear_buffer(circular_buffer_t* buffer) {
    buffer->size = 0;
}

void delete_buffer(circular_buffer_t* buffer) {
    free(buffer);
}
