//
//  main.c
//  SigmaNotation
//
//  Created by Aditya Narayan on 2/19/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

#include <stdio.h>
#include <math.h>

// 20. and 21. 
int main(int argc, const char * argv[]) {
    /* Evaluate S using n = 100 terms where S = √ (6*( 1+1/2^2+1/3^2 +1/4^2 + 1/5^2 + ... ) ) */
    double R = 0;
    int count = 100000;
    
    // R += 1/(n*n)
    
    for (double n = 1; n < count; n++)
        R += (1.0/(n * n));
    
    double S = sqrt(R * 6); // Approximate value
    
    printf("The square root of %.6lf is %.6lf.\n", S*S, S);
    
    /* Inverse: Find of the number N times that S will equal to ~3.14       */
    double invS = M_PI;
    double invR = 0;
    double invn = 1;

    while (1) {

        invR += (1.0/(invn * invn));
        
        double iterS = sqrt(invR * 6); // Placeholder that will hold the iteration of S in each loop
        
        if (fabs(iterS - invS) < 0.00001){ //Epsilon: 0.00001 is the absolute error; adding increase accuracy
            printf("The value of iterations that makes S = PI is %.1lf\n", invn);
            break; // If the current iteration of S is equal to PI, break the loop.
        }else{
            invn++;
        }
    }
    return 0;
}
