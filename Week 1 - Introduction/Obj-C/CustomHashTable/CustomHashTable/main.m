//
//  main.m
//  CustomHashTable
//
//  Created by Aditya Narayan on 2/23/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JRDictionary.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        JRDictionary *car = [[JRDictionary alloc]init];
        [car setJRDictValue:@"Mercedes CLK-GTR" forKey:@"Mercedes-Benz Car"];
        NSLog(@"%@", [car findvalueForKey:@"Mercedes-Benz Car"]);
        [car whoAreYou];
        
    }
    return 0;
}
