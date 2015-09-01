//
//  DEMOViewController.m
//  MapView
//
//  Created by Julio Reyes on 13/11/13.
//  Copyright (c) 2013 Julio Reyes. All rights reserved.
//

#import "DEMOViewController.h"
#import "DEMOAnnotation.h"
#import "YelpAPIRequest.h"
#import "YelpBusiness.h"

@interface DEMOViewController ()
@property(nonatomic, weak) IBOutlet MKMapView *mapView;
@property(nonatomic, weak) IBOutlet UISearchBar *mapSearchBar;
@property(nonatomic, weak) IBOutlet UIToolbar *mapToolBar;

@end

@implementation DEMOViewController

@synthesize mapView;
@synthesize mapSearchBar;
@synthesize mapToolBar;

static NSString *annoIdentifier = @"DEMOAnnotation";


static NSString *defaultTerm = @"restaurants";
static NSString *defaultLocation = @"Flatiron";

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    //5
    


    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.mapView.delegate = self;
    self.mapSearchBar.delegate = self;
    self.mapToolBar.delegate = self;
    
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    mapView.showsUserLocation = YES;
    
    self.dinersData = [[NSMutableArray alloc]init];
    
    [self.mapToolBar setFrame:CGRectMake(self.mapToolBar.frame.origin.x,
                                         self.mapToolBar.frame.origin.y - 200,
                                         self.mapToolBar.frame.size.width,
                                         self.mapToolBar.frame.size.height)];
    [self startStandardUpdates];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    
    // Set a movement threshold for new events
    self.locationManager.distanceFilter = 500; //meters
    [self.locationManager startUpdatingLocation];
    
}
-(void)findAllRestaurants{
    //Get the term and location from the command line if there were any, otherwise assign default values.
    NSString *term = [[NSUserDefaults standardUserDefaults] valueForKey:@"term"] ?: defaultTerm;
    NSString *location = [[NSUserDefaults standardUserDefaults] valueForKey:@"location"] ?: defaultLocation;
    
    NSString *coordinates = [NSString stringWithFormat:@"%f, %f", self.locationManager.location.coordinate.latitude,
                             self.locationManager.location.coordinate.longitude];
    
    dispatch_group_t requestGroup = dispatch_group_create();
    
    YelpAPIRequest *APIRequest = [YelpAPIRequest sharedInstance];
    
    dispatch_group_enter(requestGroup);

    [APIRequest getArrayOfRestaurantsFromTerm:term location:location cll:coordinates
                            completionHandler:^(NSDictionary *businesslistJSON, NSError *error){
        
        if (error) {
            NSLog(@"An error happened during the request: %@", error);
        } else if (businesslistJSON) {
            NSArray *businessArray = businesslistJSON[@"businesses"];
            [businessArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
                YelpBusiness *currentBusiness = [[YelpBusiness alloc]initWithBusinessDictionary:obj];
                [self.dinersData addObject:currentBusiness];
                
            }];

            [self.dinersData enumerateObjectsUsingBlock:^(YelpBusiness *place, NSUInteger idx, BOOL *stop){
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(place.businessLatitude, place.businessLongitude);
                NSString *fullAddress = [NSString stringWithFormat:@"%@ between %@",place.businessAddress,place.businessCrossStreets];
                DEMOAnnotation *annotation = [[DEMOAnnotation alloc]initWithLocation:coordinate title:place.businessName subtitle:fullAddress];
                annotation.image_url = place.businessImageURL;
                
                [self.mapView addAnnotation:annotation];
            }];
        } else {
            NSLog(@"No business was found");
        }
        
        dispatch_group_leave(requestGroup);
    }];
    
    dispatch_group_wait(requestGroup, DISPATCH_TIME_FOREVER); // This avoids the program exiting before all our asynchronous callbacks have been made.
    
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
        [self findAllRestaurants];
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

-(IBAction)setMap:(id)sender
{
    switch (((UISegmentedControl *)sender).selectedSegmentIndex) {
        case 0:
            mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            mapView.mapType = MKMapTypeHybrid;
            break;
        case 2:
            mapView.mapType = MKMapTypeSatellite;
            break;
        default:
            break;
    }
}
#pragma mark - Map View Delegation
// mapView:viewForAnnotation: provides the view for each annotation.
// This method may be called for all or some of the added annotations.
// For MapKit provided annotations (eg. MKUserLocation) return nil to use the MapKit provided annotation view.
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        NSLog(@"All systems nominal.");
        return nil;
    }
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:annoIdentifier];

    if ([annotation isKindOfClass:[DEMOAnnotation class]]) {
        
        DEMOAnnotation *customAnnotation = (DEMOAnnotation *)annotation;
        
        if (!annotationView) {
            annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:customAnnotation reuseIdentifier:annoIdentifier];
            annotationView.pinColor = MKPinAnnotationColorGreen;
            annotationView.animatesDrop = YES;
            annotationView.canShowCallout = YES;
        }else{
            annotationView.annotation = annotation;
        }
        
        // Declare and initialize the variable for the thumbnail. Then download image using GCD
        UIImageView *thumbnail = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 48.0f, 48.0f)];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:customAnnotation.image_url]];
            if (imgData) {
                UIImage *image = [UIImage imageWithData:imgData];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [thumbnail setImage:image];
                        
                    });// end dispatch_async(dispatch_get_main_queue())
                }else{
                    [thumbnail setImage:[UIImage imageNamed:@"notifications.png"]];
                }
            }
        });// end dispatch_async(dispatch_get_global_queue())
        
        UIButton *descBtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.rightCalloutAccessoryView = descBtn;
        annotationView.leftCalloutAccessoryView = thumbnail;
        
    }
    
    return annotationView;
}
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    MKAnnotationView *aV;
    
    for (aV in views) {
        
        // Don't pin drop if annotation is user location
        if ([aV.annotation isKindOfClass:[MKUserLocation class]]) {
            continue;
        }
        
        // Check if current annotation is inside visible map rect, else go to next one
        MKMapPoint point =  MKMapPointForCoordinate(aV.annotation.coordinate);
        if (!MKMapRectContainsPoint(self.mapView.visibleMapRect, point)) {
            continue;
        }
        
        CGRect endFrame = aV.frame;
        
        // Move annotation out of view
        aV.frame = CGRectMake(aV.frame.origin.x, aV.frame.origin.y - self.view.frame.size.height, aV.frame.size.width, aV.frame.size.height);
        
        // Animate drop
        [UIView animateWithDuration:1.0 delay:0.04*[views indexOfObject:aV] options: UIViewAnimationOptionCurveLinear animations:^{
            
            aV.frame = endFrame;
            
            // Animate squash
        }completion:^(BOOL finished){
            if (finished) {
                [UIView animateWithDuration:0.05 animations:^{
                    aV.transform = CGAffineTransformMakeScale(1.0, 0.8);
                    
                }completion:^(BOOL finished){
                    if (finished) {
                        [UIView animateWithDuration:0.1 animations:^{
                            aV.transform = CGAffineTransformIdentity;
                        }];
                    }
                }];
            }
        }];
    }
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"Location: %f, %f",
          userLocation.location.coordinate.latitude,
          userLocation.location.coordinate.longitude);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 0.5 * METERS_PER_MILE, 0.5 * METERS_PER_MILE);
    [self.mapView setRegion:region animated:YES];
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    NSLog(@"Something weird happened here. F@&$IN' S4@T SUCKS!! %@", error);
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    DEMOAnnotation *currentAnnotation = (DEMOAnnotation *)view.annotation;
    
    NSLog(@"Title: %@ Subtitle: %@", currentAnnotation.title, currentAnnotation.subtitle);
    
}

#pragma mark - UISearchBar methods

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"You entered searchBarShouldBeginEditing");
    return YES;
}// return NO to not become first responder

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.mapSearchBar.text = @"";
}// called when text starts editing

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    NSLog(@"You entered %@",self.mapSearchBar.text);
    return YES;
}// return NO to not resign first responder

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSLog(@"You entered searchBarTextDidEndEditing");

}// called when text ends editing

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    // Remove annotations and create a new request
    [self.mapSearchBar resignFirstResponder];

    NSArray *annotations = self.mapView.annotations;
    if( annotations.count > 0) {
        [self.mapView removeAnnotations:annotations];
    }
    [self.mapView removeOverlays:self.mapView.overlays];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.mapSearchBar.text forKey:@"term"];
    [self findAllRestaurants];

    
}// called when keyboard search button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.mapSearchBar resignFirstResponder];
}// called when cancel button pressed

@end
