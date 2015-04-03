//
//  SecondViewController.m
//  SimpleTabAppKai
//
//  Created by  Julio Reyes  on 4/1/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (nonatomic, weak) IBOutlet UITextField *txtNotify;
@end

@implementation SecondViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"Gundam";
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
