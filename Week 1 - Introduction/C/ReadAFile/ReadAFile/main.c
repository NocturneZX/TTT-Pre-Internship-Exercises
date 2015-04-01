//
//  main.c
//  ReadAFile
//
//  Created by Aditya Narayan on 2/18/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(int argc, const char * argv[]) {
    
    // insert code here...
    FILE *ofp; // Output file pointer
    char *mode = "r"; // Read or Write mode
    char outFileName[256];
    
//    printf("Enter the name of file you wish to see: \n");
//    gets(outFileName);
    
    ofp = fopen("/Users/adityanarayan/Desktop/Julio Reyes/Week 1 - Introduction/ReadAFile/ReadAFile/gundam.txt", mode); // Open file
    
    if(ofp == NULL ) // Check if file exists.
    {
        perror("Error while opening the file.\n");
        exit(EXIT_FAILURE);
    }
    else
    {
        //printf("The contents of %s file are :\n", outFileName);
        char *fileString = (char *)malloc(sizeof(outFileName));
        
        int x = 0;
        /* read one character at a time until EOF is reached */
        for (int i = 0; i < sizeof(outFileName); i++) {
            fileString[i] = x = fgetc(ofp); // workaround
            printf("%c", x);
        }
        
        printf("%s \n", fileString);

    }

    fclose(ofp); // Close pointer
    
    return 0;
}
