#include "circular_buffer.h"
#include <stdlib.h>

circular_buffer_t* new_circular_buffer(size_t capacity) {
    circular_buffer_t* buffer = malloc(sizeof(circular_buffer_t));
    buffer->data = buffer->read_point = buffer->write_point = malloc(capacity * sizeof(buffer_value_t));
    buffer->capacity = capacity;
    buffer->size = 0;
    return buffer;
}

int write(circular_buffer_t* buffer, buffer_value_t value) {
    if (buffer->size < buffer->capacity) {
        *(buffer->write_point) = value;
        buffer->size++;
        buffer->write_point += sizeof(buffer_value_t);
        if (buffer->write_point > buffer->data + (buffer->capacity - 1) * sizeof(buffer_value_t))
            buffer->write_point = buffer->data;
        return EXIT_SUCCESS;
    }

    errno = ENOBUFS;
    return EXIT_FAILURE;
}

int overwrite(circular_buffer_t* buffer, buffer_value_t value) {
    if (buffer->size == buffer->capacity) {
        buffer->read_point += sizeof(buffer_value_t);
        if (buffer->read_point > buffer->data + (buffer->capacity - 1) * sizeof(buffer_value_t))
            buffer->read_point = buffer->data;
        buffer->size--;
    }

    return write(buffer, value);
}

buffer_value_t read(circular_buffer_t* buffer, buffer_value_t *value) {
    if (buffer->size > 0) {
        *value = *(buffer->read_point);
        buffer->read_point += sizeof(buffer_value_t);
        if (buffer->read_point > buffer->data + (buffer->capacity - 1) * sizeof(buffer_value_t))
            buffer->read_point = buffer->data;
        buffer->size--;
        return EXIT_SUCCESS;
    }

    errno = ENODATA;
    return EXIT_FAILURE;
}

void clear_buffer(circular_buffer_t* buffer) {
    buffer->size = 0;
}

void delete_buffer(circular_buffer_t* buffer) {
    free(buffer->data);
    free(buffer);
}
