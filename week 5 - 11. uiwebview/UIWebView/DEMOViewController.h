//
//  DEMOViewController.h
//  UIWebView
//
//  Created by Aditya on 12/11/13.
//  Copyright (c) 2013 Aditya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DEMOViewController : UIViewController{
    IBOutlet UIWebView *webPage;
    IBOutlet UITextField *urlbar;
    IBOutlet UIImageView *imview;
}

-(IBAction)launch:(id)sender;
-(IBAction)url:(id)sender;

@end
