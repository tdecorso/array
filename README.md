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

| Operation                 |    p50   |   p90     |    p99    |
| -----------------------   | -------- | --------  | --------- | 
| Alloc + Free              | 08.19 ns | 08.85 ns  | 009.92 ns |
| Append (no resize, 10000) | 16.34 µs | 17.94 µs  | 034.57 µs |
| Append (resize, 10000)    | 20.46 µs | 23.07 µs  | 186.43 µs |






