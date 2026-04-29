#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include "array.h"
#include "test.h"

int main(void) {

    int* numbers = NULL;

    TEST_SECTION("Array initialization & Free") {

        ARRAY(numbers, 0);

        if (!numbers) exit(EXIT_FAILURE);

        CHECK_BOOL(
            ARRAY_CAPACITY(numbers) == 4,
            "Default array capacity if not specified",
            ""
        );

        CHECK_BOOL(
            ARRAY_COUNT(numbers) == 0,
            "Array count is 0 at initialization", 
            "(%zu != %zu)", (size_t)0, ARRAY_COUNT(numbers)
        );

        ARRAY_FREE(numbers);
        ARRAY(numbers, 5);

        CHECK_BOOL(
            ARRAY_CAPACITY(numbers) == 5,
            "Array capacity matches given input value", 
            "(%zu != %zu)", (size_t)8, ARRAY_CAPACITY(numbers)
        );
    };

    TEST_SECTION("Array append && Pop") {
        
        ARRAY_APPEND(numbers, 1);

        CHECK_BOOL(
            ARRAY_COUNT(numbers) == 1,
            "Array appending increments count",
            ""
        );

        int popped = ARRAY_POP(numbers);

        CHECK_BOOL(
            popped == 1,
            "Pop returns last element",
            ""
        );
        
        for (size_t i = 0; i < 7; ++i) {
            ARRAY_APPEND(numbers, (int)i);
        }

        CHECK_BOOL(
            ARRAY_CAPACITY(numbers) == 10,
            "Array capacity doubling",
            "%zu != %zu", ARRAY_CAPACITY(numbers), (size_t)10
        );

        bool match = 1;
        for (int i = 0; i < (int) ARRAY_COUNT(numbers); ++i) {
            if (numbers[i] != i) {
                match = 0;
                break;
            }
        }

        CHECK_BOOL(
            match,
            "Appended values match (beyond capacity)",
            ""
        );

    };

    TEST_SECTION("Array shrink") {

        ARRAY_SHRINK_TO_FIT(numbers);

        CHECK_BOOL(
            ARRAY_CAPACITY(numbers) == ARRAY_COUNT(numbers),
            "Shrink reduces capacity to array count",
            ""
        );
    };

    ARRAY_FREE(numbers);

    TEST_SUMMARY();

    exit(EXIT_SUCCESS);
}
