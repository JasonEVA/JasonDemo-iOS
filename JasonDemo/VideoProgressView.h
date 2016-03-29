//
//  VideoProgressView.h
//  Reshape
//
//  Created by jasonwang on 15/11/27.
//  Copyright © 2015年 jasonwang. All rights reserved.
//  视频进度条

#import <UIKit/UIKit.h>

@protocol VideoProgressViewDelegate <NSObject>

// 声音改变
- (void)videoProgressViewDelegateCallBack_videoPercentage:(CGFloat)videoPercentage;
@end
@interface VideoProgressView : UIView

@property (nonatomic, weak)  id<VideoProgressViewDelegate>  delegate; // <##>

// 设置当前进度
- (void)setVideoCurrentTime:(CGFloat)currentTime totalTime:(CGFloat)totalTime;
- (void)setVideoCachedTime:(CGFloat)cachedTime totalTime:(CGFloat)totalTime;
- (void)switchVideoProgressForword:(BOOL)forword;
//重播
- (void)reStartProgressTotalTime:(CGFloat)totalTime;
@end
