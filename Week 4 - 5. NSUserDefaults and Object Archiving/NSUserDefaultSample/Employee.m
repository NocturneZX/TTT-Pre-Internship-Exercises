//
//  Employee.m
//  NSUserDefaultSample
//
//  Created by Julio Reyes on 19/12/13.
//  Copyright (c) 2013 Julio Reyes. All rights reserved.
//

#import "Employee.h"

@implementation Employee

- (id)initWithName:(NSString *)name address:(NSString *)address phone:(NSString *)phone
{
    self = [super init];
    if(self)
    {
        [self setName:name];
        [self setAddress:address];
        [self setPhone:phone];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode properties, other class variables, etc
    NSLog(@"Encoder Called");
    [encoder encodeObject:[self name] forKey:@"name"];
    [encoder encodeObject:[self address] forKey:@"address"];
    [encoder encodeObject:[self phone] forKey:@"phone"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    NSLog(@"Decoder Called");
    self = [super init];
    if(self)
    {
        //decode properties, other class vars
        [self setName:[decoder decodeObjectForKey:@"name"]];
        [self setAddress:[decoder decodeObjectForKey:@"address"]];
        [self setPhone:[decoder decodeObjectForKey:@"phone"]];
    }
    return self;
}

@end
