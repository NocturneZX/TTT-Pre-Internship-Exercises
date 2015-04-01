//
//  Product.h
//  NavCtrl
//
//  Created by Julio Reyes on 3/2/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property(nonatomic, assign) NSInteger  ProductID;
@property(nonatomic, retain) NSString   *ProductName;
@property(nonatomic, retain) NSString   *ProductReference;
@property(nonatomic, assign) NSInteger  CompanyID;

- (id)initWithID:(NSInteger)productid
     ProductName:(NSString *)productname
ProductReference:(NSString *)productref
       CompanyID:(NSInteger)companyid;

@end
