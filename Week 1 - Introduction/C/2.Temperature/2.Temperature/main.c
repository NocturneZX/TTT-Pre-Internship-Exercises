//
//  main.c
//  2.Temperature
//
//  Created by Julio Reyes on 2/17/15.
//  Copyright (c) 2015 TerryBuOrganization. All rights reserved.
//

#include <stdio.h>


#define LOWER 0 // lower limit of temp scale
#define UPPER 300 // upper limit
#define STEP 20 // step size

#define REVERSELOWER -40 // lower limit of temp scale
#define REVERSEUPPER 400 // upper limit
#define REVERSESTEP 20 // step size

/* Prints a table of Fahrenheit and Celsius conversions */
int main(int argc, const char * argv[]) {
    // insert code here...
    
    //  2.Temperature
    float fahren, cel;
    float floatlower, floatupper, floatstep;
    
    floatlower = 0; /* lower limit of temp scale */
    floatupper = 300; /* upper limit */
    floatstep = 20; /* step size */
    
    fahren = floatlower;
    while (fahren <= floatupper) {
        cel = (5.0/9.0) * (fahren-32.0);
        printf("%3.0f %6.1f\n", fahren, cel);
        fahren = fahren + floatstep;
    }

    printf("\n\n\n");
    // 3.Temperature header format
    int fahr;
    
    printf("|\t  F|\t\tC|\n"); // Print Header
    for (fahr = LOWER; fahr <= UPPER; fahr = fahr + STEP)
        printf("|\t%3d|%6.1f |\n", fahr, (5.0/9.0) * (fahr - 32));
    
    printf("\n\n\n");
    // 4 and 5.Temperature reverse modification
    fahr = 0;
    
    printf("|  F\t\t\tC|\n"); // Print Header
    for (fahr = REVERSEUPPER; fahr >= REVERSELOWER; fahr = fahr - REVERSESTEP)
        printf("|\t%3d |%6.1f |\n", fahr, (5.0 * fahr  - 32) / 9.0);

    
    
    return 0;
}
