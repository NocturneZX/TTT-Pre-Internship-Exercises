//
//  DEMOViewController.m
//  UIWebView
//
//  Created by Aditya on 12/11/13.
//  Copyright (c) 2013 Aditya. All rights reserved.
//

#import "DEMOViewController.h"

@interface DEMOViewController ()

@end

@implementation DEMOViewController



-(IBAction)launch:(id)sender
{
    [webPage loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.com" ]]];
}


-(IBAction)url:(id)sender
{
    NSString *query = [urlbar.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSURL *urlquery = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",query]];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlquery];
    [webPage loadRequest:request];
}


- (void)viewDidLoad
{
    imview.image=[UIImage imageNamed:@"logo.png"];
    [self launch:self];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
