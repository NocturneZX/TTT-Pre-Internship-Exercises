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
#import "sqlite3.h"

@interface qcdDAO : NSObject
{
    sqlite3 *navCtrlDB;
    NSString *dbPathString;
}

@property(nonatomic, retain) NSMutableArray *companies;
@property(nonatomic, retain) NSMutableArray *products;


+(instancetype)sharedInstance;

-(void)createOrOpenDBForCompanies;
-(void)initWithCompaniesAndProductsUsingSQLite;
-(void)addProductsToCompaniesUsingSQLite;
-(NSMutableArray *)GetCompaniesUsingSQLite;
-(void)deleteData:(NSString *)deleteQuery;

@end
