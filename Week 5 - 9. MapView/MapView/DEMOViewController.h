//
//  DEMOViewController.h
//  MapView
//
//  Created by Julio Reyes on 13/11/13.
//  Copyright (c) 2013 Julio Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface DEMOViewController : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate, UISearchBarDelegate, UIToolbarDelegate>

@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic, strong) NSMutableArray *dinersData;
@property (nonatomic, assign) BOOL searching;

-(IBAction)setMap:(id)sender;

@end
