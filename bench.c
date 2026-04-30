#include "array.h"
#include "bench.h"

#define ITERS  1000000
#define WARMUP 100
#define BATCH  100

volatile int sink = 0;

int main(void) {
    int* numbers;

    BENCH("Array alloc+free", ITERS, WARMUP, BATCH, {
        ARRAY(numbers, 100);
        sink += numbers[0];
        ARRAY_FREE(numbers);
    });

    (void)sink;

    exit(EXIT_SUCCESS);
}
