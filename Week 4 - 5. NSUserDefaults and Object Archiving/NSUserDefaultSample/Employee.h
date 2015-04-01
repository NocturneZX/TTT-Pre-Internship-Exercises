//
//  Employee.h
//  NSUserDefaultSample
//
//  Created by Julio Reyes on 19/12/13.
//  Copyright (c) 2013 Julio Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Employee : NSObject
<NSCoding>

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *address;
@property(nonatomic, strong) NSString *phone;

- (id)initWithName:(NSString *)name address:(NSString *)address phone:(NSString *)phone;

@end
