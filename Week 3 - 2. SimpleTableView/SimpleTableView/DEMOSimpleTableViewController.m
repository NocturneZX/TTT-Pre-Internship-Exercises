//
//  DEMOSimpleTableViewController.m
//  SimpleTableView
//
//  Created by Julio Reyes on 20/10/13.
//  Copyright (c) 2013 Julio Reyes. All rights reserved.
//

#import "DEMOSimpleTableViewController.h"

@implementation DEMOSimpleTableViewController


-(id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    items = [[NSMutableArray alloc] init];
    for(int i=0;i< 100; i++){
        NSString *data = [[NSString alloc] initWithFormat:@"Row: %d",i+1];
        [items addObject:data];
    }
    
    return self;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([items count] > 9) {
        return 10;
    }else{
        return [items count];
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if(!cell){
        cell =
        [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    [[cell textLabel] setText: [items objectAtIndex:[indexPath row]]];
    [[cell imageView] setImage: [UIImage imageNamed:@"playstation.png"]];
    return cell;
}

@end
