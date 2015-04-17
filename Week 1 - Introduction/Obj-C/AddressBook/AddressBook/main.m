//
//  main.m
//  AddressBook
//
//  Created by Aditya Narayan on 2/20/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Name.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // insert code here...
        NSString *dataStr = [NSString stringWithContentsOfFile:@"/Users/Nocturne/Desktop/TTT-Pre-Internship-Exercises/Week 1 - Introduction/Obj-C/AddressBook/AddressBook/address.csv" encoding:NSUTF8StringEncoding error:nil];
        //specifies the csv file to read - stored in project root directory - and encodes specifies that the format of the file is NSUTF8. Choses not to return an error message if the reading fails
        
        NSArray *array = [dataStr componentsSeparatedByString: @"\n"];
        //splits the string into an array by identifying data separators.
        
        //NSLog(@"array: %@", array);
        //prints the array to screen
        

        NSMutableDictionary *addressBookEntry = [NSMutableDictionary dictionary];
        

        BOOL isValid = YES;
        for (NSString *person in array) {
            NSArray* info = [person componentsSeparatedByString:@","];
            NSLog(@"%@", info);

            if (info.count >= 2) {
                Name *newPerson = [[Name alloc]init];
                [newPerson setFullName:info[0]];
                [newPerson setAddress:info[1]];
                
                // Say Hello
                [newPerson sayHello];
                
                NSArray *keys = [addressBookEntry allKeys];
                for (NSString *key in keys) {
                    if ([key isEqualToString:newPerson.fullName]) {
                        NSLog(@"Duplicate data for %@", key);
                        isValid = NO;
                    }
                }
                if (isValid)
                    [addressBookEntry setObject:newPerson forKey:newPerson.fullName];
                
            }else{
                NSLog(@"Corrupted data");
            }
        }

        Name *currentPerson = [addressBookEntry objectForKey:@"Julio Reyes"];
        NSLog(@"%@", currentPerson.address);
    }
    

    return 0;
        
}
