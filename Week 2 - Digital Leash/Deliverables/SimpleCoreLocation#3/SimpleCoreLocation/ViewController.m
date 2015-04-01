//
//  ViewController.m
//  SimpleCoreLocation
//
//  Created by Julio Reyes on 2/24/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self startStandardUpdates];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
