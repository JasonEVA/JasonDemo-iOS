//
//  VideoProgressView.m
//  Reshape
//
//  Created by jasonwang on 15/11/27.
//  Copyright © 2015年 jasonwang. All rights reserved.
//

#import "VideoProgressView.h"
#import <Masonry/Masonry.h>
#import "UILabel+EX.h"
#import "DateUtil.h"
#import "UIFont+EX.h"

static NSString *const kDateFormat = @"mm:ss";
@interface VideoProgressView()
@property (nonatomic, strong)  UILabel  *currentTime; // 当前播放时间
@property (nonatomic, strong)  UILabel  *totalTime; // 总时间
@property (nonatomic, strong)  UISlider  *sliderView; // <##>
@property (nonatomic, strong)  UIProgressView  *cacheProgressView; // <##>
@end
@implementation VideoProgressView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self configElements];
        self.currentTime.JWName = @"用runtime在Category中添加了属性";
        NSLog(@"%@",self.currentTime.JWName);
    }
    return self;
}

- (void)configConstraints {
    [self.currentTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(50);
    }];
    [self.totalTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(self);
    }];
    [self.cacheProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.currentTime.mas_right).offset(10);
        make.right.equalTo(self.totalTime.mas_left).offset(-20);
        make.centerY.equalTo(self);
        make.height.equalTo(@2);
    }];

    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerY.equalTo(self.cacheProgressView);
        make.height.equalTo(self);
    }];
}
#pragma mark - Interface Method

- (void)setVideoCurrentTime:(CGFloat)currentTime totalTime:(CGFloat)totalTime {
    // 当前时间
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:currentTime];
    NSString *strCurrentTime = [DateUtil stringDateWithDate:currentDate dateFormat:kDateFormat];
    
    // 总时间
    NSDate *totalDate = [NSDate dateWithTimeIntervalSince1970:totalTime];
    NSString *strTotalTime = [DateUtil stringDateWithDate:totalDate dateFormat:kDateFormat];
    // 进度
    CGFloat progress = currentTime / totalTime;

//    NSLog(@"-------------->当前时间%f，总时间%f",currentTime,totalTime);
    [self.currentTime setText:strCurrentTime];
    [self.totalTime setText:strTotalTime];
    if (progress > self.sliderView.value) {
        [self.sliderView setValue:progress animated:YES];

    }
}

- (void)setVideoCachedTime:(CGFloat)cachedTime totalTime:(CGFloat)totalTime {
    CGFloat progress = cachedTime / totalTime;

    self.cacheProgressView.progress = progress;
}

- (void)switchVideoProgressForword:(BOOL)forword {
    CGFloat increment = 0.01;
    if (forword) {
        increment = 0.01;
    } else {
        increment = -0.01;
    }
    self.sliderView.value += increment;
    [self videoProgressDraged];
}

- (void)reStartProgressTotalTime:(CGFloat)totalTime
{
    [self.sliderView setValue:0 animated:YES];
    self.cacheProgressView.progress = 0;
    // 当前时间
    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:0];
    NSString *strCurrentTime = [DateUtil stringDateWithDate:currentDate dateFormat:kDateFormat];
    // 总时间
    NSDate *totalDate = [NSDate dateWithTimeIntervalSince1970:totalTime];
    NSString *strTotalTime = [DateUtil stringDateWithDate:totalDate dateFormat:kDateFormat];
    [self.currentTime setText:strCurrentTime];
    [self.totalTime setText:strTotalTime];
}

#pragma mark - Private Method

// 设置元素控件
- (void)configElements {
    [self addSubview:self.currentTime];
    [self addSubview:self.totalTime];
    [self addSubview:self.cacheProgressView];
    [self addSubview:self.sliderView];
    
    [self configConstraints];
}

#pragma mark - Event Response

- (void)videoProgressDraged {
    NSLog(@"-------------->videoValueChanged:%f",self.sliderView.value);
    if ([self.delegate respondsToSelector:@selector(videoProgressViewDelegateCallBack_videoPercentage:)]) {
        [self.delegate videoProgressViewDelegateCallBack_videoPercentage:self.sliderView.value];
    }
}

#pragma mark - Delegate

#pragma mark - Init

- (UILabel *)currentTime {
    if (!_currentTime) {
        _currentTime = [UILabel setLabel:_currentTime text:@"00:00" font:[UIFont themeFontOfSize:15] textColor:[UIColor whiteColor]];
        [_currentTime setTextAlignment:NSTextAlignmentCenter];
    }
    return _currentTime;
}

- (UILabel *)totalTime {
    if (!_totalTime) {
        _totalTime = [UILabel setLabel:_totalTime text:@"00:00" font:[UIFont themeFontOfSize:15] textColor:[UIColor whiteColor]];
        [_totalTime setTextAlignment:NSTextAlignmentCenter];

    }
    return _totalTime;
}

- (UISlider *)sliderView {
    if (!_sliderView) {
        _sliderView = [[UISlider alloc] init];
        [_sliderView setThumbImage:[UIImage imageNamed:@"player_progressThum"] forState:UIControlStateNormal];
        [_sliderView setMinimumTrackTintColor:[UIColor whiteColor]];
        [_sliderView setMaximumTrackTintColor:[UIColor clearColor]];
        [_sliderView addTarget:self action:@selector(videoProgressDraged) forControlEvents:UIControlEventTouchUpInside];
        [_sliderView setMaximumValue:1.0];
        [_sliderView setMinimumValue:0.0];
    }
    return _sliderView;
}

- (UIProgressView *)cacheProgressView {
    if (!_cacheProgressView) {
        _cacheProgressView = [[UIProgressView alloc] init];
        [_cacheProgressView setTrackTintColor:[UIColor colorWithWhite:1.0 alpha:0.3]];
        [_cacheProgressView setProgressTintColor:[UIColor colorWithWhite:1 alpha:0.8]];

    }
    return _cacheProgressView;
}
@end
