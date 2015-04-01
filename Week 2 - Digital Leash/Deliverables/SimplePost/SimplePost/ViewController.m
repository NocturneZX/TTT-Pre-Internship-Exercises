//
//  ViewController.m
//  SimplePost
//
//  Created by Julio Reyes on 2/24/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *radius;

@property (nonatomic, strong) NSMutableData *postData;

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userLatitude;
@property (weak, nonatomic) IBOutlet UITextField *userLongitude;
@property (weak, nonatomic) IBOutlet UITextField *userRadius;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.userID = @"Julio";
//    self.latitude = @"40.848092";
//    self.longitude = @"-73.933278";
//    self.radius = @"10";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)PostData:(id)sender{
    self.userID = self.userName.text;
    self.latitude = self.userLatitude.text;
    self.longitude = self.userLongitude.text;
    self.radius = self.userRadius.text;
    
    
    // Declare the NSDictionary
    NSDictionary *userDetails = @{@"utf8": @"✓", @"authenticity_token":@"EvZva3cKnzo3Y0G5R3NktucCr99o/2UWOPVAmJYdBOc=", @"user":@{@"username":self.userID,@"latitude":self.latitude,@"longitude":self.longitude,@"radius":self.radius}, @"commit":@"CreateUser", @"action":@"update", @"controller":@"users"};
    
    // Create the NSData which will hold the
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userDetails
                                                       options:0
                                                         error:&error];
    
    if (!jsonData) {
        NSLog(@"JSON error: %@", error);
    } else {
        
       // NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
       // NSLog(@"JSON OUTPUT FROM NSDictionary: %@\n\n", JSONString);
        
        // Create the request.
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://protected-wildwood-8664.herokuapp.com/users"]];
        
        // Specify that it will be a POST request
        request.HTTPMethod = @"POST";
        
        // Convert your JSON data and set your request's HTTPBody property
        request.HTTPBody = jsonData;
        
        // This is how we set header fields
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

        
        // Create url connection and fire request
        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        if (conn) {
            NSLog(@"Connecting... %@", request);
        }else{
            NSLog(@"No Connection!");
        }
        
    }
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    
    

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    NSLog(@"Done!");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten
totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite{
    // This method provides an estimate of the progress of a URL upload.
    // The value of totalBytesExpectedToWrite may change during the upload
    // if the request needs to be retransmitted due to a lost connection
    // or an authentication challenge from the server.
    
    if (abs((int)totalBytesExpectedToWrite - (int)totalBytesWritten) < 0.005) {
        NSLog(@"Done!");
    }
}


@end
