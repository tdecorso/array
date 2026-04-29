#pragma once

#include <stdlib.h>
#include <assert.h>

typedef struct {
    size_t count;
    size_t capacity;
} array_header_t;

#define ARRAY(ptr, cap) do { \
    size_t capacity = (cap) ? (cap) : 4; \
    array_header_t* h = malloc(sizeof(*(ptr)) * capacity + sizeof(array_header_t)); \
    assert(h); \
    h->capacity = capacity; \
    h->count = 0; \
    (ptr) = (void*) (h + 1); \
} while (0)

#define ARRAY_HEADER(ptr) ((array_header_t*) ((ptr)) - 1)
#define ARRAY_CAPACITY(ptr) (ARRAY_HEADER((ptr))->capacity)
#define ARRAY_COUNT(ptr) (ARRAY_HEADER((ptr))->count)
    
