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
    
    ofp = fopen("/Users/Nocturne/Desktop/Julio Reyes/Week 1 - Introduction/C/ReadAFileObjC/ReadAFileObjC/AppDelegate.m", mode); // Open file
    
    if(ofp == NULL ) // Check if file exists.
    {
        perror("Error while opening the file.\n");
        exit(EXIT_FAILURE);
    }
    else
    {
        int x = 0;
        int y = 0;
        int numOfLines = 1;
        int numOfComments = 0;
        int numOfCommentblocks = 0;

        /* gets the next character (an unsigned char) from the specified stream and advances the position indicator for the stream at a time until EOF is reached */
        while ((x = fgetc(ofp)) != EOF)
        {
            if (x == '\n')
                numOfLines++;
            
            if (x == '/'){
                y = fgetc(ofp);

                if(y == '/') // If the next character from istream has double slashes
                    
                    numOfComments++;
            }
        }
        
        fseek(ofp, 0, 0);
        /* gets the next character (an unsigned char) from the specified stream and advances the position indicator for the stream at a time until EOF is reached */
        while ((x = fgetc(ofp)) != EOF)
        {
            if (x == '/'){
                y = fgetc(ofp);
                if(y == '*') // If the next character from istream has double slashes
                    
                    numOfCommentblocks++;
            }
        }
        
        printf("This ObjC file has about %d lines, %d comments, and %d comment blocks. \n", numOfLines, numOfComments, numOfCommentblocks);
        
    }
    
    fclose(ofp); // Close pointer
    
    return 0;
}
