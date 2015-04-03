//
//  BGManager.m
//  FlickrDemoKai
//
//  Created by Julio Reyes on 1/22/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import "BGManager.h"
#import <AVFoundation/AVFoundation.h>

@interface BGManager () <AVAudioPlayerDelegate>

@property (strong, nonatomic) AVAudioSession *audioSession;
@property (strong, nonatomic) AVAudioPlayer *bgPlayer;
@property (nonatomic, assign) BOOL isMusicPlaying;

@end

@implementation BGManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configureAudioSession];
        [self configureAudioPlayer];
    }
    return self;
}

#pragma mark - Private
-(void)dealloc{
    self.bgPlayer = nil;
}
-(BOOL)isMusicPlaying{
    if (_isMusicPlaying) {
        return YES;
    }else{
        return NO;
    }
}

- (void) configureAudioSession {
    
    // Implicit init
    self.audioSession = [AVAudioSession sharedInstance];
    
    // Set category of audio session
    NSError *setCategoryError = nil;
    if ([self.audioSession isOtherAudioPlaying]) { // mix sound effects with music already playing
        [self.audioSession setCategory:AVAudioSessionCategorySoloAmbient error:&setCategoryError];
        self.isMusicPlaying = NO;
    } else {
        [self.audioSession setCategory:AVAudioSessionCategoryAmbient error:&setCategoryError];
    }
    if (setCategoryError) {
        NSLog(@"Error setting category! %ld", (long)[setCategoryError code]);
    }
}

- (void)configureAudioPlayer {
    // Create audio player with background music
    NSString *backgroundMusicPathEin = [[NSBundle mainBundle] pathForResource:@"TheComingStorm" ofType:@"caf"];
   
    NSURL *backgroundMusicURL = [NSURL fileURLWithPath:backgroundMusicPathEin];
    
    self.bgPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:nil];
    self.bgPlayer.delegate = self;
    self.bgPlayer.numberOfLoops = 0;	// Loop once
}

- (void)playMusic {
    if (self.isMusicPlaying || [self.audioSession isOtherAudioPlaying]) {
        return;
    }
    
    // Play background music
    [self.bgPlayer prepareToPlay]; // Gundams Are On Earth
    [self.bgPlayer play]; // Suit up...Again!
    self.isMusicPlaying = YES;
}

- (void)stopMusic {
    if (self.isMusicPlaying || [self.audioSession isOtherAudioPlaying]) {
        [self.bgPlayer stop];
        self.isMusicPlaying = NO;
    }
}

@end
