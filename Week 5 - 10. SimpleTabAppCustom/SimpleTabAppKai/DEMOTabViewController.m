//
//  DEMOTabViewController.m
//  SimpleTabAppKai
//
//  Created by Aditya Narayan on 4/3/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

#import "DEMOTabViewController.h"
#import "BGManager.h"

@interface DEMOTabViewController ()
@property (nonatomic, strong) BGManager *musicManager;

@end

@implementation DEMOTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"CHanneling...");
    self.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if (viewController.tabBarItem.tag == 2) {
        self.musicManager = [[BGManager alloc]init];
        [self.musicManager configureAudioPlayer];
        [self.musicManager playMusic];
    }else{
        [self.musicManager stopMusic];
        self.musicManager = nil;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed{
    NSLog(@"%@", viewControllers.description);

}
@end
