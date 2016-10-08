
//
//  TwoTableViewViewController.m
//  JasonDemo
//
//  Created by jasonwang on 16/8/27.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "TwoTableViewViewController.h"

#define leftTableWidth  [UIScreen mainScreen].bounds.size.width * 0.3
#define rightTableWidth [UIScreen mainScreen].bounds.size.width * 0.7
#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height

#define leftCellIdentifier  @"leftCellIdentifier"
#define rightCellIdentifier @"rightCellIdentifier"

@interface TwoTableViewViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@end

@implementation TwoTableViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -private method
- (void)configElements {
}
#pragma mark - event Response

#pragma mark - Delegate

#pragma mark - UITableViewDelegate
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTableView) {
        return 50;
    }
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.leftTableView) {
        return 1;
    }
    return 50;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (tableView == self.leftTableView) {
        cell = [tableView dequeueReusableCellWithIdentifier:leftCellIdentifier forIndexPath:indexPath];
        [cell.textLabel setText:[NSString stringWithFormat:@"第%ld组",indexPath.row]];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:rightCellIdentifier forIndexPath:indexPath];
        [cell.textLabel setText:[NSString stringWithFormat:@"第%ld组=-=第%ld行",indexPath.section,indexPath.row]];
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return nil;
    }
    return [NSString stringWithFormat:@"第 %ld 组", section];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.leftTableView) {
        return;
    }
    NSIndexPath *topIndexPath = [self.rightTableView indexPathsForVisibleRows].firstObject;
    NSIndexPath *moveIndexPath = [NSIndexPath indexPathForRow:topIndexPath.section inSection:0];
    
    [self.leftTableView selectRowAtIndexPath:moveIndexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.rightTableView) {
        return;
    }
    NSIndexPath *moveIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
    [self.rightTableView scrollToRowAtIndexPath:moveIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
#pragma mark - request Delegate

#pragma mark - Interface

#pragma mark - init UI
// MARK: - 左边的 tableView
- (UITableView *)leftTableView {
    
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, leftTableWidth, ScreenHeight-60)];
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
        [_leftTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:leftCellIdentifier];
        _leftTableView.backgroundColor = [UIColor redColor];
        _leftTableView.tableFooterView = [[UIView alloc] init];
        
    }
    return _leftTableView;
}

// MARK: - 右边的 tableView
- (UITableView *)rightTableView {
    
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(leftTableWidth, 0, rightTableWidth, ScreenHeight-60)];
        _rightTableView.dataSource = self;
        _rightTableView.delegate = self;
        [_rightTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:rightCellIdentifier];
        _rightTableView.backgroundColor = [UIColor cyanColor];
        _rightTableView.tableFooterView = [[UIView alloc] init];
    }
    return _rightTableView;
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
