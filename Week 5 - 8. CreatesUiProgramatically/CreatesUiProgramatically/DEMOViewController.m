//
//  DEMOViewController.m
//  CreatesUiProgramatically
//
//  Created by Julio Reyes on 13/11/13.
//  Copyright (c) 2013 Julio Reyes. All rights reserved.
//

#import "DEMOViewController.h"
#import "DEMORect.h"

@interface DEMOViewController ()

@end

@implementation DEMOViewController

@synthesize headerLabel,sampleBt;
@synthesize sgctrl, imgView, scrollView;
@synthesize rectView;

-(IBAction)pushcgctrl:(id)sender{
    switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
        case 0:

            //Label Change
            headerLabel.text = @"You click the TurnToTech Button";
            headerLabel.backgroundColor = [UIColor redColor];
            headerLabel.textColor = [UIColor blackColor];
            
            //Image Display
            imgView.image = [UIImage imageNamed:@"logo.png"];
            
            break;
            
        case 1:
            
            headerLabel.text = @"You click the Qcd Button";
            headerLabel.backgroundColor = [UIColor whiteColor];
            
            imgView.image = [UIImage imageNamed:@"qcd.jpg"];
            
             
            break;
            
        default:
            break;
    }
}

-(void)sampleBtAction
{
    headerLabel.text = @"User Click on dynamic Button";
    [imgView setImage:nil];
}


-(void)createsegment
{
    sgctrl = [[[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 320, 60) ] initWithItems:[NSArray arrayWithObjects:@"TurnToTech",@"Qcd", nil]];
    [self.sgctrl setCenter:CGPointMake(self.view.frame.size.width / 2, (self.view.frame.size.height / 2) - (self.scrollView.frame.size.height))];

//    sgctrl.frame = CGRectMake((self.view.frame.size.width / 2)- (sgctrl.frame.size.width / 2), (self.view.frame.size.height / 2) - - (sgctrl.frame.size.height / 2), 320, 60);
    [sgctrl setBackgroundColor:[UIColor blackColor]];
    
    [sgctrl addTarget:self action:@selector(pushcgctrl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:sgctrl];
}

-(void)createLabel
{
    headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(500, 25, 320, 44)];
    headerLabel.center = CGPointMake(self.view.frame.size.width / 2, (self.view.frame.size.height / 6));
    headerLabel.font = [UIFont fontWithName:@"Futura" size:18];
    headerLabel.text = @"Created at 1:39PM";
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:headerLabel];
}

-(void)createButton
{
    sampleBt = [[UIButton alloc] initWithFrame:CGRectMake(5, 110, 150, 30)];
    sampleBt.center = CGPointMake(self.view.frame.size.width / 2, (self.view.frame.size.height / 4));

    [sampleBt setBackgroundColor:[UIColor blackColor]];
    [sampleBt setTitle:@"Dynamic Button" forState:UIControlStateNormal];
    [sampleBt addTarget:self action:@selector(sampleBtAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sampleBt];
}

-(void)createImageView
{
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 20, 100, 100) ];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imgView];

}

-(void)createScrollView
{
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 500, 300)];
    scrollView.frame = CGRectMake((self.view.frame.size.width / 2) - (scrollView.frame.size.width / 2), (self.view.frame.size.height / 2) - (scrollView.frame.size.height / 2), 500, 300);
    scrollView.backgroundColor = [UIColor blackColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, 1000)];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    NSMutableString *txt = [[NSMutableString alloc]init];
    
    for(int i=0;i<200;i++)[txt appendString:@"The quick brown fox jumps upon a lazy dog.\n "];
    
    [label setText:txt];
    
    [scrollView addSubview:label];
    [scrollView setContentSize: label.frame.size];
    
    [self.view addSubview:scrollView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated  {
    [super viewWillAppear:animated];
    
    [self createScrollView];
    [self createLabel];
    [self createButton];
    [self createsegment];
    [self createImageView];
    [self setupRect];

    
}

-(void)setupRect{
    rectView = [[DEMORect alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 105, self.view.frame.size.height - 105, 100, 100)];
    [self.view addSubview:rectView];
}

- (void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    if (UIInterfaceOrientationIsLandscape(self.view.window.rootViewController.interfaceOrientation)) {
       rectView.frame = CGRectMake(self.view.frame.size.width - 105, self.view.frame.size.height - 105, self.rectView.frame.size.width, self.rectView.frame.size.height);
    }
    else if (UIInterfaceOrientationIsPortrait(self.view.window.rootViewController.interfaceOrientation)) {
        rectView.frame = CGRectMake(self.view.frame.size.width - 105, self.view.frame.size.height - 105, self.rectView.frame.size.width, self.rectView.frame.size.height);
    }
    NSLog(@"%f %f", self.view.frame.size.width, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
