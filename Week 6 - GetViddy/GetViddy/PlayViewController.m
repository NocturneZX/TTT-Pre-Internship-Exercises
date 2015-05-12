//
//  PlayViewController.m
//  GetViddy
//
//  Created by Julio Reyes on 4/28/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import "PlayViewController.h"

@interface PlayViewController ()

@end

@implementation PlayViewController

- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    self.showsPlaybackControls = NO;
    
    AVURLAsset *currentAsset = [AVURLAsset URLAssetWithURL:self.selectedVideo.uniqueURL options:nil];
    if (currentAsset) {
        AVPlayerItem* playerItem = [AVPlayerItem playerItemWithAsset:currentAsset];
        AVPlayer* player = [AVPlayer playerWithPlayerItem:playerItem];
        player.volume = 0.1;
        self.player = player;
        self.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        player.actionAtItemEnd = AVPlayerActionAtItemEndPause;
        
        [[NSNotificationCenter defaultCenter] addObserverForName:AVPlayerItemDidPlayToEndTimeNotification
                                                          object:[player currentItem] queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *notification) {
                                                              
                                                              AVPlayerItem *pItem = [notification object];
                                                              [pItem seekToTime:kCMTimeZero];
                                                              [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [self.player play];
    }
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.player pause];
    [super viewWillDisappear:animated];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (void)playerItemDidReachEndOrClosed:(NSNotification *)notification {
//    [self.navigationController dismissViewControllerAnimated:YES completion:^{
//        self.selectedVideo = nil;
//    }];
//}

@end
