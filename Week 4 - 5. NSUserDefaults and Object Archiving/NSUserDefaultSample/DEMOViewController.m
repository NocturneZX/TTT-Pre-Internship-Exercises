//
//  DEMOViewController.m
//  NSUserDefaultSample
//
//  Created by Julio Reyes on 19/12/13.
//  Copyright (c) 2013 Julio Reyes. All rights reserved.
//

#import "DEMOViewController.h"
#import "Employee.h"

@interface DEMOViewController ()

@end

@implementation DEMOViewController

-(IBAction)saveData
{
    // Saving custom object data to NSUserDefaults
    Employee *employee = [[Employee alloc]
                          initWithName:[[self textFieldName] text]
                          address:[[self textFieldAddress] text]
                          phone:[[self textFieldPhone] text]];
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:employee];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:@"NSUDS-SAVE-DATA"];
    [defaults synchronize];
    NSLog(@"Data Saved");
    [self clearData];
}

-(IBAction)readData
{
    // Fetching saved custom object data from NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:@"NSUDS-SAVE-DATA"];
    Employee *employee = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    [[self textFieldName] setText:[employee name]];
    [[self textFieldAddress] setText:[employee address]];
    [[self textFieldPhone] setText:[employee phone]];
    NSLog(@"Data Fetched");
}

-(IBAction)clearData
{
    // Clearing UI text fields
    [[self textFieldName] setText:nil];
    [[self textFieldAddress] setText:nil];
    [[self textFieldPhone] setText:nil];
    NSLog(@"Text Fields Cleared");
}

@end
