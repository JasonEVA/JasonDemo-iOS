//
//  JWNavAnimationViewController.m
//  JasonDemo
//
//  Created by jasonwang on 2017/4/7.
//  Copyright © 2017年 jasonwang. All rights reserved.
//

#import "JWNavAnimationViewController.h"
#import "UIColor+HexExtension.h"
#import <Masonry/Masonry.h>
#import "UIView+EX.h"
#import "UINavigationBar+JWGradient.h"

#define HEADICONHEIGHT            60        //头像大小
#define NAVBAR_CHANGE_POINT       0
#define TOPVIEWHEIGHT             142

@interface JWNavAnimationViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *headIconView;
@property (nonatomic, strong) UILabel *userNamelb;
@property (nonatomic, strong) UILabel *moveUserNameLb;     // 移动useranme 动画
@property (nonatomic) CGFloat lastTableViewOffset;         // 用于记录上一次滑动
@property (nonatomic) CGPoint moveLbLocation;              // 记录moveUserNameLb位置

@end

@implementation JWNavAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar jw_setBackgroundColor:[UIColor clearColor]];
    
    [self.navigationItem setTitle:@"龙铁拳"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"ffffff"],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.lastTableViewOffset = -10000;
    [self.view addSubview:self.tableView];
    [self.navigationController.view addSubview:self.moveUserNameLb];
    
    
    
    [self configElements];

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar jw_setBackgroundViewLayerWithAlpha:1];
//    [self.moveUserNameLb setHidden:YES];
}

#pragma mark -private method
- (void)configElements {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(-64);
    }];
    [self.moveUserNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.navigationController.view.mas_top).offset(TOPVIEWHEIGHT-18-30);
        make.left.equalTo(self.navigationController.view).offset(15+60+15);
    }];
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
        
    }
    else if (section == 1) {
        return 2;
        
    }
    else if (section == 2) {
        return 3;
        
    }
    else if (section == 3) {
        return 2;
        
    }
    else if (section == 4) {
        return 4;
        
    }
    else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cell;
    
        cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell at_identifier]];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 设置navigationBar透明度和颜色
    CGFloat tableViewOffsetY = scrollView.contentOffset.y + 64;
    //    NSLog(@"%f",tableViewOffsetY);
    if (tableViewOffsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - tableViewOffsetY * 3) / 64));
        [self.navigationController.navigationBar jw_setBackgroundViewLayerWithAlpha:alpha];
    } else {
        [self.navigationController.navigationBar jw_setBackgroundColor:[UIColor clearColor]];
        [self.navigationController.navigationBar jw_removeOverSubLayer];
    }
    // 移动titel
    CGPoint titlePoint = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, 20 + 22);
    CGPoint namePoint = self.moveUserNameLb.center;
    CGPoint fromePoint = self.moveLbLocation;
    CGPoint toPoint;
    CGFloat proportion;
    
    if (tableViewOffsetY >= 40) {
        // titel在最上面
        [self.navigationItem setTitle:@"龙铁拳"];
        [self.userNamelb setHidden:YES];
        [self.moveUserNameLb setHidden:YES];
    }
    else if(tableViewOffsetY <= 0) {
        // titel在最下面
        [self.navigationItem setTitle:@""];
        [self.userNamelb setHidden:NO];
        [self.moveUserNameLb setHidden:YES];
    }
    else {
        // 移动中
        [self.moveUserNameLb setHidden:NO];
        [self.userNamelb setHidden:YES];
        [self.navigationItem setTitle:@""];
        
        if (!self.moveLbLocation.x) {
            self.moveLbLocation = self.moveUserNameLb.center;
        }
        
        if ((tableViewOffsetY - self.lastTableViewOffset) > 0) {
            // 向上滑
            toPoint =  titlePoint;
            proportion = (tableViewOffsetY) / 104;
        }
        else {
            // 向下滑
            toPoint = namePoint;
            proportion = (self.lastTableViewOffset - tableViewOffsetY) / 30;
        }
        //x轴偏移的量
        CGFloat offsetX = (toPoint.x - fromePoint.x) * proportion;
        
        //Y轴偏移的量
        CGFloat offsetY = (toPoint.y - fromePoint.y) * proportion;
        self.lastTableViewOffset = tableViewOffsetY;
        self.moveLbLocation = CGPointMake(self.moveLbLocation.x + offsetX, self.moveLbLocation.y + offsetY);
        
        self.moveUserNameLb.transform = CGAffineTransformTranslate(self.moveUserNameLb.transform, offsetX, offsetY);
    }
    
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView setEstimatedRowHeight:45];
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
        [_tableView setBackgroundColor:[UIColor lightGrayColor]];
        [_tableView setShowsVerticalScrollIndicator:NO];
        [self.topView addSubview:self.headIconView];
        [self.topView addSubview:self.userNamelb];
        [self.headIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.topView).offset(15);
            make.bottom.equalTo(self.topView).offset(-18);
            make.height.width.equalTo(@HEADICONHEIGHT);
        }];
        
        [self.userNamelb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.headIconView);
            make.left.equalTo(self.headIconView.mas_right).offset(15);
            make.right.lessThanOrEqualTo(self.topView).offset(-15);
        }];
        
        [_tableView setTableHeaderView:self.topView];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell at_identifier]];
        
    }
    return _tableView;
}
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, TOPVIEWHEIGHT)];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)[[UIColor colorWithHexString:@"3cd395"] CGColor], (__bridge id)[[UIColor colorWithHexString:@"31c9ba"] CGColor]];
        gradientLayer.locations = @[@0.1, @1.0];
        gradientLayer.startPoint = CGPointMake(0, 1.0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
        gradientLayer.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, TOPVIEWHEIGHT);
        [_topView.layer addSublayer:gradientLayer];
    }
    return _topView;
}
- (UIImageView *)headIconView {
    if (!_headIconView) {
        _headIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_default_photo"]];
        [_headIconView.layer setCornerRadius:HEADICONHEIGHT / 2];
        [_headIconView setClipsToBounds:YES];
    }
    return _headIconView;
}

- (UILabel *)userNamelb {
    if (!_userNamelb) {
        _userNamelb = [UILabel new];
        [_userNamelb setTextColor:[UIColor colorWithHexString:@"ffffff"]];
        [_userNamelb setFont:[UIFont systemFontOfSize:18]];
        [_userNamelb setText:@"龙铁拳"];
    }
    return _userNamelb;
}

- (UILabel *)moveUserNameLb {
    if (!_moveUserNameLb) {
        _moveUserNameLb = [UILabel new];
        [_moveUserNameLb setTextColor:[UIColor colorWithHexString:@"ffffff"]];
        [_moveUserNameLb setFont:[UIFont systemFontOfSize:18]];
        [_moveUserNameLb setText:@"龙铁拳"];
    }
    return _moveUserNameLb;
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
