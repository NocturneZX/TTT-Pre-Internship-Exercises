//
//  ViewController.m
//  PrintTextField
//
//  Created by Julio Reyes on 2/24/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController
@synthesize textField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PrintTextField:(id)sender {
    
    NSString *textFieldInput = self.textField.text; //self refers to the ViewController
    NSLog(@"%@", textFieldInput);
    
}

#pragma mark - UITextField delegates
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.textField.text = @"";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"You entered %@",self.textField.text);
    [self.textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}
@end
