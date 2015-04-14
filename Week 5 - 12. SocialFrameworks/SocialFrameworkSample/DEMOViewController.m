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
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];

    // In your viewDidLoad method: Set permisiions for the FBSDKLoginButton
    self.loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        // User is logged in, do work such as go to next view controller.
        
        NSLog(@"Logged IN: %@", [FBSDKAccessToken currentAccessToken]);
    }
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

#pragma mark - Facebook Login Button methods
/*!
 @abstract Sent to the delegate when the button was used to login.
 @param loginButton the sender
 @param result The results of the login
 @param error The error (if any) from the login
 */
- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error{
    NSLog(@"%@", result.token);
}

/*!
 @abstract Sent to the delegate when the button was used to logout.
 @param loginButton The button that was clicked.
 */
- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    NSLog(@"Logged out.");
}

#pragma mark - Twitter Methods
- (IBAction)tweet:(id)sender {
    
}
@end
