//
//  PlayerViewController.h
//  GetViddy
//
//  Created by Julio Reyes on 4/28/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Video.h"
#import "PlayerView.h"

@interface PlayerViewController : UIViewController
@property (nonatomic, weak) IBOutlet UIButton *playButton;
@property (nonatomic, strong) Video *video;

- (IBAction)PlayVideo:(id)sender;
- (void)UpdateUserInterface;

@end
