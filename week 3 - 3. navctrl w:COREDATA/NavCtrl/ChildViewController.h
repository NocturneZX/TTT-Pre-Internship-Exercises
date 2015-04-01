//
//  ChildViewController.h
//  NavCtrl
//
//  Created by Julio Reyes on 10/22/13.
//  Copyright (c) 2013 Julio Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "qcdDemoAppDelegate.h"

@interface ChildViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, retain) NeueCompany *selectedCompany;
@property (assign) NSInteger currentIndex;
@end
