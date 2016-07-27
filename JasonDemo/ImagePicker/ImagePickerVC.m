//
//  ImagePickerVC.m
//  JasonDemo
//
//  Created by jasonwang on 16/4/27.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "ImagePickerVC.h"
#import "ApplicationAttachmentTableViewCell.h"
#import <Masonry/Masonry.h>
#import "WZPhotoPickerController.h"
#import "ApplicationAttachmentModel.h"
#import "BottomLineButton.h"
#import "CoordinationFilterView.h"
typedef NS_ENUM(NSUInteger, TitelType) { //加好友，创建工作圈，新建任务的枚举
    
    AddNewFriendType,
    
    CreateWorkCircle,
    
    AddNewMissionType
    
};

#define HEIGHTCOLOR  [UIColor blueColor]
#define NORMALCOLOR  [UIColor lightGrayColor]
@interface ImagePickerVC ()<UITableViewDelegate,UITableViewDataSource,WZPhotoPickerControllerDelegate,CoordinationFilterViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, strong) BottomLineButton *westernMedicineBtn;    //西药
@property (nonatomic, strong) BottomLineButton *chinesePatentMedicine; //中成药
@property (nonatomic, strong)  CoordinationFilterView  *filterView; // <##>

@end

@implementation ImagePickerVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIBarButtonItem *taskItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(taskAction)];
    [self.navigationItem setRightBarButtonItem:taskItem];

    [self.view addSubview:self.westernMedicineBtn];
    [self.view addSubview:self.chinesePatentMedicine];
    [self.view addSubview:self.tableView];
    
    [self.westernMedicineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.right.equalTo(self.view.mas_centerX);
        make.height.equalTo(@45);
    }];
    [self.chinesePatentMedicine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.view);
        make.left.equalTo(self.view.mas_centerX);
        make.height.equalTo(@45);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.westernMedicineBtn.mas_bottom);
    }];


}
- (void)buttonClick:(BottomLineButton *)btn {
    [self.chinesePatentMedicine setSelected:btn.tag];
    [self.westernMedicineBtn setSelected:!btn.tag];
    if (btn.tag) {
        //中成药
        [self.chinesePatentMedicine.bottomLine setBackgroundColor:HEIGHTCOLOR];
        [self.westernMedicineBtn.bottomLine setBackgroundColor:NORMALCOLOR];
    }
    else {
        //西药
        [self.chinesePatentMedicine.bottomLine setBackgroundColor:NORMALCOLOR];
        [self.westernMedicineBtn.bottomLine setBackgroundColor:HEIGHTCOLOR];
    }
    
}

- (void)taskAction {
    if (![self.view.subviews containsObject:self.filterView]) {
        [self.view addSubview:self.filterView];
        [self.filterView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    else {
        [self.filterView removeFromSuperview];
        _filterView = nil;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ApplicationAttachmentTableViewCell heightForCellWithImageCount:[self.imageArr count] accessoryMode:YES];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ApplicationAttachmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ApplicationAttachmentTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    [cell setImages:self.imageArr];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WZPhotoPickerController *imagePicker = [[WZPhotoPickerController alloc] init];
    [imagePicker setDelegate:self];
    
    [imagePicker setMaximumNumberOfSelection:8];
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - WZPhotoPickerController Delegate
- (void)wz_imagePickerController:(WZPhotoPickerController *)photoPickerController didSelectAssets:(NSArray *)assets {
    [self imagePickerImages:assets];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}

- (void)imagePickerImages:(NSArray *)assets {
    for (ALAsset *asset in assets) {
        
        UIImage *image = [ApplicationAttachmentModel originalImageFromAsset:asset];
        ApplicationAttachmentModel *attachModel = [[ApplicationAttachmentModel alloc] initWithLocalImage:image];
        
        [self.imageArr addObject:attachModel];
    }

}
- (BOOL)navigationShouldPopOnBackButton { //在这个方法里写返回按钮的事件处理
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSLog(@"返回啦");
    return YES; //返回NO 不会执行
}

#pragma mark - CoordinationFilterViewDelegate
- (void)CoordinationFilterViewDelegateCallBack_ClickWithTag:(NSInteger)tag
{
    TitelType type = (TitelType)tag;
    switch (type) {
        case AddNewFriendType: {
            //
//            [self.interactor goAddFriends];
            
            break;
        }
        case CreateWorkCircle: {
//            [self.interactor goCreateWorkCircleIsCreate:YES nonSelectableContacts:nil workCircleID:nil];
            
            break;
        }
        case AddNewMissionType: {
//            [self.interactor goToAddNewMission];
            break;
        }
    }
    
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 60;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
    }
    return _tableView;
}

- (NSMutableArray *)imageArr
{
    if (!_imageArr) {
        _imageArr = [NSMutableArray new];
    }
    return _imageArr;
}

- (BottomLineButton *)westernMedicineBtn {
    if (!_westernMedicineBtn) {
        _westernMedicineBtn = [BottomLineButton new];
        [_westernMedicineBtn setTitle:@"西药" forState:UIControlStateNormal];
        [_westernMedicineBtn setTitleColor:HEIGHTCOLOR forState:UIControlStateSelected];
        [_westernMedicineBtn setTitleColor:NORMALCOLOR forState:UIControlStateNormal];
        [_westernMedicineBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_westernMedicineBtn setTag:0];
        [_westernMedicineBtn setSelected:YES];
        [_westernMedicineBtn.bottomLine setBackgroundColor:HEIGHTCOLOR];
    }
    return _westernMedicineBtn;
}

- (BottomLineButton *)chinesePatentMedicine {
    if (!_chinesePatentMedicine) {
        _chinesePatentMedicine = [BottomLineButton new];
        [_chinesePatentMedicine setTitle:@"中成药" forState:UIControlStateNormal];
        [_chinesePatentMedicine setTitleColor:HEIGHTCOLOR forState:UIControlStateSelected];
        [_chinesePatentMedicine setTitleColor:NORMALCOLOR forState:UIControlStateNormal];
        [_chinesePatentMedicine addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_chinesePatentMedicine setTag:1];
        
    }
    return _chinesePatentMedicine;
}
- (CoordinationFilterView *)filterView {
    if (!_filterView) {
        _filterView = [[CoordinationFilterView alloc] initWithImageNames:@[@"c_addFriend",@"c_addFriend",@"c_addFriend"] titles:@[@"加好友",@"创建工作圈",@"新建任务"] tags:@[@(AddNewFriendType),@(CreateWorkCircle),@(AddNewMissionType)]];
        _filterView.delegate = self;
    }
    return _filterView;
}
@end
