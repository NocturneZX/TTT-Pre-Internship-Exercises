//
//  DEMOViewController.h
//  UIWebView
//
//  Created by  Julio Reyes  on 12/11/13.
//  Copyright (c) 2013  Julio Reyes . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DEMOViewController : UIViewController<UIWebViewDelegate>{
    IBOutlet UIWebView *webPage;
    IBOutlet UITextField *urlbar;
    IBOutlet UIImageView *imview;
}

-(IBAction)launch:(id)sender;
-(IBAction)url:(id)sender;

@end
