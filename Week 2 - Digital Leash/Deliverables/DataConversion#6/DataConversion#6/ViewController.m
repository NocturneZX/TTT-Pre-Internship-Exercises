//
//  ViewController.m
//  DataConversion#6
//
//  Created by Julio Reyes on 2/24/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *radius;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.userID = @"Julio";
    self.latitude = @"40.848092";
    self.longitude = @"-73.933278";
    self.radius = @"10";

    // Declare the NSDictionary
    NSDictionary *userDetails = @{@"utf8": @"✓", @"authenticity_token":@"EvZva3cKnzo3Y0G5R3NktucCr99o/2UWOPVAmJYdBOc=", @"user":@{@"username":self.userID,@"latitude":self.latitude,@"longitude ":self.longitude,@"radius":self.radius}, @"commit":@"CreateUser", @"action":@"update", @"controller":@"users"};
    
    // Create the NSData which will hold the
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userDetails
                                                       options:0
                                                         error:&error];
    
    if (!jsonData) {
        NSLog(@"JSON error: %@", error);
    } else {
        
        NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        NSLog(@"JSON OUTPUT FROM NSDictionary: %@\n\n",JSONString);
    }
    
    NSError *dicterror = nil;
    NSDictionary *myDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&dicterror];
    
    if(!myDictionary) {
        NSLog(@"JSON error: %@", dicterror);
    }
    else {
        //Do Something
        NSLog(@"JSON OUTPUT TO NSDictionary: %@",myDictionary);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
