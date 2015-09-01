//
//  main.c
//  Countries
//
//  Created by Aditya Narayan on 2/17/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, const char * argv[]) {
    
    // 9.
    char countries[] = "USA, Canada, Mexico, Bermuda, Grenada, Belize";
    
    unsigned long elements = sizeof(countries);

    char** countriesSet = malloc(sizeof(char*) * elements); // Create 2D array to hold

    int i = 0;
    int j = 0;
    int countryIndex = 0;
    
    for (; i < elements; i++) {
        if ((countries[i] == ',' && countries[i+1] == ' ')
            || i == elements - 1) {

            char *newCountry = malloc((i - j) * sizeof(char));
    
            int lettercount = 0; // Counter of letters
            
            for (; j < i; j++) { // Iterate through each country
                newCountry[lettercount] = countries[j];
                lettercount++;
            }newCountry[lettercount] = '\0'; // break

            printf("%s\n", newCountry);

            countriesSet[countryIndex] = newCountry; // Add the country pointer to the pointer array

            i = i + 1;
            j = j + 2;
            countryIndex++;
        }
    }
   
    printf("%s\n", countriesSet[3]);
    
    return 0;
}
