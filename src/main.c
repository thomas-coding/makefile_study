#include <stdio.h>
#include "prog1.h"
#include "prog2.h"

int main(void) {
    int num = 0;

    printf("enter main function\n");
    num = number_double(66);
    printf("number:%d\n", num);
    num = number_triple(66);
    printf("number:%d\n", num);

}
