//
//  ViewController.h
//  GetViddy
//
//  Created by Julio Reyes on 5/4/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>

#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController : UIViewController

@property (nonatomic) ALAssetsLibrary *myAssetLibrary;

-(void)getMyVideos;

@end

