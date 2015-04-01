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
@end
