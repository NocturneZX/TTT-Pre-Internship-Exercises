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
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM COMPANY INNER JOIN PRODUCT ON COMPANY.ID = PRODUCT.COMPANYID"];
        const char *query_sql = [querySQL UTF8String];
        int sqlfunc = sqlite3_prepare(navCtrlDB, query_sql, -1, &statement, NULL);
        NSLog(@"Documents Directory: %@", [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);

        if (sqlfunc == SQLITE_OK)
        {

            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSLog(@"%@",[self sqlite3StmtToString:statement]);

                
                NSString *compID = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                NSString *compName = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                NSString *compImage = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                
                NSString *productID = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                NSString *productName = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                NSString *productNameRef = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 5)];
                NSString *companyID = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement,  6)];
                
                Company *company = nil;
                if ([[self.companies lastObject]CompanyID] != [compID integerValue] || self.companies.count == 0) {
                    company = [[Company alloc]init];
                    [company setCompanyID:[compID integerValue]];
                    [company setCompanyName:compName];
                    [company setCompanyProducts:[NSMutableArray array]];
                    [company setCompanyImage:compImage];

                }else{
                    company = [self.companies lastObject];
                }
                
                Product *product = [[Product alloc]init];
                [product setProductID:[productID integerValue]];
                [product setProductName:productName];
                [product setProductReference:productNameRef];
                [product setCompanyID:[companyID integerValue]];
                [self.products addObject:product];
                
                if (company.CompanyID == product.CompanyID) {
                    [company.CompanyProducts addObject:product];
                }
                
                
                if ([[self.companies lastObject]CompanyID] != [compID integerValue]) {
                    [self.companies addObject:company];
                }
                
                
                [compID release];
                [compName release];
                [compImage release];
                
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
    }else{
        NSLog(@"%s", error);
    }
}

-(NSMutableString*) sqlite3StmtToString:(sqlite3_stmt*) statement
{
    NSMutableString *s = [NSMutableString new];
    [s appendString:@"{\"statement\":["];
    for (int c = 0; c < sqlite3_column_count(statement); c++){
        [s appendFormat:@"{\"column\":\"%@\",\"value\":\"%@\"}",[NSString stringWithUTF8String:(char*)sqlite3_column_name(statement, c)],[NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, c)]];
        if (c < sqlite3_column_count(statement) - 1)
            [s appendString:@","];
    }
    [s appendString:@"]}"];
    return s;
}

@end