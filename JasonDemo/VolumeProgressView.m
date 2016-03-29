//
//  VolumeProgressView.m
//  Reshape
//
//  Created by jasonwang on 15/11/27.
//  Copyright © 2015年 jasonwang. All rights reserved.
//

#import "VolumeProgressView.h"
#import <Masonry/Masonry.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
typedef enum : NSUInteger {
    tag_volumeUp,
    tag_volumeDown
} VolumeUpDownTag;

static NSString *const kSliderValueKey = @"value";
@interface VolumeProgressView()
@property (nonatomic, strong)  UIButton  *volumeUp; //
@property (nonatomic, strong)  UIButton  *volumeDown; //
@property (nonatomic, strong)  UISlider  *sliderView; // <##>
@property (nonatomic, strong)  UISlider  *sliderFake; // slider傀儡，存储MPVolumeView

@property (nonatomic, strong)  MPVolumeView  *volumeView; // <##>

@end
@implementation VolumeProgressView

- (instancetype)initWithVolumePercentage:(CGFloat)volumePercentage
{
    self = [super init];
    if (self) {
        NSLog(@"-------------->%f",self.sliderFake.value);
        [self.sliderView setValue:volumePercentage];

        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self configElements];
        // 监听系统音量按钮变化
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(systemVolumeButtonClicked:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    }
    return self;
}

- (void)configConstraints {
    [self.volumeUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-5);
        make.centerY.equalTo(self);
    }];
    [self.volumeDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.centerY.equalTo(self);
    }];
    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.volumeUp.mas_left).offset(-5);
        make.left.equalTo(self.volumeDown.mas_right).offset(5);
        make.centerY.equalTo(self);
        make.height.equalTo(@10);
    }];
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - Interface Method

- (void)switchVolumeProgressUp:(BOOL)up {
    CGFloat temp = 0;
    if (up) {
        temp = 0.02;
    } else {
        temp = -0.02;
    }
    [self.sliderView setValue:self.sliderView.value + temp animated:YES];
    [self volumeChanged];

}

- (void)configVolume {
    NSLog(@"-------------->%f",self.sliderFake.value);
    [self.sliderView setValue:self.sliderFake.value];
}
#pragma mark - Private Method

// 设置元素控件
- (void)configElements {

    [self addSubview:self.volumeDown];
    [self addSubview:self.volumeUp];
    [self addSubview:self.sliderView];
    [self addSubview:self.volumeView];
    [self configConstraints];
}

#pragma mark - Event Response
- (void)systemVolumeButtonClicked:(NSNotificationCenter *)noti {
    self.sliderView.value = self.sliderFake.value;
}

// 声音按钮点击
- (void)volumeButtonClicked:(UIButton *)sender {
    switch (sender.tag) {
        case tag_volumeUp:
            // 提高音量
            [self.sliderView setValue:self.sliderView.value + 0.1 animated:YES];
            break;
            
        case tag_volumeDown:
            // 降低音量
            [self.sliderView setValue:self.sliderView.value - 0.1 animated:YES];
            break;

        default:
            break;
    }
    [self volumeChanged];
}

// 声音进度改变
- (void)volumeChanged {

    NSLog(@"-------------->valueChanged:%f",self.sliderView.value);
    self.sliderFake.value = self.sliderView.value;

    if ([self.delegate respondsToSelector:@selector(volumeProgressViewDelegateCallBack_volumePercentage:)]) {
        [self.delegate volumeProgressViewDelegateCallBack_volumePercentage:self.sliderView.value];
    }
    
}


#pragma mark - Delegate

#pragma mark - Init

- (UIButton *)volumeDown {
    if (!_volumeDown) {
        _volumeDown = [UIButton buttonWithType:UIButtonTypeCustom];
        [_volumeDown setImage:[UIImage imageNamed:@"player_soundDown"] forState:UIControlStateNormal];
        [_volumeDown setTag:tag_volumeDown];
        [_volumeDown addTarget:self action:@selector(volumeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_volumeDown setTransform:CGAffineTransformMakeRotation(M_PI_2)];
        [_volumeDown sendActionsForControlEvents:UIControlEventAllEditingEvents];
    }
    return _volumeDown;
}

- (UIButton *)volumeUp {
    if (!_volumeUp) {
        _volumeUp = [UIButton buttonWithType:UIButtonTypeCustom];
        [_volumeUp setImage:[UIImage imageNamed:@"player_soundUp"] forState:UIControlStateNormal];
        [_volumeUp setTag:tag_volumeUp];
        [_volumeUp addTarget:self action:@selector(volumeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_volumeUp setTransform:CGAffineTransformMakeRotation(M_PI_2)];
        
    }
    return _volumeUp;
}

- (UISlider *)sliderView {
    if (!_sliderView) {
        _sliderView = [[UISlider alloc] init];
        [_sliderView setThumbImage:[UIImage imageNamed:@"player_progressThum"] forState:UIControlStateNormal];
        [_sliderView setMinimumTrackTintColor:[UIColor whiteColor]];
        [_sliderView setMaximumTrackTintColor:[UIColor colorWithWhite:1 alpha:0.5]];
        [_sliderView addTarget:self action:@selector(volumeChanged) forControlEvents:UIControlEventValueChanged];
        [_sliderView setMaximumValue:1.0];
        [_sliderView setMinimumValue:0.0];
        [_sliderView setContinuous:NO];
    }
    return _sliderView;
}

- (MPVolumeView *)volumeView {
    if (!_volumeDown) {
        _volumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(-100, -100, 0, 0)];
        [_volumeView setHidden:YES];
    }
    return _volumeView;
}

- (UISlider *)sliderFake {
    if (!_sliderFake) {
        for (UIView *view in [self.volumeView subviews]){
            NSLog(@"-------------->%@",NSStringFromClass(view.class));
            if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
                _sliderFake = (UISlider *)view;
            }
        }

    }
    return _sliderFake;
}
@end
