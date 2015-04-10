//
//  DEMOViewController.m
//  SocialFrameworkSample
//
//  Created by Aditya on 12/11/13.
//  Copyright (c) 2013 Aditya. All rights reserved.
//

#import "DEMOViewController.h"
#import <Social/Social.h>


#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface DEMOViewController ()
// In your view header file:
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
@end

@implementation DEMOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // In your viewDidLoad method: Set permisiions for the FBSDKLoginButton
    self.loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnFacebookSharing_Clicked:(id)sender{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *fbSheetOBJ = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
       
        SLComposeViewControllerCompletionHandler __block completionHandler=^(SLComposeViewControllerResult result){
            
            [fbSheetOBJ dismissViewControllerAnimated:YES completion:nil];
            
            switch(result){
                case SLComposeViewControllerResultCancelled:
                default:
                {
                    NSLog(@"Cancelled.....");
                    
                }
                    break;
                case SLComposeViewControllerResultDone:
                {
                    NSLog(@"Posted....");
                }
                    break;
            }};
        
        
        [fbSheetOBJ setInitialText:@"TurnToTech - NYC"];
        [fbSheetOBJ addURL:[NSURL URLWithString:@"http://turntotech.io"]];
        [fbSheetOBJ setCompletionHandler:completionHandler];
        
        [self presentViewController:fbSheetOBJ animated:YES completion:Nil];
    }
}
- (IBAction)btnTwitterSharing_Clicked:(id)sender{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheetOBJ = [SLComposeViewController
                                                  composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheetOBJ setInitialText:@"TurnToTech - NYC"];
        [tweetSheetOBJ addURL:[NSURL URLWithString:@"http://turntotech.io"]];
        [self presentViewController:tweetSheetOBJ animated:YES completion:nil];
    }
}


@end
