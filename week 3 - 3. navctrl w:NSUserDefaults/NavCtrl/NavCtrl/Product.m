//
//  Product.m
//  NavCtrl
//
//  Created by Julio Reyes on 3/2/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import "Product.h"

@implementation Product

- (id)initWithID:(NSInteger)productid
        ProductName:(NSString *)productname
        ProductReference:(NSString *)productref
        CompanyID:(NSInteger)companyid
{
    self = [super init];
    if (self) {
        self.ProductID = productid;
        self.ProductName = productname;
        self.ProductReference = productref;
        self.CompanyID = companyid;
    }
    return self;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
     self.ProductID  = [decoder decodeIntegerForKey:@"ProductID"];
    self.ProductName = [decoder decodeObjectForKey:@"ProductName"];
    self.ProductReference  = [decoder decodeObjectForKey:@"ProductRef"];
    self.CompanyID = [decoder decodeIntegerForKey:@"CompanyID"];
    
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInt: self.ProductID forKey:@"ProductID"];
    [encoder encodeObject:self.ProductName  forKey:@"ProductName"];
    [encoder encodeObject:self.ProductReference  forKey:@"ProductRef"];
    [encoder encodeInt:self.CompanyID  forKey:@"CompanyID"];
}

@end
