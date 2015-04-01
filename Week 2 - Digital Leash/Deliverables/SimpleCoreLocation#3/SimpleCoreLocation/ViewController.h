//
//  ViewController.h
//  SimpleCoreLocation
//
//  Created by Julio Reyes on 2/24/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;

@interface ViewController : UIViewController <CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}


@property (nonatomic, retain) CLLocationManager *locationManager;

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;

@end

