//
//  YelpBusiness.m
//  MapView
//
//  Created by Julio Reyes  on 3/30/15.
//  Copyright (c) 2015 Julio Reyes?. All rights reserved.
//

#import "YelpBusiness.h"

@implementation YelpBusiness

- (instancetype)initWithBusinessDictionary:(NSDictionary *) businessDict
{
    self = [super init];
    if (self) {
        self.businessID = businessDict[@"id"];
        self.businessName = businessDict[@"name"];
        self.businessURL = businessDict[@"url"];
        self.businessImageURL = businessDict[@"image_url"];
        self.businessRating = [businessDict[@"rating"] intValue];
        self.businessRatingImageURL = businessDict[@"rating_img_url"];
        
        NSArray *address = [businessDict valueForKeyPath:@"location.display_address"];
        self.businessAddress = [NSString stringWithFormat:@"%@, %@, %@", address[0], address[1], address[2]];
        self.businessCrossStreets = [businessDict valueForKeyPath:@"location.cross_streets"];

        self.businessLatitude = [[businessDict valueForKeyPath:@"location.coordinate.latitude"]doubleValue];
        self.businessLongitude = [[businessDict valueForKeyPath:@"location.coordinate.longitude"]doubleValue];
        
    }
    return self;
}

@end
