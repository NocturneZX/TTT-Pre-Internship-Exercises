//
//  PlayerView.m
//  GetViddy
//
//  Created by Julio Reyes on 4/28/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import "PlayerView.h"

@interface PlayerView ()

@end

@implementation PlayerView

+ (Class)layerClass {
    return [AVPlayerLayer class];
}
- (AVPlayer*)player {
    return [(AVPlayerLayer *)[self layer] player];
}
- (void)setPlayer:(AVPlayer *)player {
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}



@end
