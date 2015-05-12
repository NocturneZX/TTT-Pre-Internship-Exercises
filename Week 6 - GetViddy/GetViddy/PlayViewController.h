//
//  PlayViewController.h
//  GetViddy
//
//  Created by Julio Reyes on 4/28/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import <AVKit/AVKit.h>
#import "Video.h"

@import AVKit;
@import AVFoundation;

@interface PlayViewController : AVPlayerViewController
@property (nonatomic, strong) Video *selectedVideo;
@end
