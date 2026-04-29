#include <stdio.h>
#include <stdint.h>
#include "array.h"
#include "test.h"

int main(void) {
    TEST_SECTION("Array initialization") {
        int* numbers = NULL;
        ARRAY(numbers, 10);

        CHECK_NOT_NULL(
            numbers,
            "Array pointer is not null",
            ""
        );

        CHECK_BOOL(
            ARRAY_CAPACITY(numbers) == 10,
            "Array capacity matches given input value", 
            "(%zu != %zu)\n", (size_t)8, ARRAY_CAPACITY(numbers)
        );

        CHECK_BOOL(
            ARRAY_COUNT(numbers) == 0,
            "Array count is 0 at initialization", 
            "(%zu != %zu)\n", (size_t)0, ARRAY_COUNT(numbers)
        );
    };

    TEST_SUMMARY();

    return 0;
}
