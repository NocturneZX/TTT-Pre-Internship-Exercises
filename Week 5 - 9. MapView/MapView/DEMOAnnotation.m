//
//  DEMOAnnotation.m
//  MapView
//
//  Created by Julio Reyes  on 3/24/15.
//  Copyright (c) 2015 Julio Reyes?. All rights reserved.
//

#import "DEMOAnnotation.h"

@implementation DEMOAnnotation

-(id)initWithLocation:(CLLocationCoordinate2D)coord
                title:(NSString *)annotationTitle
             subtitle:(NSString *)annotationSubtitle
{
    if (self = [super init]) {
        self.coordinate = coord;
        self.title = annotationTitle;
        self.subtitle = annotationSubtitle;
    }
    
    return self;
}
@end
