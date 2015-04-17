//
//  qcdDemoViewController.m
//  SevenDemo
//
//  Created by Aditya Narayan on 9/26/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "qcdDemoViewController.h"

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface qcdDemoViewController ()  <UICollisionBehaviorDelegate>

@property (nonatomic, strong) UIDynamicAnimator *animator;

@property (weak, nonatomic) IBOutlet UILabel *fallingLabel;


@property (weak, nonatomic) IBOutlet UIImageView *square2;
@property (weak, nonatomic) IBOutlet UIImageView *square3;
@property (weak, nonatomic) IBOutlet UIImageView *square4;

@property (weak, nonatomic) IBOutlet UISlider *slider;

@property (weak, nonatomic) IBOutlet UISwitch *boolSwitch;

@property (weak, nonatomic) IBOutlet MKMapView *mapDisplay;

@property (weak, nonatomic) IBOutlet UIStepper *stepperCtrl;

@property (nonatomic, strong) NSMutableArray *originalFrames;

@end

@implementation qcdDemoViewController
BOOL isGravityOn = NO;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.originalFrames = [[NSMutableArray alloc]init];
    NSArray *uiItems = @[self.fallingLabel,self.square2,self.square3,self.square4,self.slider,self.boolSwitch, self.mapDisplay,self.stepperCtrl];
    for (UIView* uiElements in uiItems) {
        CGRect originalFrame = uiElements.frame;
        [self.originalFrames addObject:[NSValue valueWithCGRect:originalFrame]];
    }
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (IBAction)hitSwitch:(id)sender {
    if (sender == [UISwitch class]) {
        if (self.boolSwitch.isOn) {
            
        }else{
            self.mapDisplay.transform =CGAffineTransformIdentity;
        }
    }
}

- (IBAction)startGravity:(id)sender {
    [sender setEnabled:NO];

    if (!isGravityOn) {
        [self initAnimation];
        isGravityOn = YES;
    }else{
        isGravityOn = NO;
        [self.animator removeAllBehaviors];
        NSArray *uiItems = @[self.fallingLabel,self.square2,self.square3,self.square4,self.slider,self.boolSwitch, self.mapDisplay,self.stepperCtrl];
        
        [UIView animateWithDuration:2.0
                              delay:0.0
             usingSpringWithDamping:.4
              initialSpringVelocity:20
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             [uiItems  enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                 [(UIView *)obj setTransform: CGAffineTransformIdentity];
                                 
                                 CGRect originalFrame = [[self.originalFrames objectAtIndex:idx]CGRectValue];
                                 
                                 [(UIView *)obj setFrame: originalFrame];
                                 
                             }];
                             
                         }
                         completion:^(BOOL finished) {
                             
                         }];
        
        
    }
    [sender setEnabled:YES];
}


-(void) initAnimation
{
    
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIGravityBehavior *gravityBeahvior = [[UIGravityBehavior alloc] initWithItems:@[ self.fallingLabel,self.square2,self.square3,self.square4,self.slider,self.boolSwitch, self.mapDisplay,self.stepperCtrl]];
    
    [animator addBehavior:gravityBeahvior];
    
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.fallingLabel,self.square2,self.square3,self.square4,self.slider,self.boolSwitch, self.mapDisplay,self.stepperCtrl]];
    // Creates collision boundaries from the bounds of the dynamic animator's
    // reference view (self.view).
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    collisionBehavior.collisionDelegate = self;
    
    [animator addBehavior:collisionBehavior];
    
    self.animator = animator;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
