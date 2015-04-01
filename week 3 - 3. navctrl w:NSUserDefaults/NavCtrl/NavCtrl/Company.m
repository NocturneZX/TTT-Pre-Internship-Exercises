//
//  Company.m
//  NavCtrl
//
//  Created by Julio Reyes on 3/2/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import "Company.h"

@implementation Company
- (id)initWithCompanyID:(NSInteger)thecompanyid
            CompanyName:(NSString *)thecompanyname
            CompanyProducts:(NSMutableArray *)thecompanyproducts
            CompanyImage:(NSString *) thecompanyimage
{
    self = [super init];
    if (self) {
        self.CompanyID = thecompanyid;
        self.CompanyName = thecompanyname;
        self.CompanyProducts = thecompanyproducts;
        self.CompanyImage = thecompanyimage;
    }
    return self;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.CompanyID = [decoder decodeIntegerForKey:@"CompanyID"];
    self.CompanyName = [decoder decodeObjectForKey:@"CompanyName"];
    self.CompanyProducts = [decoder decodeObjectForKey:@"CompanyProducts"];
    self.CompanyImage = [decoder decodeObjectForKey:@"CompanyImage"];
    

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt:self.CompanyID forKey:@"CompanyID"];
    [encoder encodeObject:self.CompanyName forKey:@"CompanyName"];
    [encoder encodeObject:self.CompanyProducts forKey:@"CompanyProducts"];
    [encoder encodeObject:self.CompanyImage forKey:@"CompanyImage"];
}

@end
