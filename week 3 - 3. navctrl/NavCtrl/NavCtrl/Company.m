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
@end
