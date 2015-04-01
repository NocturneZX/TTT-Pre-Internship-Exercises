//
//  JRDictionary.h
//  CustomHashTable
//
//  Created by Julio Reyes on 2/23/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JRDictionary : NSObject

-(id)findvalueForKey:(NSString *)key;
-(void)setJRDictValue:(id)value forKey:(NSString *)key;
-(void)whoAreYou;

@property (nonatomic, strong) NSMutableArray *values;
@property (nonatomic, strong) NSMutableArray *keys;

@end
