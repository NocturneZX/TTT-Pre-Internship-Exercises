//
//  qcdDAO.h
//  NavCtrl
//
//  Created by Julio Reyes on 3/2/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Company.h"
#import "Product.h"

@interface qcdDAO : NSObject
@property(nonatomic, retain) NSMutableArray *companies;
@property(nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) NSUserDefaults *currentDefaults;


+(instancetype)sharedInstance;

-(void)initCurrentDefaults;
-(void)initWithCompaniesAndProducts;
-(void)addProductsToCompanies;

-(void)saveCompanies:(NSMutableArray *)currentArray;
-(NSMutableArray *)GetCompanies;

@end
