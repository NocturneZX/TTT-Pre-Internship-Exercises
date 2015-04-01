//
//  DEMOViewController.h
//  CreatesUiProgramatically
//
//  Created by Julio Reyes on 13/11/13.
//  Copyright (c) 2013 Julio Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DEMORect.h"

@interface DEMOViewController : UIViewController

@property (nonatomic,retain) UILabel *headerLabel;
@property (nonatomic,retain) UIButton *sampleBt;
@property (nonatomic,retain) UISegmentedControl *sgctrl;
@property (nonatomic,retain) UIImageView *imgView;
@property (nonatomic,retain) UIScrollView *scrollView;

@property (nonatomic,retain)  DEMORect *rectView;

-(void)createLabel;
-(void)createButton;
-(void)createsegment;
-(void)createImageView;

-(void)createScrollView;


-(IBAction)sampleBtAction;
-(IBAction)pushcgctrl:(id)sender;


@end
