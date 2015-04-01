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

-(void)initCurrentDefaults{
    self.currentDefaults = [NSUserDefaults standardUserDefaults];
}
-(void)initWithCompaniesAndProducts{
    
    NSInteger tag = 0;
    
    Company *Apple = [[Company alloc]initWithCompanyID:tag++ CompanyName:@"Apple"
                                    CompanyProducts:[NSMutableArray new]
                                    CompanyImage:@"apple.png"];
    Company *Google = [[Company alloc]initWithCompanyID:tag++ CompanyName:@"Google"
                                    CompanyProducts:[NSMutableArray new]
                                    CompanyImage:@"google.png"];
    Company *Samsung = [[Company alloc]initWithCompanyID:tag++ CompanyName:@"Samsung"
                                    CompanyProducts:[NSMutableArray new]
                                    CompanyImage:@"samsung.jpg"];
    Company *Microsoft = [[Company alloc]initWithCompanyID:tag++ CompanyName:@"Microsoft"
                                    CompanyProducts:[NSMutableArray new]
                                    CompanyImage:@"microsoft.png"];
    
// Products
    // Apple
    Product *IPad = [[Product alloc]initWithID:1 ProductName:@"iPad Air"
                            ProductReference:@"https://www.apple.com/ipad-air/specs/"
                            CompanyID:Apple.CompanyID];
    Product *IPhone = [[Product alloc]initWithID:2 ProductName:@"iPhone"
                                ProductReference:@"https://www.apple.com/iphone-6/specs/"
                                CompanyID:Apple.CompanyID];
    Product *IPodTouch = [[Product alloc]initWithID:3 ProductName:@"iPod Touch"
                                ProductReference:@"https://www.apple.com/ipod-touch/specs/"
                                CompanyID:Apple.CompanyID];
    
    // Google
    Product *Nexus5 = [[Product alloc]initWithID:4 ProductName:@"Nexus 5"
                                ProductReference:@"http://www.google.com/nexus/5"
                                CompanyID:Google.CompanyID];
    Product *Nexus6 = [[Product alloc]initWithID:5 ProductName:@"Nexus 6"
                                ProductReference:@"http://www.google.com/nexus/6"
                                CompanyID:Google.CompanyID];
    Product *Nexus9 = [[Product alloc]initWithID:6 ProductName:@"Nexus 9"
                                ProductReference:@"http://www.google.com/nexus/9"
                                CompanyID:Google.CompanyID];
    
    // Samsung
    Product *GalaxyS5 = [[Product alloc]initWithID:7 ProductName:@"Samsung Galaxy S5"
                                ProductReference:@"http://www.samsung.com/global/microsite/galaxys5/specs.html"
                                CompanyID:Samsung.CompanyID];
    Product *GalaxyNote4 = [[Product alloc]initWithID:8 ProductName:@"Samsung Galaxy Note 4"
                                ProductReference:@"http://www.samsung.com/global/microsite/galaxynote4/note4_specs.html"
                                CompanyID:Samsung.CompanyID];
    Product *GalaxyTab = [[Product alloc]initWithID:9 ProductName:@"Samsung Galaxy Tab"
                                ProductReference:@"http://www.samsung.com/global/microsite/galaxytab/10.1/spec.html"
                                CompanyID:Samsung.CompanyID];
    
    // Microsoft
    Product *Lumia635 = [[Product alloc]initWithID:10 ProductName:@"Nokia Lumia 635" ProductReference:@"http://www.microsoft.com/en-us/mobile/phone/lumia635/#ProductSpecsEnhancedWidget" CompanyID:Microsoft.CompanyID];
    Product *Lumia1320 = [[Product alloc]initWithID:11 ProductName:@"Nokia Lumia 1320" ProductReference:@"http://www.microsoft.com/en-us/mobile/phone/lumia1320/#ProductSpecsEnhancedWidget" CompanyID:Microsoft.CompanyID];
    Product *Surface2 = [[Product alloc]initWithID:12 ProductName:@"Microsoft Surface 2" ProductReference:@"http://www.microsoft.com/surface/en-us/products/surface-2" CompanyID:Microsoft.CompanyID];
    
    self.companies = [[NSMutableArray alloc]initWithObjects:Apple, Google, Samsung, Microsoft, nil];
    self.products = [[NSMutableArray alloc]initWithObjects:IPad,IPhone,IPodTouch,Nexus5,Nexus6,Nexus9,GalaxyS5,GalaxyNote4,GalaxyTab,Lumia635,Lumia1320,Surface2, nil];
}
-(void)addProductsToCompanies{
    for (Product* product in self.products) {
        for (Company* company in self.companies) {
            if (company.CompanyID == product.CompanyID) {
                [company.CompanyProducts addObject:product];
            }
        }
    }
}

-(NSMutableArray *)GetCompanies{
    if(![self.currentDefaults boolForKey:@"firstRun"]) {
        return self.companies;
    }else{
        NSData *companyEncodedObject = [self.currentDefaults objectForKey:@"CurrentCompanyList"];
        NSMutableArray *currentCompanyList = [NSKeyedUnarchiver unarchiveObjectWithData:companyEncodedObject];
        return currentCompanyList;
    }
}

-(void)saveCompanies:(NSMutableArray *)currentArray
{
    NSData *companyEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:currentArray];
    [self.currentDefaults setObject:companyEncodedObject forKey:@"CurrentCompanyList"];
    [self.currentDefaults synchronize];
}
@end
