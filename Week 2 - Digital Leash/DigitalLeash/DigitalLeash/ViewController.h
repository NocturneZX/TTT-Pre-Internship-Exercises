//
//  ViewController.h
//  DigitalLeash
//
//  Created by Julio Reyes on 2/24/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
//@import CoreLocation;

@interface ViewController : UIViewController <CLLocationManagerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;

// Data Objects
@property (nonatomic, strong) NSMutableData *responseData;

@end

