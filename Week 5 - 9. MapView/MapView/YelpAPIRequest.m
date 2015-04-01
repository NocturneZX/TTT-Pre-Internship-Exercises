//
//  YelpAPIRequest.m
//  MapView
//
//  Created by Julio Reyes  on 3/25/15.
//  Copyright (c) 2015 Julio Reyes?. All rights reserved.
//

#import "NSURLRequest+OAuth.h"
#import "YelpAPIRequest.h"
#import "NSString+Helpers.h"

#define searchRadius @"804.672"
#define categoryFilter @"diners,delis"

@implementation YelpAPIRequest

static NSString * const kAPIHost         = @"api.yelp.com";
static NSString * const kSearchPath      = @"/v2/search";
static NSString * const kBusinessPath      = @"/v2/business/";
static NSString * const kSearchLimit     = @"10";

// Singleton
+(instancetype)sharedInstance{
    static dispatch_once_t cp_singleton_once_token;
    static YelpAPIRequest *sharedInstance;
    dispatch_once(&cp_singleton_once_token, ^{
        sharedInstance = [[self alloc] trueInit];
    });
    
    
    return sharedInstance;
}
- (id)init
{
    [NSException raise:@"Singleton" format:@"THERE CAN ONLY BE ONE!"];
    return nil;
}

-(id)trueInit{
    return [super init];
}

- (void) getArrayOfRestaurantsFromTerm:(NSString *)term location:(NSString *)location cll:(NSString *)coord completionHandler:(void (^)(NSDictionary *restaurantJSON, NSError *error)) completionHandler
{

    //Make a first request to get the search results with the passed term and location
    NSURLRequest *searchRequest = [self _searchRequestWithTerm:term location:location cll:coord];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSLog(@"%@", searchRequest);
    
    [[session dataTaskWithRequest:searchRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        
        if (!error && httpResponse.statusCode == 200) {
            
            NSDictionary *searchResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSArray *businessArray = searchResponseJSON[@"businesses"];
            
            if ([businessArray count] > 0) {
                completionHandler(searchResponseJSON, error);
            } else {
                completionHandler(nil, error); // No business was found
            }
        } else {
            completionHandler(nil, error); // An error happened or the HTTP response is not a 200 OK
        }
    }]resume];
    
}

- (void)queryBusinessInfoForBusinessId:(NSString *)businessID completionHandler:(void (^)(NSDictionary *topBusinessJSON, NSError *error))completionHandler {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *businessInfoRequest = [self _businessInfoRequestForID:businessID];
     NSURLSessionTask *YelpBusinessTask = [session dataTaskWithRequest:businessInfoRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (!error && httpResponse.statusCode == 200) {
            NSDictionary *businessResponseJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            completionHandler(businessResponseJSON, error);
        } else {
            completionHandler(nil, error);
        }
    }];
    
    [YelpBusinessTask resume];
    
}

#pragma mark - API Request Builders

/**
 Builds a request to hit the search endpoint with the given parameters.
 
 @param term The term of the search, e.g: dinner
 @param location The location request, e.g: San Francisco, CA
 
 @return The NSURLRequest needed to perform the search
 */
- (NSURLRequest *)_searchRequestWithTerm:(NSString *)term location:(NSString *)location cll:(NSString *)coord {
    NSDictionary *params = @{
                             @"term": term,
                             @"location": location,
                             @"cll": coord,
                             @"radius_filter": searchRadius,
                             @"limit": kSearchLimit,
                             @"category_filter": categoryFilter,
                             };
    
    return [NSURLRequest requestWithHost:kAPIHost path:kSearchPath params:params];
}

/**
 Builds a request to hit the business endpoint with the given business ID.
 
 @param businessID The id of the business for which we request informations
 
 @return The NSURLRequest needed to query the business info
 */
- (NSURLRequest *)_businessInfoRequestForID:(NSString *)businessID {
    
    NSString *businessPath = [NSString stringWithFormat:@"%@%@", kBusinessPath, businessID];
    return [NSURLRequest requestWithHost:kAPIHost path:businessPath];
}
@end
