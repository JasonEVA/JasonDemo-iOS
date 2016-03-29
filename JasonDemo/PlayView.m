//
//  PlayView.m
//  JasonDemo
//
//  Created by jasonwang on 16/3/23.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "PlayView.h"

@implementation PlayView

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayer *)player {
    return [(AVPlayerLayer *)[self layer] player];
}

- (void)setPlayer:(AVPlayer *)player {
    [(AVPlayerLayer *)[self layer] setPlayer:player];
    [(AVPlayerLayer *)[self layer] player].usesExternalPlaybackWhileExternalScreenIsActive = YES;
}
@end
