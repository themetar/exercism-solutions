#ifndef CIRCULAR_BUFFER_H
#define CIRCULAR_BUFFER_H

#include <stdlib.h>
#include <errno.h>

#define buffer_value_t int

struct buffer {
    buffer_value_t* data;
    buffer_value_t* write_point;
    buffer_value_t* read_point;
    size_t capacity;
    size_t size;
};

#define circular_buffer_t struct buffer

circular_buffer_t* new_circular_buffer(size_t capacity);

int write(circular_buffer_t* buffer, buffer_value_t value);

int overwrite(circular_buffer_t* buffer, buffer_value_t value);

buffer_value_t read(circular_buffer_t* buffer, buffer_value_t *value);

void clear_buffer(circular_buffer_t* buffer);

void delete_buffer(circular_buffer_t* buffer);

#endif
