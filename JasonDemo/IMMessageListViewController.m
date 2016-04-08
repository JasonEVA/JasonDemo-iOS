//
//  IMMessageListViewController.m
//  JasonDemo
//
//  Created by jasonwang on 16/4/8.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "IMMessageListViewController.h"
#import <MintcodeIM/MintcodeIM.h>
#import <Masonry/Masonry.h>
#import "IMDemoViewController.h"

static NSString *const loginShowID = @"ZBAYNbRqYAUBbjDE11";
static NSString *const loginNickName = @"Andrew test";

@interface IMMessageListViewController ()<MessageManagerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataList;

@end

@implementation IMMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIBarButtonItem *rightBn = [[UIBarButtonItem alloc] initWithTitle:@"新建群聊" style:UIBarButtonItemStyleDone target:self action:@selector(newGroup)];
    [self.navigationItem setRightBarButtonItem:rightBn];
    [self configElements];
    [[MessageManager share] setDelegate:self];
    [MessageManager setUserId:loginShowID nickName:loginNickName];
    [[MessageManager share] login];
    [[MessageManager share] getMessageListOnlyChat:YES completion:^(NSArray<ContactDetailModel *> *model){
        self.dataList = model;
        [self.tableView reloadData];
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -private method
- (void)configElements {
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)newGroup
{
    [[MessageManager share] createGroupWithUserIds:@[@"ldx9XK9dRzf5LlDn"]
                                               tag:@"自定义标签"
                                        completion:^(UserProfileModel *groupProfile, BOOL isSuccess)
     {
         if (!isSuccess) {
             // 显示失败
             return;
         }
         
         NSLog(@"groupUid:%@, nickName:%@", groupProfile.userName, groupProfile.nickName);
     }];
}
#pragma mark - event Response

#pragma mark - Delegate



#pragma mark - UITableViewDelegate
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
    ContactDetailModel *model = self.dataList[indexPath.row];
    [cell.textLabel setText:model._nickName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    IMDemoViewController *VC = [[IMDemoViewController alloc] initWithModel:self.dataList[indexPath.row]];
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark - request Delegate

#pragma mark - updateViewConstraints

#pragma mark - init UI

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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


@end
