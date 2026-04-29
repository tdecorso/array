all: test

test: array.h test.h test.c
	gcc -g test.c -o test

clean:
	rm test
