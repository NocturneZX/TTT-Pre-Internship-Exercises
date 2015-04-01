//
//  main.c
//  BubbleSortin
//
//  Created by Aditya Narayan on 2/20/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>

// Function prototype
void SwapInts(int *arr,int a, int b);
void bsort (int *arr, int min, int max);

// Bools
#define TRUE 1
#define FALSE 0

int main(int argc, const char * argv[]) {
    // insert code here...
    
    int *arr = NULL;
    
    int num;
    
    printf("How much numbers you want, guy?: ");
    scanf("%d", &num);
    
    arr = (int*)malloc(num * sizeof(int));
    
    printf("Put in the numbers: ");
    for (int i = 0; i < num; i++) {
        scanf("%d", &arr[i]);
    }
    
    bsort(arr, 0, num - 1); // Sort the array
    
    for (int i = 0; i < num; i++) {
        printf("The sorted list be %d. %d\n",i+1,arr[i]);
    }
    return 0;
}

void SwapInts(int *arr, int a, int b){
    
    printf("The original numbers were: a:%d b:%d\n", arr[a], arr[b]);
    
    // Swap the two integers in array index
    int temp;
    
    temp = arr[a];
    arr[a] = arr[b];
    arr[b] = temp;
    
    printf("The swapped numbers are now: a:%d b:%d\n\n", arr[a], arr[b]);
}

void bsort (int *arr, int min, int max){
    
    int swapflag = TRUE; // flag is set while flag is 1. This is used to break the loop when no more nums can be swapped.
    while (swapflag) {
        swapflag = FALSE; // Assume that all indices is sorted.
        for (int i = min+1; i <= max; i++) // Set up to compare first number with the previous number
        {
            if (arr[i] < arr[i-1]) { // If the number in arr[i] less than the adjacent number, swap 'em
                SwapInts(arr, i, i-1);
                swapflag = TRUE;
            }
        }
    }
}