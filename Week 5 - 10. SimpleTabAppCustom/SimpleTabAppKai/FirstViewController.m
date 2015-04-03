//
//  FirstViewController.m
//  SimpleTabAppKai
//
//  Created by  Julio Reyes  on 4/1/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController (){
    int counter1;
    int counter2;
}

@property (nonatomic, weak) IBOutlet UITextField *txtCounter1;
@property (nonatomic, weak) IBOutlet UITextField *txtCounter2;

@end

@implementation FirstViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        
        
        counter1 = 0;
        counter2 = 0;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveNotification:) name:@"Test1" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveNotification:) name:@"Test2" object:nil];
    }
    return self;
}
-(void)receiveNotification:(NSNotification *) notification{
    
    NSLog(@"First View Notification Received: %@", [notification name]);
    
    NSDictionary *extraInfo = [notification userInfo];
    
    if ([[notification name] isEqualToString:@"Test1"]) {
        counter1++;
        _txtCounter1.text = [NSString stringWithFormat:@"The Sun's light has burned Moon's gaze.%@: %d",
                            [extraInfo objectForKey:@"button_name"], counter1];
    }
    else{
        counter2++;
        _txtCounter2.text = [NSString stringWithFormat:@"The Moon's darknees has extingushed Sun's flames. %@: %d",
                            [extraInfo objectForKey:@"button_name"], counter2];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
