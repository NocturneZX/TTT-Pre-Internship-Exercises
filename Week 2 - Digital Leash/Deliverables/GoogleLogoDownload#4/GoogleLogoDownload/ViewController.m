//
//  ViewController.m
//  GoogleLogoDownload
//
//  Created by Julio Reyes on 2/24/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *googleImageView;

@end

@implementation ViewController
@synthesize responseData;
@synthesize connection;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Create the request.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://lh3.ggpht.com/jcNpFpq6451L4vVyOe8IsTR1BbHq1hfqefi-PqANRf8W61DiCQYVzHSRG6pzriHrXmZk8UTrAJVk92lqraNMGHUJD7Bs6tDszCYwLAo=s660"] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
    
    // Set request method
    [request setHTTPMethod:@"GET"];
    
    self.responseData = [[NSMutableData alloc] init];

    
    // Create url connection and fire request
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    //self.responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [self.responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
    NSLog(@"%@", self.responseData);
    UIImage *googleLogo = [[UIImage alloc]initWithData:self.responseData];
    [self.googleImageView setImage:googleLogo];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}


@end
