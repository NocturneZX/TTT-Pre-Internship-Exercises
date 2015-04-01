//
//  DeviceWebViewController.m
//  NavCtrl
//
//  Created by Julio Reyes on 3/2/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import "DeviceWebViewController.h"

@interface DeviceWebViewController ()
@property (retain, nonatomic) IBOutlet UIWebView *deviceWebView;
@end

@implementation DeviceWebViewController
@synthesize deviceURL;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //NSString *fullURL = [NSString string];
    NSURL *url = [NSURL URLWithString:deviceURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_deviceWebView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UIWebView Delegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"Loading stuff...");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"%@", webView);
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"%@", error);
}


- (void)dealloc {
    [_deviceWebView release];
    [super dealloc];
}
@end
