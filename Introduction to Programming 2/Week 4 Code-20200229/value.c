/*file value.c*/#include <stdio.h>int main() {		int x = 5;	int *ptr;	ptr = &x;	printf("address of x: %p\n", ptr);	printf("value of x: %d\n", *ptr);}