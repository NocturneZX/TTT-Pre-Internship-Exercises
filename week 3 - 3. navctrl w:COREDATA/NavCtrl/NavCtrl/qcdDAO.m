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
#import "qcdDemoAppDelegate.h"

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
    qcdDemoAppDelegate *appDelegate = APPDELEGATE;
    self.managedObjectContext = appDelegate.managedObjectContext;
    
    Company *newApple = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:self.managedObjectContext];
    newApple.id =[NSNumber numberWithInt:1];
    newApple.name = @"Apple";
    newApple.image = @"apple.png";
    
    Company *newGoogle = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:self.managedObjectContext];
    newGoogle.id = [NSNumber numberWithInt:2];
    newGoogle.name = @"Google";
    newGoogle.image = @"google.png";
    
    Company *newSamsung= [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:self.managedObjectContext];
    newSamsung.id = [NSNumber numberWithInt:3];
    newSamsung.name = @"Samsung";
    newSamsung.image = @"samsung.jpg";
    
    Company *newMicrosoft= [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:self.managedObjectContext];
    newMicrosoft.id = [NSNumber numberWithInt:4];
    newMicrosoft.name = @"Microsoft";
    newMicrosoft.image = @"microsoft.png";
    
    // Products
    // Apple
    Product *CDIPad = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    CDIPad.productid = [NSNumber numberWithInt:1];
    CDIPad.productname = @"iPad Air";
    CDIPad.reference = @"https://www.apple.com/ipad-air/specs/";
    CDIPad.companyid = newApple.id;
    
    Product *CDIPhone = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    CDIPhone.productid = [NSNumber numberWithInt:2];
    CDIPhone.productname = @"iPhone";
    CDIPhone.reference = @"https://www.apple.com/iphone-6/specs/";
    CDIPhone.companyid = newApple.id;
    
    Product *CDIPodTouch = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    CDIPodTouch.productid = [NSNumber numberWithInt:3];
    CDIPodTouch.productname = @"iPod Touch";
    CDIPodTouch.reference = @"https://www.apple.com/ipod-touch/specs/";
    CDIPodTouch.companyid = newApple.id;
    
    
    // Google
    Product *cdNexus5 = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    cdNexus5.productid = [NSNumber numberWithInt:4];
    cdNexus5.productname = @"Nexus 5";
    cdNexus5.reference = @"http://www.google.com/nexus/5";
    cdNexus5.companyid    = newGoogle.id;
    
    Product *cdNexus6 = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    cdNexus6.productid = [NSNumber numberWithInt:5];
    cdNexus6.productname = @"Nexus 6";
    cdNexus6.reference = @"http://www.google.com/nexus/6";
    cdNexus6.companyid = newGoogle.id;
    
    Product *cdNexus9 = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    cdNexus9.productid = [NSNumber numberWithInt:6];
    cdNexus9.productname = @"Nexus 9";
    cdNexus9.reference = @"http://www.google.com/nexus/9";
    cdNexus9.companyid = newGoogle.id;
    
    // Samsung
    Product *cdGalaxyS5 = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    cdGalaxyS5.productid = [NSNumber numberWithInt:7];;
    cdGalaxyS5.productname = @"Samsung Galaxy S5";
    cdGalaxyS5.reference = @"http://www.samsung.com/global/microsite/galaxys5/specs.html";
    cdGalaxyS5.companyid = newSamsung.id;
    
    Product *cdGalaxyNote4 = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    cdGalaxyNote4.productid = [NSNumber numberWithInt:8];
    cdGalaxyNote4.productname = @"Samsung Galaxy Note 4";
    cdGalaxyNote4.reference = @"http://www.samsung.com/global/microsite/galaxynote4/note4_specs.html";
    cdGalaxyNote4.companyid = newSamsung.id;
    
    Product *cdGalaxyTab = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    cdGalaxyTab.productid = [NSNumber numberWithInt:9];
    cdGalaxyTab.productname = @"Samsung Galaxy Tab";
    cdGalaxyTab.reference = @"http://www.samsung.com/global/microsite/galaxytab/10.1/spec.html";
    cdGalaxyTab.companyid = newSamsung.id;
    
    // Microsoft
    Product *cdLumia635 =  [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    cdLumia635.productid = [NSNumber numberWithInt:10];
    cdLumia635.productname = @"Nokia Lumia 635";
    cdLumia635.reference = @"http://www.microsoft.com/en-us/mobile/phone/lumia635/#ProductSpecsEnhancedWidget";
    cdLumia635.companyid = newMicrosoft.id;
    
    Product *cdLumia1320 =  [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    cdLumia1320.productid = [NSNumber numberWithInt:11];
    cdLumia1320.productname = @"Nokia Lumia 1320";
    cdLumia1320.reference = @"http://www.microsoft.com/en-us/mobile/phone/lumia1320/#ProductSpecsEnhancedWidget";
    cdLumia1320.companyid = newMicrosoft.id;
    
    
    Product *cdSurface2 =  [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.managedObjectContext];
    cdSurface2.productid = [NSNumber numberWithInt:12];
    cdSurface2.productname = @"Microsoft Surface 2";
    cdSurface2.reference = @"http://www.microsoft.com/surface/en-us/products/surface-2";
    cdSurface2.companyid = newMicrosoft.id;
    
    
    NeueCompany *Apple = [[NeueCompany alloc]initWithCompanyID:[newApple.id integerValue] CompanyName:newApple.name
                                               CompanyProducts:[NSMutableArray array]
                                                  CompanyImage:newApple.image];
    
    NeueCompany *Google = [[NeueCompany alloc]initWithCompanyID:[newGoogle.id integerValue] CompanyName:newGoogle.name
                                                CompanyProducts:[NSMutableArray array]
                                                   CompanyImage:newGoogle.image];
    NeueCompany *Samsung = [[NeueCompany alloc]initWithCompanyID:[newSamsung.id integerValue] CompanyName:newSamsung.name
                                                 CompanyProducts:[NSMutableArray array]
                                                    CompanyImage:newSamsung.image];
    NeueCompany *Microsoft = [[NeueCompany alloc]initWithCompanyID:[newMicrosoft.id integerValue]
                                                       CompanyName:newMicrosoft.name
                                                   CompanyProducts:[NSMutableArray array]
                                                      CompanyImage:newMicrosoft.image];
    
    // Products
    // Apple
    NeueProduct *IPad = [[NeueProduct alloc]initWithID:[CDIPad.productid integerValue] ProductName:CDIPad.productname
                                      ProductReference:CDIPad.reference
                                             CompanyID:[CDIPad.companyid integerValue]];
    NeueProduct *IPhone = [[NeueProduct alloc]initWithID:[CDIPhone.productid integerValue] ProductName:CDIPhone.productname
                                        ProductReference:CDIPhone.reference
                                               CompanyID:[CDIPhone.companyid integerValue]];
    NeueProduct *IPodTouch = [[NeueProduct alloc]initWithID:[CDIPodTouch.productid integerValue] ProductName:CDIPodTouch.productname
                                           ProductReference:CDIPodTouch.reference
                                                  CompanyID:[CDIPodTouch.companyid integerValue]];
    
    // Google
    NeueProduct *Nexus5 = [[NeueProduct alloc]initWithID:[cdNexus5.productid integerValue] ProductName:cdNexus5.productname ProductReference:cdNexus5.reference CompanyID:[cdNexus5.companyid integerValue]];
    NeueProduct *Nexus6 = [[NeueProduct alloc]initWithID:[cdNexus6.productid integerValue] ProductName:cdNexus6.productname ProductReference:cdNexus6.reference CompanyID:[cdNexus6.companyid integerValue]];
    NeueProduct *Nexus9 = [[NeueProduct alloc]initWithID:[cdNexus9.productid integerValue] ProductName:cdNexus9.productname ProductReference:cdNexus9.reference CompanyID:[cdNexus9.companyid integerValue]];
    
    // Samsung
    NeueProduct *GalaxyS5 = [[NeueProduct alloc]initWithID:[cdGalaxyS5.productid integerValue] ProductName:cdGalaxyS5.productname ProductReference:cdGalaxyS5.reference CompanyID:[cdGalaxyS5.companyid integerValue]];
    NeueProduct *GalaxyNote4 = [[NeueProduct alloc]initWithID:[cdGalaxyNote4.productid integerValue] ProductName:cdGalaxyNote4.productname ProductReference:cdGalaxyNote4.reference CompanyID:[cdGalaxyNote4.companyid integerValue]];
    NeueProduct *GalaxyTab = [[NeueProduct alloc]initWithID:[cdGalaxyTab.productid integerValue] ProductName:cdGalaxyTab.productname ProductReference:cdGalaxyTab.reference CompanyID:[cdGalaxyTab.companyid integerValue]];
    
    // Microsoft
    NeueProduct *Lumia635 = [[NeueProduct alloc]initWithID:[cdLumia635.productid integerValue] ProductName:cdLumia635.productname ProductReference:cdLumia635.reference CompanyID:[cdLumia635.companyid integerValue]];
    NeueProduct *Lumia1320 = [[NeueProduct alloc]initWithID:[cdLumia1320.productid integerValue] ProductName:cdLumia1320.productname ProductReference:cdLumia1320.reference CompanyID:[cdLumia1320.companyid integerValue]];
    NeueProduct *Surface2 = [[NeueProduct alloc]initWithID:[cdSurface2.productid integerValue] ProductName:cdSurface2.productname ProductReference:cdSurface2.reference  CompanyID:[cdSurface2.companyid integerValue]];
    
    self.companies = [[NSMutableArray alloc]initWithObjects:Apple, Google, Samsung, Microsoft, nil];
    self.products = [[NSMutableArray alloc]initWithObjects:IPad,IPhone,IPodTouch,Nexus5,Nexus6,Nexus9,GalaxyS5,GalaxyNote4,GalaxyTab,Lumia635,Lumia1320,Surface2, nil];
}
-(void)addProductsToCompanies{
    for (NeueProduct* product in self.products) {
        for (NeueCompany* company in self.companies) {
            if (company.CompanyID == product.CompanyID) {
                [company.CompanyProducts addObject:product];
            }
        }
    }
}
-(NSMutableArray *)GetCompanies{
    return self.companies;
}

@end
