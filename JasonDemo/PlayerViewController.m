//
//  PlayerViewController.m
//  JasonDemo
//
//  Created by jasonwang on 16/3/23.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "PlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Masonry/Masonry.h>
#import "PlayView.h"
#import "VideoProgressView.h"
#import "VolumeProgressView.h"
#import "BreakpointResumeRequest.h"

static NSString *const onlineVideoURL = @"https://dn-0soq8gy1.qbox.me/8da100ae05bb988a.mp4";
static NSString *const videoName = @"video.mp4";

@interface PlayerViewController ()<VideoProgressViewDelegate,VolumeProgressViewDelegate,BreakpointResumeRequestDelegate>

@property (nonatomic,strong) AVPlayer *player;//播放器对象

@property (nonatomic,strong) PlayView *container; //播放器容器
@property (nonatomic,strong) UIButton *playOrPause; //播放/暂停按钮
@property (nonatomic,strong) VideoProgressView *progress;//播放进度
@property (nonatomic,strong) VolumeProgressView *volumeProgress; // 音量
@property (nonatomic, strong) UISegmentedControl *segment;

@property (nonatomic)  CMTime currentTime; // 当前时间
@property (nonatomic)  CGFloat videoLength; // 总时间

@end

@implementation PlayerViewController

#pragma mark - 控制器视图方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [self setupUI];
    [self addNotification];
    [self.player play];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeObserverFromPlayerItem:self.player.currentItem];
    [self removeNotification];

}

-(void)dealloc{
}

#pragma mark - 私有方法
-(void)setupUI{
    
    [self.view addSubview:self.container];
    [self.view addSubview:self.playOrPause];
    [self.view addSubview:self.progress];
    [self.container addSubview:self.volumeProgress];
    [self.view addSubview:self.segment];
    
    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(144);
        make.height.mas_equalTo(300);
    }];
    
    [self.playOrPause mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.container).offset(20);
        make.top.equalTo(self.container.mas_bottom);
    }];
    
    [self.progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.playOrPause);
        make.left.equalTo(self.playOrPause.mas_right);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(55);
    }];
    
    [self.volumeProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.container);
        make.right.equalTo(self.container).offset(60);
        make.width.mas_equalTo(180);
        make.height.mas_equalTo(200);
    }];
    
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.container.mas_top).offset(-10);
        make.centerX.equalTo(self.container);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(150);
    }];
}

- (void)playOrPauseClick
{
    NSString *titel;
    if(self.player.rate==0){ //说明时暂停
        titel = @"暂停";
        [self.player play];
    }else if(self.player.rate==1){//正在播放
        [self.player pause];
        titel = @"开始";
    }
    [self.playOrPause setTitle:titel forState:UIControlStateNormal];

}

// 手指拖动事件
- (void)panGestureEventResponse:(UIPanGestureRecognizer *)gesture {
    CGPoint locationPoint = [gesture locationInView:self.view]; // 点击的位置
    CGPoint translatedPoint = [gesture translationInView:self.container];
    if (locationPoint.x < gesture.view.center.x) {
        // 亮度调节
        [self configBrightnessUp:translatedPoint.y < 0 ? YES : NO];
    } else {
        [self.volumeProgress setAlpha:1];
        [self.volumeProgress switchVolumeProgressUp:translatedPoint.y < 0 ? YES : NO];
        [self performSelector:@selector(hideVolumPregress) withObject:nil afterDelay:2];
    }
}

- (void)hideVolumPregress
{
    [UIView animateWithDuration:1.0f animations:^{
        self.volumeProgress.alpha = 0;
    }];
}

// 亮度调节
- (void)configBrightnessUp:(BOOL)up {
    if (up) {
        [UIScreen mainScreen].brightness += 0.01;
    } else {
        [UIScreen mainScreen].brightness -= 0.01;
    }
}

-(void)segmentAction:(UISegmentedControl *)Seg{
    [self removeNotification];
    [self removeObserverFromPlayerItem:self.player.currentItem];
    AVPlayerItem *playerItem=[self getPlayItem:!Seg.selectedSegmentIndex];
    [self addObserverToPlayerItem:playerItem];
    //切换视频
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    [self addNotification];
    [self.progress reStartProgressTotalTime:self.videoLength];
}

//视频缓存
- (void)downloadVideo
{
    BreakpointResumeRequest *request = [[BreakpointResumeRequest alloc] init];
//    [request requestOperationDownloadFileDataWithDelegate:self URL:onlineVideoURL savePath:[self getAllPathWithRelativePath:videoName]];
}

/** 拼接沙盒全路径 拼接Documents以后的相对路径
 */
- (NSString *)getAllPathWithRelativePath:(NSString *)relativePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *strResult =  [paths objectAtIndex:0];
    strResult = [strResult stringByAppendingPathComponent:relativePath];
    
    return strResult;
}

/**
 *  截取指定时间的视频缩略图
 *
 *  @param timeBySecond 时间点
 */

/**
 *  初始化播放器
 *
 *  @return 播放器对象
 */
-(AVPlayer *)player{
    if (!_player) {
        AVPlayerItem *playerItem=[self getPlayItem:YES];
        _player=[AVPlayer playerWithPlayerItem:playerItem];
        [self addProgressObserver];
        [self addObserverToPlayerItem:playerItem];
    }
    return _player;
}

- (PlayView *)container{
    if (!_container) {
        _container = [[PlayView alloc]init];
        [_container setPlayer:self.player];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playOrPauseClick)];
        [_container addGestureRecognizer:tap];
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureEventResponse:)];
        [_container addGestureRecognizer:panGesture];
        [tap requireGestureRecognizerToFail:panGesture];
    }
    return _container;
}

- (UIButton *)playOrPause
{
    if (!_playOrPause) {
        _playOrPause = [[UIButton alloc] init];
        [_playOrPause setTitle:@"暂停" forState:UIControlStateNormal];
        [_playOrPause setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_playOrPause addTarget:self action:@selector(playOrPauseClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playOrPause;
}

- (VideoProgressView *)progress
{
    if (!_progress) {
        _progress = [[VideoProgressView alloc] init];
        [_progress setDelegate:self];
    }
    return _progress;
}

- (VolumeProgressView *)volumeProgress {
    if (!_volumeProgress) {
        _volumeProgress = [[VolumeProgressView alloc] initWithVolumePercentage:0.5];
        [_volumeProgress setTransform:CGAffineTransformMakeRotation(-M_PI_2)];
        [_volumeProgress setDelegate:self];
        [_volumeProgress setAlpha:0];
    }
    return _volumeProgress;
}

- (UISegmentedControl *)segment
{
    if (!_segment) {
        NSArray *titels = @[@"本地",@"在线"];
        _segment = [[UISegmentedControl alloc] initWithItems:titels];
        [_segment setSelectedSegmentIndex:0];
        [_segment setTintColor:[UIColor blueColor]];
        [_segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _segment;
}
/**
 *  根据视频索引取得AVPlayerItem对象
 *
 *  @param videoIndex 视频顺序索引
 *
 *  @return AVPlayerItem对象
 */
-(AVPlayerItem *)getPlayItem:(BOOL)isLocal{
    NSURL *url;
    if (isLocal) {//本地
        //NSString *urlStr= [[NSBundle mainBundle] pathForResource:@"4" ofType:@"mp4"];
       url =[NSURL fileURLWithPath:@"/Users/jasonwang/Desktop/4.mp4/"];
    } else {//在线，因为iOS9强制用https，所以改了Info.plist才能播放这资源
//        if ([self isCached]) {
//            url = [NSURL fileURLWithPath:[self getAllPathWithRelativePath:videoName]];
//        } else {
            url=[NSURL URLWithString:onlineVideoURL];
            [self downloadVideo];
//        }
    }
    AVPlayerItem *playerItem=[AVPlayerItem playerItemWithURL:url];
    return playerItem;
}
- (BOOL)isCached
{
    NSFileManager *fileManager = [NSFileManager defaultManager]; // default is not thread safe
    if ([fileManager fileExistsAtPath:[self getAllPathWithRelativePath:videoName]]) {
        return YES;
    } else {
        return NO;
    }
}
#pragma mark - 通知
/**
 *  添加播放器通知
 */
-(void)addNotification{
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}

-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  播放完成通知
 *
 *  @param notification 通知对象
 */
-(void)playbackFinished:(NSNotification *)notification{
    NSLog(@"视频播放完成.");
        [self.progress reStartProgressTotalTime:self.videoLength];
        [self.player seekToTime:CMTimeMake((0 * self.videoLength), 1.0)];
        [self.playOrPause setTitle:@"开始" forState:UIControlStateNormal];

}


#pragma mark - 监控
/**
 *  给播放器添加进度更新
 */
-(void)addProgressObserver{
    __weak typeof(self) weakSelf = self;
    //这里设置每秒执行一次
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        CGFloat currentTime =  CMTimeGetSeconds(time);
        strongSelf.currentTime = time;
                //NSLog(@"当前进度%.2fs.",currentTime);
        if (currentTime) {
            [strongSelf.progress setVideoCurrentTime:currentTime totalTime:strongSelf.videoLength];
        }
    }];
}

/**
 *  给AVPlayerItem添加监控
 *
 *  @param playerItem AVPlayerItem对象
 */
-(void)addObserverToPlayerItem:(AVPlayerItem *)playerItem{
    //监控状态属性，注意AVPlayer也有一个status属性，通过监控它的status也可以获得播放状态
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //监控网络加载情况属性
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}
-(void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem{
    [playerItem removeObserver:self forKeyPath:@"status"];
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}
/**
 *  通过KVO监控播放器状态
 *
 *  @param keyPath 监控属性
 *  @param object  监视器
 *  @param change  状态改变
 *  @param context 上下文
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    AVPlayerItem *playerItem=object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status= [[change objectForKey:@"new"] intValue];
        if(status==AVPlayerStatusReadyToPlay){
           // NSLog(@"正在播放...，视频总长度:%.2f",CMTimeGetSeconds(playerItem.duration));
            self.videoLength = CMTimeGetSeconds(playerItem.duration);
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array=playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        [self.progress setVideoCachedTime:totalBuffer totalTime:self.videoLength];
        //NSLog(@"共缓冲：%.2f",totalBuffer);
        //
    }
}

- (void)videoProgressViewDelegateCallBack_videoPercentage:(CGFloat)videoPercentage
{
    [self.player seekToTime:CMTimeMake((videoPercentage * self.videoLength), 1.0)];
}

- (void)volumeProgressViewDelegateCallBack_volumePercentage:(CGFloat)volumePercentage
{
    
}

#pragma mark - UI事件
/**
 *  点击播放/暂停按钮
 *
 *  @param sender 播放/暂停按钮
 */
- (IBAction)playClick:(UIButton *)sender {
    //    AVPlayerItemDidPlayToEndTimeNotification
    //AVPlayerItem *playerItem= self.player.currentItem;
    }


/**
 *  切换选集，这里使用按钮的tag代表视频名称
 *
 *  @param sender 点击按钮对象
 */
- (IBAction)navigationButtonClick:(UIButton *)sender {
    [self removeNotification];
    [self removeObserverFromPlayerItem:self.player.currentItem];
    AVPlayerItem *playerItem=[self getPlayItem:sender.tag];
    [self addObserverToPlayerItem:playerItem];
    //切换视频
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    [self addNotification];
}

@end