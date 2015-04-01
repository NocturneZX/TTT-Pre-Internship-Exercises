//
//  main.c
//  IntegerSwap
//
//  Created by Aditya Narayan on 2/19/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

#include <stdio.h>
#include <libc.h>
void SwapInts(int64_t a, int64_t b);
void SwapIntsXOR(int64_t a, int64_t b);
void PointerSwap(int *ap, int *bp);

// 18. and 19.
int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello, World!\n");
    int64_t first = 2000000000;
    int64_t second = 2100000000;

    SwapInts(first, second);
    SwapIntsXOR(first, second);
    
    int newx = 3;
    int newy = 7;
    
    PointerSwap(&newx, &newy);
    
    printf("After swapping pointers(&x, &y): x = %d y = %d\n\n", newx, newy);
    
    return 0;
}

void SwapInts(int64_t a, int64_t b)
{
    
    printf("The original numbers were: a:%lld b:%lld\n", a, b);

    // Swap the two integers
    a = a + b;
    b = a - b;
    a = a - b;
    
    printf("The swapped numbers are now: a:%lld b:%lld\n\n", a, b);
}

void SwapIntsXOR(int64_t a, int64_t b){
    
    printf("The original numbers were: a:%lld b:%lld\n", a, b);
    
    // Swap the two integers using Bitwise XOR
    a = a ^ b;
    b = a ^ b;
    a = a ^ b;
    
    printf("The XOR-swapped numbers are now: a:%lld b:%lld\n\n", a, b);
}

void PointerSwap(int *ap, int *bp)
{
    if (ap == bp) // Check if the two addresses are same
        return;
    
    int temp;
    
    temp = *ap;
    *ap = *bp;
    *bp = temp;
    
}
