//
//  DeviceWebViewController.h
//  NavCtrl
//
//  Created by Julio Reyes on 3/2/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface DeviceWebViewController : UIViewController<UIWebViewDelegate>
@property (retain, nonatomic) NSString *deviceURL;
@end
