//
//  DEMOAnnotation.h
//  MapView
//
//  Created by Julio Reyes  on 3/24/15.
//  Copyright (c) 2015 Julio Reyes?. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface DEMOAnnotation : NSObject <MKAnnotation>

// Center latitude and longitude of the annotation view.
// The implementation of this property must be KVO compliant.
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

// Title and subtitle for use by selection UI.
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *image_url;

-(id)initWithLocation:(CLLocationCoordinate2D)coord
                title:(NSString *)annotationTitle
             subtitle:(NSString *)annotationSubtitle;

@end
