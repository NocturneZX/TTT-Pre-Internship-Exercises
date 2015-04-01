//
//  Company.h
//  NavCtrl
//
//  Created by Julio Reyes on 3/2/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NeueCompany : NSObject

@property(nonatomic, assign) NSInteger       CompanyID;
@property(nonatomic, retain) NSString       *CompanyName;
@property(nonatomic, retain) NSMutableArray *CompanyProducts;
@property(nonatomic, retain) NSString       *CompanyImage;

- (id)initWithCompanyID:(NSInteger)thecompanyid
            CompanyName:(NSString *)thecompanyname
        CompanyProducts:(NSArray *)thecompanyproducts
           CompanyImage:(NSString *) thecompanyimage;


@end
