//
//  JWRACViewController.m
//  JasonDemo
//
//  Created by 王喆 on 2017/12/7.
//  Copyright © 2017年 jasonwang. All rights reserved.
//

#define kScreenWidth                         [[UIScreen mainScreen] bounds].size.width

#import "JWRACViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Masonry/Masonry.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "JWRACViewModel.h"
#import "UIImage+EX.h"

@interface JWRACViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *testBtn;
@property (nonatomic, strong) UITextField *nameFild;
@property (nonatomic, strong) UITextField *IDFild;
@property (nonatomic, strong) UITextField *bankCardFild;
@property (nonatomic, strong) UITextField *phoneFild;
@property (nonatomic, copy) NSArray *textFildArr;
@property (nonatomic, strong) JWRACViewModel *viewModel;
@end

@implementation JWRACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.textFildArr = @[self.nameFild,self.IDFild,self.bankCardFild,self.phoneFild];
    [self p_bind];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Interface Method

#pragma mark - Private Method
- (UITextField *)p_createTextField {
    UITextField *textField = [[UITextField alloc]init];
    textField.frame = CGRectMake(0, 0, kScreenWidth - 120, 45);
    textField.textAlignment = NSTextAlignmentLeft;
    textField.textColor = [UIColor blackColor];
    textField.font = [UIFont systemFontOfSize:15];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.adjustsFontSizeToFitWidth = YES;
    return textField;
}

- (void)p_bind {
    @weakify(self);
    RAC(self.viewModel,name) = self.nameFild.rac_textSignal;
    RAC(self.viewModel,IDNum) = self.IDFild.rac_textSignal;
    RAC(self.viewModel,bankNum) = self.bankCardFild.rac_textSignal;
    RAC(self.viewModel,phone) = self.phoneFild.rac_textSignal;
    
    self.testBtn.rac_command = self.viewModel.nextCommand;
    
}
#pragma mark - Event Response

#pragma mark - Delegate

#pragma mark - UITableView Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.textFildArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.testBtn;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    [cell setAccessoryView:self.textFildArr[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - UITextFieldDelegate

#pragma mark - Override

#pragma mark - InitView

#pragma mark - Init
- (JWRACViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [JWRACViewModel new];
    }
    return _viewModel;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _tableView;
}


- (UIButton *)testBtn {
    if (!_testBtn) {
        _testBtn = [UIButton new];
        [_testBtn setBackgroundImage:[UIImage imageWithColor:[UIColor blueColor] size:CGSizeMake(1, 1)] forState:UIControlStateNormal];
        [_testBtn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor] size:CGSizeMake(1, 1)] forState:UIControlStateDisabled];
        [_testBtn setTitle:@"test"forState:UIControlStateNormal];
    }
    return _testBtn;
}

- (UITextField *)nameFild {
    if (!_nameFild) {
        _nameFild = [self p_createTextField];
        [_nameFild setPlaceholder:@"请输入姓名"];
        [_nameFild setBackgroundColor:[UIColor redColor]];
    }
    return _nameFild;
}
- (UITextField *)IDFild {
    if (!_IDFild) {
        _IDFild = [self p_createTextField];
        [_IDFild setPlaceholder:@"请输入身份证号码"];
        [_IDFild setBackgroundColor:[UIColor redColor]];
    }
    return _IDFild;
}

- (UITextField *)bankCardFild {
    if (!_bankCardFild) {
        _bankCardFild = [self p_createTextField];
        [_bankCardFild setPlaceholder:@"请输入银行卡号"];

        [_bankCardFild setBackgroundColor:[UIColor redColor]];
    }
    return _bankCardFild;
}
- (UITextField *)phoneFild {
    if (!_phoneFild) {
        _phoneFild = [self p_createTextField];
        [_phoneFild setPlaceholder:@"请输入手机号码"];

        [_phoneFild setBackgroundColor:[UIColor redColor]];
    }
    return _phoneFild;
}
@end
