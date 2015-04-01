//
//  qcdDemoViewController.h
//  NavCtrl
//
//  Created by Julio Reyes on 10/22/13.
//  Copyright (c) 2013 Julio Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChildViewController;

@interface qcdDemoViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray *companyList;

@property (nonatomic, retain) IBOutlet  ChildViewController * childVC;


@end
