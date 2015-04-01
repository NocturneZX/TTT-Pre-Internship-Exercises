//
//  main.c
//  nthpower
//
//  Created by Aditya Narayan on 2/18/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

#include <stdio.h>
#include <stdint.h>
#include <libc.h>

int64_t getnthpower(int64_t x, int64_t n);
int64_t Powerof10(unsigned int x);

int main(int argc, const char * argv[]) {
    // insert code here...
    int64_t number = 2000000000;
    int64_t thenth = 10;
    
    int64_t result = getnthpower(number, thenth);
    
    printf("%lld\n\n", result);
    
    int numOfZeroes = 1;
    int64_t bignum = 2000000000;
    
    while (bignum > 0) {
        if(bignum % 10 == 0)
            numOfZeroes++;
        bignum = bignum / 10;
    }numOfZeroes--;
    
    printf("%d\n", numOfZeroes);

    
    int64_t tenthresult = 2 * Powerof10(numOfZeroes + 10);

    
    printf("%lld", tenthresult);

    return 0;
}

int64_t getnthpower(int64_t x, int64_t n){
    
    // resulting nth
    int64_t nthpwr = 1;
    for (int64_t i = 0; i < n; i++)
        nthpwr *= x;
    return nthpwr;
}

int64_t Powerof10(unsigned int n){
    
    // resulting nth
    int64_t result = 1;
    int tenthpwr = 10;
    if (n == 0) {
        return 1;
    }else if (n == 1) {
        return tenthpwr;
    }else{
        for (int i = 0; i < n; i++)
            result *= tenthpwr;
        return result;
    }
}