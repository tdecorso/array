# Dynamic Array (Macro-Based C Implementation)

This implementation uses the trick of placing the array metadata (count and capacity) to the back of the array. I like this 
version because it lets me use the array in the most organic way in my code. Keep in mind that is not the safest option.

## Usage
Just include the **array.h** header in your project.

### Array Allocation and Deallocation
```
int* numbers;
ARRAY(numbers, 10); // specify at initialization the initial capacity
numbers[0] = 1;
ARRAY_FREE(numbers); // free the array memory eventually
```

### Array appending
```
int* numbers;
ARRAY(numbers, 10);

for (int i = 0; i < 100; ++i) {
    ARRAY_APPEND(numbers, i); // the array grows if needed
}

ARRAY_SHRINK_TO_FIT(numbers); // you can also free unused space 
```

## Testing

Run tests:

```
gcc test.c -o test && ./test
```

## Benchmark

Benchmark utilities are included (bench.h and bench.c)

Run benchmark:
```
gcc bench.c -o bench && ./bench
```

### Results

Measured over 1e6 iterations with 100 warmup cycles:

| Operation               |   p50   |   p90     |   p99    |
| ----------------------- | ------- | --------  | -------- | 
| Alloc + Free            | 9.62 ns |  10.2 ns  | 10.2  ns |
| Append (no resize, 100) | 1.71 µs |   2.17 µs |  4.30 µs |
| Append (resize, 1000)   | 2.06 µs |   3.64 µs |  4.89 µs |






