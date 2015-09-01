//
//  ViewController.m
//  DigitalLeash
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

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userLatitude;
@property (weak, nonatomic) IBOutlet UITextField *userLongitude;
@property (weak, nonatomic) IBOutlet UITextField *userRadius;

//Check Status Fields
@property (weak, nonatomic) IBOutlet UITextField *childTextField;
@property (weak, nonatomic) IBOutlet UILabel *childName;
@property (weak, nonatomic) IBOutlet UILabel *childStatus;

@end

@implementation ViewController


#pragma mark - Lifecycle
-(instancetype)init{
    self = [super init];
    if (self != nil){
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self startStandardUpdates];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - POST and GET Methods
-(IBAction)PostData:(id)sender{
    self.userID = self.userName.text;
    self.latitude = self.userLatitude.text;
    self.longitude = self.userLongitude.text;
    self.radius = self.userRadius.text;
    
    
    // Declare the NSDictionary
    NSDictionary *userDetails = @{@"utf8": @"✓", @"authenticity_token":@"EvZva3cKnzo3Y0G5R3NktucCr99o/2UWOPVAmJYdBOc=", @"user":@{@"username":self.userID,@"latitude":self.latitude,@"longitude":self.longitude,@"radius":self.radius}, @"commit":@"CreateUser", @"action":@"update", @"controller":@"users"};
    
    BOOL successfulConversion = [NSJSONSerialization isValidJSONObject:userDetails];
    if (!successfulConversion) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"OYE PAPI! One of your item isn't a string." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
        [alertView show];
    }else{
        // Create the NSData which will hold the
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userDetails
                                                           options:0
                                                             error:&error];
        
        if (!jsonData) {
            NSLog(@"JSON error: %@", error);
        } else {
            
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
}
-(IBAction)CheckStatus:(id)sender{
    [self.childTextField resignFirstResponder];
    // Create the request.
    NSString *urlString = [NSString stringWithFormat:@"http://protected-wildwood-8664.herokuapp.com/users/%@.json", self.childTextField.text];
    NSMutableURLRequest *statusrequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
    
    // Set request method
    [statusrequest setHTTPMethod:@"GET"];
    
    // Create url connection and fire request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:statusrequest delegate:self];
    
    if (connection) {
        self.responseData = [[NSMutableData alloc] init];
    }else{
        NSLog(@"No Connection!");
    }
}

#pragma mark - NSURLConnection Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    NSLog(@"Receiving data...");
    if ([[[connection currentRequest]HTTPMethod] isEqual: @"GET"])
        [self.responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    NSLog(@"Done! %@", [[connection currentRequest]HTTPMethod]);
    
    // Check if the current connection using a GET request. If not, it's using the POST method
    if ([[[connection currentRequest]HTTPMethod] isEqual: @"GET"]) {
        NSError *dicterror = nil;
        NSDictionary *myDictionary = [NSJSONSerialization JSONObjectWithData:self.responseData
                                                                     options:NSJSONReadingAllowFragments
                                                                       error:&dicterror];
        if(!myDictionary) {
            NSLog(@"JSON error  for %@: %@", self.childTextField.text, [dicterror userInfo]);
        }
        else {
            //Do Something
            if ([myDictionary objectForKey:@"error"]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"There is an error somewhere. Try again later." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                [alertView show];
            }
            NSLog(@"JSON OUTPUT: %@",myDictionary);
            
            self.childName.text = [myDictionary objectForKey:@"username"];
            
            NSInteger isinZone = [[myDictionary objectForKey:@"is_in_zone"]integerValue];
            
            self.childStatus.alpha = 1;
            if (isinZone == 0) {
                self.childStatus.textColor = [UIColor colorWithRed:204.0/255.0 green:51.0/255.0
                                                              blue:0.0/255.0  alpha:1];
                self.childStatus.text = @"NO";
            }else{
                self.childStatus.textColor = [UIColor colorWithRed:0.0/255.0 green:204.0/255.0
                                                              blue:127.0/255.0  alpha:1];
                self.childStatus.text = @"YES";
            }
            
        }
    }// end getURLCheck
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
        NSLog(@"Body Data Sent....!");
    }
}


#pragma mark - Prep Methods
-(void)startStandardUpdates{
    
    if (self.locationManager == nil)
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
#pragma mark  Core Location Delegate Methods
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *newLocation = [locations lastObject];
    CLLocation *oldLocation;
    
    if (locations.count > 1) {
        oldLocation = [locations objectAtIndex:locations.count - 2];
    }else{
        oldLocation = nil;
    }

    NSDate *eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    
    if (fabs(howRecent) < 5.0) {
        // Do stuff
        self.userLatitude.text = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
        self.userLongitude.text = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
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

// pragma mark is used for easy access of code in Xcode
#pragma mark - TextField Delegates

// This method is called once we click inside the textField
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"Text field did begin editing");
}

// This method is called once we complete editing
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"Text field ended editing");
}

// This method enables or disables the processing of return key
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
