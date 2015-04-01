//
//  qcdDAO.m
//  NavCtrl
//
//  Created by Julio Reyes on 3/2/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import "qcdDAO.h"

#import "Company.h"
#import "Product.h"

@implementation qcdDAO

+(instancetype)sharedInstance
{
    static dispatch_once_t cp_singleton_once_token;
    static qcdDAO *sharedInstance;
    dispatch_once(&cp_singleton_once_token, ^{
        sharedInstance = [[self alloc] init];
 
    });
    return sharedInstance;
}


#pragma MARK - SQLITE
-(void)createOrOpenDBForCompanies{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [path objectAtIndex:0];
    dbPathString = [docPath stringByAppendingPathComponent:@"navCtrl.db"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:dbPathString])
    {
        const char *dbPath = [dbPathString UTF8String];
        
        //cretae databases
        if (sqlite3_open(dbPath, &navCtrlDB) == SQLITE_OK)
        {

        }
        else
        {
            NSLog(@"Error reading categories. message: '%s'",sqlite3_errmsg(navCtrlDB));
        }
    }
    
}

-(void)initWithCompaniesAndProductsUsingSQLite{
    self.companies = [[NSMutableArray alloc]init];
    self.products = [[NSMutableArray alloc]init];
    
    sqlite3_stmt *statement ;
    if (sqlite3_open([dbPathString UTF8String], &navCtrlDB) == SQLITE_OK)
    {
        [self.companies removeAllObjects];
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM COMPANY"];
        const char *query_sql = [querySQL UTF8String];
        int sqlfunc = sqlite3_prepare(navCtrlDB, query_sql, -1, &statement, NULL);
        
        if (sqlfunc == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *compID = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                NSString *compName = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *compImage = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                
                Company *company = [[Company alloc]init];
                [company setCompanyID:[compID integerValue]];
                [company setCompanyName:compName];
                [company setCompanyProducts:[NSMutableArray new]];
                [company setCompanyImage:compImage];
                [self.companies addObject:company];
                
                [compID release];
                [compName release];
                [compImage release];
            }
        }
        else {
            NSLog(@"Error reading categories. Code: %d, message: '%s'", sqlfunc,sqlite3_errmsg(navCtrlDB));
        }
        
    }
    
    sqlite3_stmt *newstatement;
    if (sqlite3_open([dbPathString UTF8String], &navCtrlDB)==SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM PRODUCT"];
        const char *query_sql = [querySQL UTF8String];
        int sqlfunc = sqlite3_prepare(navCtrlDB, query_sql, -1, &newstatement, NULL);
        
        if (sqlfunc == SQLITE_OK)
        {
            while (sqlite3_step(newstatement) == SQLITE_ROW)
            {
                NSString *productID = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(newstatement, 0)];
                NSString *productName = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(newstatement, 1)];
                NSString *productNameRef = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(newstatement, 2)];
                NSString *companyID = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(newstatement,  3)];
                
                Product *product = [[Product alloc]init];
                [product setProductID:[productID integerValue]];
                [product setProductName:productName];
                [product setProductReference:productNameRef];
                [product setCompanyID:[companyID integerValue]];
                [self.products addObject:product];

                
                [productID release];
                [productName release];
                [productNameRef release];
                [companyID release];
                [product release];
            }
        }
        else {
            NSLog(@"Error reading categories. Code: %d, message: '%s'", sqlfunc,sqlite3_errmsg(navCtrlDB));
        }
    }
}
-(void)addProductsToCompaniesUsingSQLite{
    for (Product* product in self.products) {
        for (Company* company in self.companies) {
            if (company.CompanyID == product.CompanyID) {
                [company.CompanyProducts addObject:product];
            }
        }
    }
}

-(NSMutableArray *)GetCompaniesUsingSQLite{
    return self.companies;
}
-(void)deleteData:(NSString *)deleteQuery
{
    char *error;
    if (sqlite3_exec(navCtrlDB, [deleteQuery UTF8String], NULL, NULL, &error) == SQLITE_OK)
    {
        NSLog(@"Data Deleted");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Delete" message:@"Data Deleted" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
    }
}

@end