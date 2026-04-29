#pragma once

#include <stdlib.h>

typedef struct {
    size_t count;
    size_t capacity;
} array_header_t;

#define ARRAY(ptr, cap) do { \
    size_t capacity = (cap) ? (cap) : 4; \
    array_header_t* h = malloc(sizeof(*(ptr)) * capacity + sizeof(array_header_t)); \
    if (!h) { \
        (ptr) = NULL; \
        break; \
    } \
    h->capacity = capacity; \
    h->count = 0; \
    (ptr) = (void*) (h + 1); \
} while (0)

#define ARRAY_HEADER(ptr) ((array_header_t*) ((ptr)) - 1)
#define ARRAY_CAPACITY(ptr) (ARRAY_HEADER((ptr))->capacity)
#define ARRAY_COUNT(ptr) (ARRAY_HEADER((ptr))->count)

#define ARRAY_FREE(ptr) do { if ((ptr)) free(ARRAY_HEADER((ptr))); } while (0)

#define ARRAY_APPEND(ptr, item) do { \
    if (!(ptr)) break; \
    array_header_t* h = ARRAY_HEADER((ptr)); \
    if (h->count == h->capacity) { \
        size_t ncap = h->capacity * 2; \
        array_header_t* nh = realloc(h, sizeof(array_header_t) + sizeof(*(ptr)) * ncap); \
        if (!nh) break; \
        nh->capacity = ncap; \
        (ptr) = (void*) (nh + 1); \
        h = nh; \
    } \
    (ptr)[h->count++] = (item);\
} while (0)

#define ARRAY_POP(ptr) ((ptr)[--ARRAY_COUNT(ptr)])

#define ARRAY_SHRINK_TO_FIT(ptr) do { \
    if (!(ptr)) break; \
    array_header_t* h = ARRAY_HEADER((ptr)); \
    size_t ncap = h->count; \
    array_header_t* nh = realloc(h, sizeof(array_header_t) + sizeof(*(ptr)) * ncap); \
    if (!nh) break; \
    nh->capacity = ncap; \
    nh->count = ncap; \
    (ptr) = (void*) (nh + 1); \
} while (0)
    
