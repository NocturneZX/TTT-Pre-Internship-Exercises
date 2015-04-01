//
//  NSString+Helpers.m
//  MapView
//
//  Created by Julio Reyes  on 3/25/15.
//  Copyright (c) 2015 Julio Reyes?. All rights reserved.
//

#import "NSString+Helpers.h"

@implementation NSString (Helpers)
+(NSString *)queryStringWithParameters:(NSDictionary *)params{
    if (!params || !([[params allKeys] count]))
        return @"";
    
    NSMutableString *queryString = [NSMutableString string];
    
    __block BOOL beginning = YES;
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop){
        if(beginning)
            [queryString appendFormat:@"%@=%@", key, obj];
        else
            [queryString appendFormat:@"&%@=%@", key, obj];
        
        beginning = NO;
    }];
    
    return queryString;
    
}
@end
