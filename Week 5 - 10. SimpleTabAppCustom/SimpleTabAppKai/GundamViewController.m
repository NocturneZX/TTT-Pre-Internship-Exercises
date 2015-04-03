//
//  GundamViewController.m
//  SimpleTabAppKai
//
//  Created by  Julio Reyes  on 4/1/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

#import "GundamViewController.h"

@interface GundamViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *gundamImageView;

@end

#define animationDuration 0.5

@implementation GundamViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Gundam";
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [UIView animateWithDuration:animationDuration animations:^{
        // Image will appear
        self.gundamImageView.alpha = 1;
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
