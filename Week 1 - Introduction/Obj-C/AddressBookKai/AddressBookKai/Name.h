//
//  Name.h
//  AddressBook
//
//  Created by Aditya Narayan on 2/20/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Name : NSObject

@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *address;


- (void)sayHello;

@end
