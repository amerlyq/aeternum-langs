// USE: C-function "bsearch"
#include <stdio.h>
#include <stdlib.h>

int cmpfunc(const void * a, const void * b) { return ( *(int*)a - *(int*)b ); }

int main() {
    int values[] = { 5, 20, 29, 32, 63 };
    int key = 32;
    int *item = (int*) bsearch (&key, values, 5, sizeof(int), cmpfunc);
    if( item != NULL ) { printf("%d\n", *item); } else { printf("not found\n"); }
}
