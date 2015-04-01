//
//  main.c
//  StringManipulation
//
//  Created by Julio Reyes on 2/17/15.
//  Copyright (c) 2015 TerryBuOrganization. All rights reserved.
//

#include <stdio.h>
#include <string.h>

char* compareString(char *, char *); // function prototype

int main(int argc, const char * argv[]) {
    // insert code here...
    
    // 6. Equal String
    char *str1 = "WhiteBase";
    char *str2 = "Gundam";
    char *str3 = "Gundam";
    
    char sr4[40];
    
    printf("%lu\n", sizeof(str3));
    
    if (str1 == str2) {
        printf("True\n");
    }else{
        printf("False\n");
    }
    
    if (str2 == str3) {
        printf("True\n");
    }else{
        printf("False\n");
    }
    
    printf("__\n\n");
    
    // Alternative
    char *newstr1 = "Gundam";
    char *newstr2 = "Aznable";
    char *final;
    
    final = compareString(newstr1, newstr2);
    
    printf("%s", final);
    
    
    return 0;
}

char* compareString(char *strcomp1, char *strcomp2){
    
    char *verdict;
    
    if (strcomp1 == strcomp2) {
        verdict = "True\n";
    }else{
        verdict = "False\n";
    }
    return verdict;
}