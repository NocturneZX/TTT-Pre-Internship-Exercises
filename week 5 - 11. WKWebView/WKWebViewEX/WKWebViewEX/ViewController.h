//
//  ViewController.h
//  WKWebViewEX
//
//  Created by Julio Reyes on 4/8/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#ifdef __IPHONE_8_0
#import <WebKit/WebKit.h>
#endif

@interface ViewController : UIViewController

#ifdef __IPHONE_8_0
<WKNavigationDelegate,
WKScriptMessageHandler,
WKUIDelegate>
#endif


@end