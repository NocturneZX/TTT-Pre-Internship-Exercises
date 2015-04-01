//
//  Product.h
//  NavCtrl
//
//  Created by Julio Reyes on 3/16/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Product : NSManagedObject

@property (nonatomic, retain) NSNumber * companyid;
@property (nonatomic, retain) NSNumber * productid;
@property (nonatomic, retain) NSString * productname;
@property (nonatomic, retain) NSString * reference;

@end
