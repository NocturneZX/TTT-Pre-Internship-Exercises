//
//  YelpAPIRequest.h
//  MapView
//
//  Created by Julio Reyes  on 3/25/15.
//  Copyright (c) 2015 Julio Reyes?. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface YelpAPIRequest : NSObject
// Singleton
+(instancetype)sharedInstance;

// Current Location
@property (nonatomic, assign) CLLocation *searchCurrentLocation;

- (void) getArrayOfRestaurantsFromTerm:(NSString *)term location:(NSString *)location cll:(NSString *)coord completionHandler:(void (^)(NSDictionary *restaurantJSON, NSError *error)) completionHandler;

@end
