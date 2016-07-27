//
//  CoordinationFilterView.m
//  HMDoctor
//
//  Created by Andrew Shen on 16/4/12.
//  Copyright © 2016年 yinquan. All rights reserved.
//

#import "CoordinationFilterView.h"
#import <Masonry/Masonry.h>


@interface CoordinationFilterView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)  UITableView  *tableView; // <##>
@property (nonatomic, strong)  UIView  *shadowView; // <##>
@property (nonatomic, strong)  NSMutableArray  *arrayTitles; // <##>
@property (nonatomic, strong)  NSMutableArray  *arrayImages; // <##>
@property (nonatomic, strong)  NSMutableArray<NSNumber *>  *arrayTags; // <##>
@property (nonatomic, strong)  UIImageView  *imgViewArrow; // <##>
@property (nonatomic)  CGFloat  topOffset; // <##>
@end

@implementation CoordinationFilterView


#pragma mark - Interface Method

- (instancetype)initWithImageNames:(NSArray *)imageNames titles:(NSArray *)titles tags:(NSArray *)tags
{
    return [self initWithImageNames:imageNames titles:titles tags:tags topOffset:0];
}

- (instancetype)initWithImageNames:(NSArray *)imageNames titles:(NSArray *)titles tags:(NSArray *)tags topOffset:(CGFloat)topOffset {
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self.arrayTitles removeAllObjects];
        self.arrayTitles = [titles mutableCopy];
        
        [self.arrayImages removeAllObjects];
        self.arrayImages = [imageNames mutableCopy];
        
        [self.arrayTags removeAllObjects];
        self.arrayTags = [tags mutableCopy];
        
        self.topOffset = topOffset;
        [self configElements];
    }
    return self;

}

#pragma mark - Private Method

// 设置元素控件
- (void)configElements {
    [self addSubview:self.shadowView];
    [self.shadowView addSubview:self.imgViewArrow];
    [self.shadowView addSubview:self.tableView];
    // 设置数据
    [self configData];
    
    // 设置约束
    [self configConstraints];
}

// 设置约束
- (void)configConstraints {
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(2);
        make.right.equalTo(self).offset(-13);
    }];
    [self.imgViewArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shadowView).offset(self.topOffset);
        make.centerX.equalTo(self.shadowView.mas_right).offset(-12);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgViewArrow.mas_bottom).offset(-1);
        make.width.mas_equalTo(145);
        make.height.mas_equalTo(45 * self.arrayTitles.count);
        make.left.right.bottom.equalTo(self.shadowView);
    }];
}

// 设置数据
- (void)configData {
    
}

#pragma mark - Event Response

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}
#pragma mark - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayTitles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setLayoutMargins:UIEdgeInsetsZero];
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"filterCell"];
    [cell.textLabel setFont:[UIFont systemFontOfSize:15]];
    [cell.imageView setImage:[UIImage imageNamed:self.arrayImages[indexPath.row]]];
    [cell.textLabel setTextColor:[UIColor lightGrayColor]];
    [cell.textLabel setText:self.arrayTitles[indexPath.row]];
    cell.tag = self.arrayTags[indexPath.row].integerValue;
    return cell;
}

#pragma mark    UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:false];
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(CoordinationFilterViewDelegateCallBack_ClickWithTag:)]) {
        [self.delegate CoordinationFilterViewDelegateCallBack_ClickWithTag:self.arrayTags[indexPath.row].integerValue];
    }
}

#pragma mark - Override

#pragma mark - Init

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 45;
        _tableView.bounces = NO;
        _tableView.tableFooterView = [UIView new];
        [_tableView.layer setCornerRadius:5];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"filterCell"];
    }
    return _tableView;
}

- (NSMutableArray *)arrayTitles {
    if (!_arrayTitles) {
        _arrayTitles = [@[] mutableCopy];
    }
    return _arrayTitles;
}

- (NSMutableArray *)arrayImages {
    if (!_arrayImages) {
        _arrayImages = [@[] mutableCopy];
    }
    return _arrayImages;
}

- (NSMutableArray *)arrayTags {
    if (!_arrayTags) {
        _arrayTags = [@[] mutableCopy];
    }
    return _arrayTags;
}

- (UIImageView *)imgViewArrow {
    if (!_imgViewArrow) {
        _imgViewArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"c_whiteArrow"]];
    }
    return _imgViewArrow;
}

- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [UIView new];
        [_shadowView.layer setShadowOffset:CGSizeMake(0, 3)];
        [_shadowView.layer setShadowRadius:5];
        [_shadowView.layer setShadowOpacity:0.5];
    }
    return _shadowView;
}
@end
