#include "array.h"
#include "bench.h"

#define ITERS  1000000
#define WARMUP 100
#define BATCH  100

volatile int sink = 0;

int main(void) {
    int* numbers;

    BENCH("Array alloc+free", ITERS, BATCH, WARMUP, {
        ARRAY(numbers, 100);
        numbers[0] = 1;
        sink += numbers[0];
        ARRAY_FREE(numbers);
    });

    ARRAY(numbers, 10000);

    BENCH("Array append (no resize)", ITERS, 1, WARMUP, {
        ARRAY_CLEAR(numbers);
        for (int i = 0; i < 10000; ++i) {
            ARRAY_APPEND(numbers, i);
            sink += numbers[i];
        }
    });

    BENCH("Array append (resize)", ITERS, 1, WARMUP, {
        ARRAY_FREE(numbers);
        ARRAY(numbers, 10);
        for (int i = 0; i < 10000; ++i) {
            ARRAY_APPEND(numbers, i);
            sink += numbers[i];
        }
    });

    ARRAY_FREE(numbers);

    (void)sink;

    exit(EXIT_SUCCESS);
}
