all: test bench

test: array.h test.h test.c
	gcc -g test.c -o test

bench: array.h bench.h bench.c
	gcc bench.c -o bench -O2

clean:
	rm test bench
