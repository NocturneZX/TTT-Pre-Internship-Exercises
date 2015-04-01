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

-(NSArray *)getAllJRKeys:(NSString *)key{
    
    NSMutableArray *arrayKeys;
    
    for (int i = 0; i < [self.keys count]; i++) {
        [arrayKeys addObject:self.keys];
    }
    
    return arrayKeys;
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

#pragma mark - Find index using binary search

#pragma mark - Bubble Sort algorithm - never mind it was a waste; not part of the task.
// It was supposed to be for 23, not 22. Thanks, Aditya.

/*-(JRDictionary *)bubbleSortValues:(JRDictionary *)dict{
    
    JRDictionary *swappedDict = dict;
    long count = [dict.keys count];
    BOOL isSwapped = YES; // Flag to check if values and keys were swapped
    
    while (isSwapped) {
        isSwapped = NO;
        for (int i = 1; i < (count - 1); i++) { // count - 1 is out of bounds check
            if ([swappedDict.keys objectAtIndex:i] < [swappedDict.keys objectAtIndex:(i - 1)]) {
                // Swap the keys and values;
                isSwapped = YES;
                [self SwapNextIndex:(i - 1) previousIndex:i inArray:swappedDict.keys];
            }
        }
    }
    
    return swappedDict;
}

-(void)SwapNextIndex:(NSUInteger)a previousIndex:(NSUInteger)b inArray:(NSMutableArray *)arr{
    
    NSNumber* valueAtNextIndex = arr[a];
    NSNumber* valueAtPrevIndex = arr[b];
    
    [arr replaceObjectAtIndex:b withObject:valueAtNextIndex];
    [arr replaceObjectAtIndex:a withObject:valueAtPrevIndex];
    
} */

@end
