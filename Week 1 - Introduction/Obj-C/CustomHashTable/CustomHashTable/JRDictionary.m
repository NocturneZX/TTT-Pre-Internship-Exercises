//
//  JRDictionary.m
//  CustomHashTable
//
//  Created by Julio Reyes on 2/23/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

#import "JRDictionary.h"

@implementation JRDictionary

- (id) init {
    
    if (self = [super init]) {
        
        self.keys = [[NSMutableArray alloc] initWithObjects: nil];
        
        self.values = [[NSMutableArray alloc] initWithObjects: nil];
        
    }
    
    return self;
    
}



-(id)findvalueForKey:(NSString *)key{
    
    id value;
    if (key == NULL) {
        @throw [NSException exceptionWithName:@"Exception" reason:@"You have to put a key to use." userInfo:nil];
    }
    
    NSUInteger idx = [self.keys indexOfObjectIdenticalTo:key];

    @try {
        value = [self.values objectAtIndex:idx];
    }
    @catch (NSException *exception) {
        NSLog(@"%@", [exception description]);
        return [NSString stringWithFormat:@"It seems we ran into a problem; maybe that value for your key doesn't exist."];
    }
    
    
    return value;
}



-(void)setJRDictValue:(id)value forKey:(NSString *)key

{
    
    // Do some error checking
    if (value == NULL || key == NULL) {
        
        @throw [NSException exceptionWithName:@"Exception" reason:@"You have to put a value AND a key to use" userInfo:nil];
        
    }
    
    
    // Add args to the arrays
    @try {
        
        [self.values addObject:value];
        
        [self.keys addObject:key];
        
    }
    
    @catch (NSException *exception) {
        
        NSLog(@"Exception caught! %@", [exception description]);
        
    }
    
    
    
}

-(void)whoAreYou{
    NSLog(@"Who the hell are you? You are a %@ and your name is %@", self.keys, self.values);
}

@end
