//
//  qcdDemoViewController.h
//  NavCtrl
//
//  Created by Julio Reyes on 10/22/13.
//  Copyright (c) 2013 Julio Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "qcdDemoAppDelegate.h"

@class ChildViewController;

@interface qcdDemoViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) NSMutableArray *companyList;

@property (nonatomic, retain) IBOutlet ChildViewController * childVC;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

-(void)removeCell:(int)i;
-(void)handleCoreData;

@end
