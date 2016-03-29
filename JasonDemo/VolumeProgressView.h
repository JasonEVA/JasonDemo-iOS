//
//  VolumeProgressView.h
//  Reshape
//
//  Created by jasonwang on 15/11/27.
//  Copyright © 2015年 jasonwang. All rights reserved.
//  音量进度view

#import <UIKit/UIKit.h>

@protocol VolumeProgressViewDelegate <NSObject>

// 声音改变
- (void)volumeProgressViewDelegateCallBack_volumePercentage:(CGFloat)volumePercentage;
@end
@interface VolumeProgressView : UIView

@property (nonatomic, weak)  id<VolumeProgressViewDelegate>  delegate; // <##>

- (instancetype)initWithVolumePercentage:(CGFloat)volumePercentage;

- (void)switchVolumeProgressUp:(BOOL)up;

- (void)configVolume;
@end
