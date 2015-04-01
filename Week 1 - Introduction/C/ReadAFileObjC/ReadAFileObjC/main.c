//
//  main.c
//  ReadAFileObjC
//
//  Created by Aditya Narayan on 2/18/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>


// 13. - 16. 
int main(int argc, const char * argv[]) {
    FILE *ofp; // Output file pointer
    char *mode = "r"; // Read or Write mode
    char outFileName[512];
    
    //    printf("Enter the name of file you wish to see: \n");
    //    gets(outFileName);
    
    ofp = fopen("/Users/adityanarayan/Desktop/Julio Reyes/Week 1 - Introduction/ReadAFileObjC/ReadAFileObjC/AppDelegate.m", mode); // Open file
    
    if(ofp == NULL ) // Check if file exists.
    {
        perror("Error while opening the file.\n");
        exit(EXIT_FAILURE);
    }
    else
    {
        int x; // char pointers to first character
        int y; // char pointers to second character
        int numOfLines = 0;
        int numOfComments = 0;
        int numOfCommentblocks = 0;

        /* gets the next character (an unsigned char) from the specified stream and advances the position indicator for the stream at a time until EOF is reached */
        while ((x = fgetc(ofp)) != EOF)
        {
            y = fgetc(ofp); // Get the character after whatever x is;
            
            if (x == '\n')
                numOfLines++;
            if (x == '/' & y == '/') // If the next character from istream has double slashes
                numOfComments++;
            if (x == '/' && y == '*')// If the next character from istream has slash and star
                 numOfCommentblocks++;
        }
        
        printf("This ObjC file has about %d lines, %d comments, and %d comment blocks.", numOfLines, numOfComments, numOfCommentblocks);
        
    }
    
    fclose(ofp); // Close pointer
    
    return 0;
}
