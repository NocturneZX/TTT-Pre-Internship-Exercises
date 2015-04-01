//
//  main.m
//  AddressBookKai
//
//  Created by Aditya Narayan on 2/23/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Name.h"
#import "JRDictionary.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSMutableArray *allNames = [NSMutableArray arrayWithObjects:@"Julio Reyes",@"Jack Dorsey",@"Hingle McCringleberry",@"Hingle McCringleberry", nil];
        NSMutableArray *allAddresses = [NSMutableArray arrayWithObjects:@"123 Hell Verse Ave. New York NY 10012",@"1355 Market Street Suite 900 San Francisco CA 94103",@"1231 Haptism St. Montgomery AL 13234",@"5463 King St. Montgomery AL 13234", nil];
        
        BOOL isValid = YES;
        
        JRDictionary *addressBookEntry = [[JRDictionary alloc]init];
        
        if (allNames.count != allAddresses.count) {
            NSLog(@"Whoa. The number of names and addresses are not equal. Run this again with completed entries.");
        }else{
            for (NSString *person in allNames) {
                
                Name *newPerson = [[Name alloc]init];
                [newPerson setFullName:person];
                [newPerson setAddress:[allAddresses objectAtIndex:[allNames indexOfObject:person]]];
                
                [newPerson sayHello];
                
                NSArray *keys = addressBookEntry.keys;
                if (keys.count != 0) {
                    for (NSString *key in keys) {
                        if ([key isEqualToString:newPerson.fullName]) {
                            NSLog(@"Duplicate data for %@. Data was not added.", key);
                            isValid = NO;
                        }
                    }
                }

                if (isValid) {
                    [addressBookEntry setJRDictValue:newPerson.address forKey:newPerson.fullName];
                }
                
            }
            
            NSLog(@"The names of all the entries are: %@\n\n The Addresses are: %@\n\n", addressBookEntry.keys, addressBookEntry.values);
        }
    }
    return 0;
}
