//
//  ViewController.m
//  DigitalLeashChild
//
//  Created by Julio Reyes on 2/25/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;


@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (nonatomic, strong) NSMutableData *PATCHData;

@property (weak, nonatomic) IBOutlet UITextField *userName;

@end

@implementation ViewController
@synthesize locationManager;
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self startStandardUpdates];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Core Location Methods
-(IBAction)updateChildLocation:(id) sender{
    //Set the ID to update
    self.userID = self.userName.text;
    NSDictionary *childDict = @{@"utf8": @"✓", @"authenticity_token":@"EvZva3cKnzo3Y0G5R3NktucCr99o/2UWOPVAmJYdBOc=", @"user":@{@"username":self.userID,@"current_lat":self.latitude,@"current_longitude":self}, @"commit":@"Create User", @"action":@"update", @"controller":@"users"};
    
    NSLog(@"%@", childDict);
    
    // One way to check if the values are clear
//    for (id item in [childDict objectForKey:@"user"]) {
//        if ([item class] != [NSString class]) {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"OYE PAPI! One of your item isn't a string." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
//            [alertView show];
//            return;
//        }
//    }
    
    BOOL successfulConversion = [NSJSONSerialization isValidJSONObject:childDict];
    if (!successfulConversion) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"OYE PAPI! One of your item isn't a string." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        [alertView show];
    }else{
        
        // Create the NSData which will hold the
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:childDict
                                                           options:0
                                                             error:&error];
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Something Happened." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
            [alertView show];
        }else{
            // Create the request.
            NSString *urlString = [NSString stringWithFormat:@"http://protected-wildwood-8664.herokuapp.com/users/%@", self.userID];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
            
            // Set request method ?  ?
            [request setHTTPMethod:@"PATCH"];
            [request setHTTPBody:jsonData];
            
            // This is how we set header fields
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            // [request setValue:@"PATCH" forHTTPHeaderField:@"X-HTTP-Method-Override"];
            
            // Create url connection and fire request
            NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            
            //
            if (connection) {
                self.PATCHData = [[NSMutableData alloc] init];
            }else{
                // If we get any connection error we can manage it here…
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"No Network Connection" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                [alertView show];
            }
        }
    }// end successfulConversion
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
    NSLog(@"Receiving data...%@", data);
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
    NSLog(@"Error!, %@", error);
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite{
    // This method provides an estimate of the progress of a URL upload.
    // The value of totalBytesExpectedToWrite may change during the upload
    // if the request needs to be retransmitted due to a lost connection
    // or an authentication challenge from the server.
    
    if (abs((int)totalBytesExpectedToWrite - (int)totalBytesWritten) < 0.005) {
        NSLog(@"Body Data Sent....!");
    }
}

#pragma mark - Prep Methods
-(void)startStandardUpdates{
    
    if (locationManager == nil)
        self.locationManager = [[CLLocationManager alloc]init];
    
    // Enable authorizations
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
    
    self.locationManager.delegate = self; // Send update to this class
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events
    self.locationManager.distanceFilter = 500; //meters
    
    [self.locationManager startUpdatingLocation];
}
#pragma mark - Core Location Methods
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *newLocation = [locations lastObject];
    CLLocation *oldLocation;
    
    if (locations.count > 1) {
        oldLocation = [locations objectAtIndex:locations.count - 2];
    }else{
        oldLocation = nil;
    }
    
    self.locationLabel.text = [NSString stringWithFormat:@"Did update location %@ from %@", newLocation, oldLocation];
    
    
    NSDate *eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    
    if (abs(howRecent) < 5.0) {
        // Do stuff
        self.locationLabel.text = [NSString stringWithFormat:@"latitude %+.6f, longitude %+.6f\n",
                                   newLocation.coordinate.latitude,
                                   newLocation.coordinate.longitude];
        
        self.latitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
        self.longitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
        
    }
    
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@", error);
}

-(void)requestAlwaysAuthorization
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    // If the status is denied or only granted for when in use, display an alert
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusDenied) {
        NSString *title;
        title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" : @"Background location is not enabled";
        NSString *message = @"To use background location you must turn on 'Always' in the Location Services Settings";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Settings", nil];
        [alertView show];
    }
    // The user has not enabled any location services. Request background authorization.
    else if (status == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestAlwaysAuthorization];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        // Send the user to the Settings for this app
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }
}

@end
