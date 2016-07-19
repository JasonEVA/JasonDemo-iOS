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

@interface ImagePickerVC ()<UITableViewDelegate,UITableViewDataSource,WZPhotoPickerControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *imageArr;
@end

@implementation ImagePickerVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

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
@end
