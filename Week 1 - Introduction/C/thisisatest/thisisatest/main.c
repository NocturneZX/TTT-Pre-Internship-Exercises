//
//  main.c
//  thisisatest
//
//  Created by Julio Reyes on 2/17/15.
//  Copyright (c) 2015 TerryBuOrganization. All rights reserved.
//

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define TRUE 1
#define FALSE 0
int main(int argc, const char * argv[]) {
    
    char* testStr = "This is a test";
    char *newString = (char *)malloc(15);
    
    // Check if newString exist
    if (newString == NULL) {
        printf(" Out of memory!\n");
        exit(1);
    }
    
    size_t testStrlen = strlen(testStr);
    int strUpdated = FALSE; // Really is bool
    
    for (int i = 0; i <= testStrlen; i++) {
        if (testStr[i] == 't' && testStr[i+1] == 'e') {
            
            // Critical point
            char *newstrPoint = "gho"; // New string to add.
            int newIndex = i; // Use index as a placeholder to the current to add the new char in each index
            
            for (int j = 0; j <= strlen(newstrPoint) - 1; j++) {
                newString[newIndex] = newstrPoint[j];
                newIndex++;
            }
            
            i = newIndex - 1; // Record the new index and resume the loop to the new index
            strUpdated = TRUE;
            
        }else{
            if (strUpdated == TRUE) { // When the index is updated, it will add the remaining two letters from the original string to the new one.
                int buffer = i - 1; // Since new string is larger, use a buffer to grab the char from original string.
                newString[i] = testStr[buffer];
            }else{
                newString[i] = testStr[i];
            }
        }
    }
    
    printf("%s.\n", newString);
    
    return 0;
}
