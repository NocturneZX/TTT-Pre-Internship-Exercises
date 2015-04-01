//
//  Company.h
//  NavCtrl
//
//  Created by Julio Reyes on 3/16/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Company : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * name;

@end
