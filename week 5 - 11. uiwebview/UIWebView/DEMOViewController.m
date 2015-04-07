//
//  DEMOViewController.m
//  UIWebView
//
//  Created by  Julio Reyes  on 12/11/13.
//  Copyright (c) 2013  Julio Reyes . All rights reserved.
//

#import "DEMOViewController.h"

@interface DEMOViewController ()

@end

@implementation DEMOViewController



-(IBAction)launch:(id)sender
{
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"page" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [webPage loadHTMLString:htmlString baseURL:nil];
    
}


-(IBAction)url:(id)sender
{
    NSString *query = [urlbar.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSURL *urlquery = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",query]];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlquery];
    [webPage loadRequest:request];
}

-(IBAction)JSButton:(id)sender{
    NSString* jsCallback = @"alert(\"Alert from Objective C in JavaScript! Look at me!\");";
    [webPage stringByEvaluatingJavaScriptFromString:jsCallback ];
}

- (void)viewDidLoad
{
    imview.image=[UIImage imageNamed:@"logo.png"];
    [super viewDidLoad];
    
    [webPage loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.gundamplanet.com" ]]];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebView Delegates
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return NO;
}

@end
