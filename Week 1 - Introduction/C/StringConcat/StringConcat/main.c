//
//  main.c
//  StringConcat
//
//  Created by Aditya Narayan on 2/17/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, const char * states[]) {
    // insert code here...
    
    // 9.
//    char *states[] = {
//        "California", "Oregon",
//        "Washington", "Texas"
//    };
    
    //char * states[];
    
//    states = argv;
    
    unsigned long elements =  argc -1; //sizeof(states);
    
    //printf("Array Length: %ld", sizeof(states)/ sizeof(<#expression-or-type#>) );
    
    int charStarSize = sizeof (char *);
    char *onebigstate = (char *)malloc( elements * charStarSize);
    int count = 0;

    
    
    //for (int i = 0; i < (sizeof(states) / sizeof(states[0])); i++) {
    for (int i = 1; i < argc; i++) {
        for (int j = 0; j < elements; j++) {
            char newstate = states[i][j];
            
            if(newstate=='\0')
                break;
            
            onebigstate[count++]= newstate; // Add the character onto the new string
        }
    }
    
    printf("%s\n", onebigstate);
    
    return 0;
}
