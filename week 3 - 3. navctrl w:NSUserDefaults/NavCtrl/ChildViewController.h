//
//  ChildViewController.h
//  NavCtrl
//
//  Created by Julio Reyes on 10/22/13.
//  Copyright (c) 2013 Julio Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChildViewController : UITableViewController
@property (nonatomic, retain) Company *selectedCompany;
@property (assign) NSInteger currentIndex;
@end
