//
//  YelpBusiness.h
//  MapView
//
//  Created by Julio Reyes  on 3/30/15.
//  Copyright (c) 2015 Julio Reyes?. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YelpBusiness : NSObject

@property (nonatomic, strong) NSString *businessID;
@property (nonatomic, strong) NSString *businessName;
@property (nonatomic, strong) NSString *businessURL;

@property (nonatomic, strong) NSString *businessImageURL;

@property (nonatomic, assign) int businessRating;
@property (nonatomic, strong) NSString *businessRatingImageURL;

@property (nonatomic, strong) NSString *businessAddress;
@property (nonatomic, strong) NSString *businessCrossStreets;
@property (nonatomic, assign) double businessLatitude;
@property (nonatomic, assign) double businessLongitude;

- (instancetype)initWithBusinessDictionary:(NSDictionary *) businessDict;

@end
