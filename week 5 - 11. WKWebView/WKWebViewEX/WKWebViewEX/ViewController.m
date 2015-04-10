//
//  ViewController.m
//  WKWebViewEX
//
//  Created by Julio Reyes on 4/8/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) WKWebView *webViewEX;
@property (nonatomic, strong) WKWebViewConfiguration * webConfig;
@end

@implementation ViewController

//-(void)loadView{
//    // First create a WKWebViewConfiguration object so we can add a controller
//    // pointing back to this ViewController.
//    
//    // Initialize the WKWebView with the current frame and the configuration
//    // setup above
//    
//    //CGRect f = self.view.frame;
//    
//
//    
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _webViewEX = [[WKWebView alloc] initWithFrame:self.view.frame configuration:self.webConfig];
    self.webViewEX.navigationDelegate = self;
    
    // This is the URL to be loaded into the WKWebView.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    // Load the jsbin URL into the WKWebView and then add it as a sub-view.
    [_webViewEX loadRequest:request];
    
    [[self view]addSubview:_webViewEX];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WebConfig accessors
-(WKWebViewConfiguration *) webConfig{
    if (!_webConfig) {
        self.webConfig = [[WKWebViewConfiguration alloc]
                          init];
        
        WKUserContentController *controller = [[WKUserContentController alloc]
                                               init];
        
        [controller addScriptMessageHandler:self name:@"buttonClicked"];
        [controller addScriptMessageHandler:self name:@"callbackHandler"];

        NSString* script =[NSString stringWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"main" ofType:@"js" ] encoding:NSUTF8StringEncoding error:nil];

        // Specify when and where and what user script needs to be injected into the web document
        WKUserScript* userScript = [[WKUserScript alloc]initWithSource:script injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        
        // Add the user script to the WKUserContentController instance
        [controller addUserScript:userScript];
        
        // Configure the WKWebViewConfiguration instance with the WKUserContentController
        self.webConfig.userContentController = controller;
        
    }
    return _webConfig;
}
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    
    if([message.name isEqual: @"callbackHandler"])
        NSLog(@"JavaScript is sending a message %@", message.body);
    else if ([message.name isEqual: @"buttonClicked"])
        NSLog(@"JavaScript is sending a message %@", message.body);
    
    // JS objects are automatically mapped to ObjC objects
    id messageBody = message.body;
    if ([messageBody isKindOfClass:[NSDictionary class]]) {
        [self changeHeader];
    }
}
-(void)changeHeader{
    NSString* js2 = @"redHeader()";
    [self.webViewEX evaluateJavaScript:js2 completionHandler:^(id response, NSError * error) {
        NSLog(@"%@",error);
    }];
}
@end

