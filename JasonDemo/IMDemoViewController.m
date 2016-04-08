//
//  IMDemoViewController.m
//  JasonDemo
//
//  Created by jasonwang on 16/4/6.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "IMDemoViewController.h"
#import <Masonry/Masonry.h>
#import "RMAudioManager.h"

#define W_MAX_IMAGE (225 + (([ [ UIScreen mainScreen ] bounds ].size.width) - 320) * 0.5 * 2)

static NSString *const loginShowID = @"ZBAYNbRqYAUBbjDE11";
static NSString *const loginNickName = @"Andrew test";
//static NSString *const sendToShowID = @"ldx9XK9dRzf5LlDn";
//static NSString *const sendToNickName = @"jasonwang";

typedef NS_ENUM(NSUInteger, buttonType) {
    
    SendType,
    
    ImageType,
    
    VoiceType,
    
    ZOCMachineStatePaused
    
};

@interface IMDemoViewController ()<MessageManagerDelegate,UIImagePickerControllerDelegate,RMAudioManagerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITextField *myTextInputView;
@property (nonatomic, strong) UIButton *sentBtn;
@property (nonatomic, strong) UIButton *imageBtn;
@property (nonatomic, strong) UIButton *voiceBtn;
@property (nonatomic, strong) RMAudioManager *audioManager; // 录音manager
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataList;
@property (nonatomic, strong) ContactDetailModel *model;

@end

@implementation IMDemoViewController
- (instancetype)initWithModel:(ContactDetailModel *)model
{
    
    self = [super init];
    if (self) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self configElements];
    [[MessageManager share] setDelegate:self];
//    [MessageManager setUserId:loginShowID nickName:loginNickName];
//    [[MessageManager share] login];
    [self refreshChatList];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.myTextInputView resignFirstResponder];
}
#pragma mark -private method
- (void)configElements {
    [self.view addSubview:self.myTextInputView];
    [self.view addSubview:self.sentBtn];
    [self.view addSubview:self.imageBtn];
    [self.view addSubview:self.voiceBtn];
    [self.view addSubview:self.tableView];
    
    [self.myTextInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.bottom.equalTo(self.view).offset(-5);
        make.height.equalTo(@44);
        make.right.equalTo(self.view).offset(-80);
    }];
    
    [self.sentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.myTextInputView);
        make.left.equalTo(self.myTextInputView.mas_right).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    
    [self.imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.sentBtn);
        make.left.equalTo(self.myTextInputView);
        make.bottom.equalTo(self.myTextInputView.mas_top).offset(-5);
    }];
    [self.voiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.sentBtn);
        make.left.equalTo(self.imageBtn.mas_right);
        make.bottom.equalTo(self.myTextInputView.mas_top).offset(-5);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.imageBtn.mas_top);
    }];
}

- (UIButton *)getMyButtonWithTitel:(NSString *)titel tag:(buttonType)tag
{
    UIButton *btn =[[UIButton alloc] init];
    [btn setTitle:titel forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTag:tag];
    return btn;
}

//对图片尺寸进行压缩--
- (UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

- (void)refreshChatList
{
    [[MessageManager share] queryBatchMessageWithUid:self.model._target MessageCount:30 completion:^(NSArray *array) {
        if (array.count > 0) {
            self.dataList = array;
            [self.tableView reloadData];
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:array.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }];
    
}
#pragma mark - WriteToFilePath
- (void)writeImageToFilePathWithOringnalImage:(UIImage *)originImage thumbImage:(UIImage *)thumbImage;
{
    // 1.文件写入沙盒
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        // 得到路径
        long long timeStamp = [[NSDate date] timeIntervalSince1970] * 1000;
        NSString *strDate = [NSString stringWithFormat:@"%lld",timeStamp];
        NSString *strFileNameOriginal = [NSString stringWithFormat:@"%@origin.jpg",strDate];
        NSString *strFileNameThumb = [NSString stringWithFormat:@"%@thumb.jpg",strDate];
        NSString *strPath = [[MsgFilePathMgr share] getMessageDirNamePathWithUid:loginShowID];
        NSString *strOriginPath = [strPath stringByAppendingPathComponent:strFileNameOriginal];
        NSString *strThumbPath = [strPath stringByAppendingPathComponent:strFileNameThumb];
        
        
        
        // 写入文件夹
        [UIImageJPEGRepresentation(originImage, 0.5) writeToFile:strOriginPath atomically:YES];
        [UIImageJPEGRepresentation(thumbImage, 1.0) writeToFile:strThumbPath atomically:YES];
        
        
        // 转换成相对路径
        NSString *strRelativeOrigin = [[MsgFilePathMgr share] getRelativePathWithAllPath:strOriginPath];
        NSString *strRelativeThumb = [[MsgFilePathMgr share] getRelativePathWithAllPath:strThumbPath];
        
        // 回归主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 2. 下锚点
            [[MessageManager share] anchorAttachMessageType:msg_personal_image
                                                   toTarget:self.model._target
                                                   nickName:self.model._nickName
                                                primaryPath:strRelativeOrigin
                                                  minorPath:strRelativeThumb];
        });
    });
}
#pragma mark - LCVoice Method
// 开始录制
- (void)recordVoiceStart
{
    long long timeStamp = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *strDate = [NSString stringWithFormat:@"%lld",timeStamp];
    
    // 得到路径
    NSString *strPathWav = [[MsgFilePathMgr share] getMessageDirFilePathWithFileName:strDate extension:extension_wav uid:loginShowID];
    
    // 开始录制声音到文件夹
    [self.audioManager startRecordWithPath:strPathWav ShowInView:self.view];
}

// 停止录制
- (void)recordVoiceEnd
{
    [self.audioManager stopRecord];
}

// 取消录制
- (void)recordVoiceCancel
{
    [self.audioManager cancelRecord];
    
    // 防御，判断是否已超时
    if (self.audioManager.isFromCancel && !self.audioManager.isFinishRecord)
    {
        //[self postError:LOCAL(CANCELVOICE)];
    }
}
#pragma mark - event Response
- (void)btnClick:(UIButton *)btn {
    
    switch (btn.tag) {
        case SendType:
        {
            // 发送文字
            [[MessageManager share] sendMessageTo:self.model._target nick:self.model._nickName WithContent:self.myTextInputView.text Type:msg_personal_text];
        }
            break;
        case ImageType:
        {
            // 发送图片
            UIImagePickerController *imageVC =[[UIImagePickerController alloc] init];
            imageVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [imageVC setDelegate:self];
            //设置选择后的图片可被编辑
            imageVC.allowsEditing = YES;
            [self presentViewController:imageVC animated:YES completion:nil];
        }
            break;
        case VoiceType:
        {
            
        }
            break;
        default:
            break;
    }
    
}
#pragma mark - Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.myTextInputView resignFirstResponder];
}
#pragma mark - RMAudioManagerDelegate
//录音完成回调
- (void)RMAudioManagerDelegateCallBack_AudioFinishedRecordWithDuration:(CGFloat)duration Path:(NSString *)path
{
    if (self.audioManager.recordDuration <= 1.0f) {
        // 时间过短
        //[self postError:LOCAL(RADIO_TIMETOOSHORT)];
        return;
    }
    
    
    // 得到已经录制的音频路径（wav）
    NSString *strPathWav = self.audioManager.recordPath;
    
    // 转为相对路径
    NSString *relativePathWav = [[MsgFilePathMgr share] getRelativePathWithAllPath:strPathWav];
    // 下锚点
    [[MessageManager share] anchorAttachMessageType:msg_personal_voice
                                           toTarget:self.model._target
                                           nickName:self.model._nickName
                                        primaryPath:relativePathWav
                                          minorPath:nil];

}

#pragma mark - MessageManagerDelegate
//发送中
- (void)MessageManagerDelegateCallBack_needRefreshWithMessageBaseModel:(MessageBaseModel *)model
{
    NSLog(@"%@",model);
}
//发送成功
- (void)MessageManagerDelegateCallBack_synchMessage:(MessageBaseModel *)model
{
    NSLog(@"%@",model);
    [self.myTextInputView setText:@""];
    [self refreshChatList];
    
}
//对方收到
- (void)MessageManagerDelegateCallBack_needRefreshWithTareget:(NSString *)target
{
    NSLog(@"%@",target);
    
}
//收到消息
- (void)MessageManagerDelegateCallBack_receiveMessage:(MessageBaseModel *)model
{
    [self refreshChatList];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * image=[info objectForKey:UIImagePickerControllerOriginalImage];
    if (image != nil)
    {
        CGFloat W_img = MIN(W_MAX_IMAGE, image.size.width);
        CGFloat H_img = (W_img / image.size.width) * image.size.height;
        UIImage *imgThumb =  [self imageWithImage:image scaledToSize:CGSizeMake(W_img, H_img)];
        
        [self writeImageToFilePathWithOringnalImage:image thumbImage:imgThumb];
    }

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        [cell setSeparatorInset:UIEdgeInsetsZero];
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    MessageBaseModel *model = self.dataList[indexPath.row];
    [cell.textLabel setText:model._content];
    if ([model._fromLoginName isEqualToString:loginShowID]) {
        [cell.textLabel setTextAlignment:NSTextAlignmentRight];
    } else {
        [cell.textLabel setTextAlignment:NSTextAlignmentLeft];
    }
    return cell;
}
#pragma mark - request Delegate

#pragma mark - updateViewConstraints

#pragma mark - init UI
- (UITextField *)myTextInputView
{
    if (!_myTextInputView) {
        _myTextInputView = [[UITextField alloc] init];
        [_myTextInputView.layer setCornerRadius:5];
        [_myTextInputView.layer setBorderWidth:1];
    }
    return _myTextInputView;
}

- (UIButton *)sentBtn
{
    if (!_sentBtn) {
        _sentBtn = [self getMyButtonWithTitel:@"发送" tag:SendType];
        
    }
    return _sentBtn;
}
- (UIButton *)imageBtn
{
    if (!_imageBtn) {
        _imageBtn = [self getMyButtonWithTitel:@"图片" tag:ImageType];
    }
    return _imageBtn;
}

- (UIButton *)voiceBtn
{
    if (!_voiceBtn) {
        _voiceBtn = [self getMyButtonWithTitel:@"语音" tag:VoiceType];
        [_voiceBtn addTarget:self action:@selector(recordVoiceEnd) forControlEvents:UIControlEventTouchUpInside];
        [_voiceBtn addTarget:self action:@selector(recordVoiceStart) forControlEvents:UIControlEventTouchDown];
        [_voiceBtn addTarget:self action:@selector(recordVoiceCancel) forControlEvents:UIControlEventTouchUpOutside];
    }
    return _voiceBtn;
}

- (RMAudioManager *)audioManager
{
    if (!_audioManager)
    {
        _audioManager = [[RMAudioManager alloc] init];
        [_audioManager setDelegate:self];
    }
    return _audioManager;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
        [_tableView setBackgroundColor:[UIColor clearColor]];
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        [_tableView setShowsVerticalScrollIndicator:NO];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
