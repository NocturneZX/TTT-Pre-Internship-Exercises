//
//  main.c
//  CountriesKai
//
//  Created by Aditya Narayan on 2/18/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, const char * argv[]) {
    // 10.
    char countries[] = "USA. Canada, Mexico, Bermuda  Grenada, Belize   Antigua, Guam, Dominica";
    
    unsigned long elements = sizeof(countries);
    
    char** countriesSet = malloc(sizeof(char*) * elements); // Create 2D array to hold
    
    int i = 0;
    int j = 0;
    int countryIndex = 0;
    
    for (i = i; i < elements; i++) {
        if ((countries[i] == ',' || countries[i] == ' ' || countries[i] == '.')
            || i == elements - 1) {
            
            char *newCountry = malloc((i - j) * sizeof(char));
            
            int lettercount = 0; // Counter of letters
            
            for (j = j; j < i; j++) { // Iterate through each country
                newCountry[lettercount] = countries[j];
                lettercount++;
            }newCountry[lettercount] = '\0'; // break
            
            //printf("%s\n", newCountry);
            
            countriesSet[countryIndex] = newCountry; // Add the country pointer to the pointer array
            
            
            // Check how many indices are needed to skip in order to iterate to the next letter.
            int currentIndexofi = i;
            int currentIndexofj = j;
            
            while (countries[i] == ',' || countries[i] == ' ' || countries[i] == '.')
            {
                i = currentIndexofi++;
                j = currentIndexofj++;
            }
            
            countryIndex++;
            printf("%s\n", countriesSet[countryIndex]);
        }
    }
    for (int x = 0; x < countryIndex; x++)
        printf("%s\n", countriesSet[x]);
    
    return 0;
}
