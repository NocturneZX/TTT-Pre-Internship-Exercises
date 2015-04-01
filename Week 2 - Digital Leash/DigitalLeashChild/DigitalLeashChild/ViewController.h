//
//  ViewController.h
//  DigitalLeashChild
//
//  Created by Julio Reyes on 2/25/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

#import <UIKit/UIKit.h>
@import CoreLocation;

@interface ViewController : UIViewController <CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}


@property (nonatomic) CLLocationManager *locationManager;

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;

@end

