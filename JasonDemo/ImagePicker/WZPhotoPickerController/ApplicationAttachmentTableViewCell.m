//
//  ApplicationAttachmentTableViewCell.m
//  launcher
//
//  Created by williamzhang on 15/10/27.
//  Copyright © 2015年 William Zhang. All rights reserved.
//

#import "ApplicationAttachmentTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ApplicationAttachmentModel.h"
#import <Masonry/Masonry.h>
//#import "AttachmentUtil.h"
#import "UIFont+Util.h"
#import "JWView.h"

static CGFloat const maxTitleWidth = 50;

@interface ApplicationAttachmentTableViewCell ()

@property (nonatomic, strong) UILabel *innerTitleLabel;
@property (nonatomic, strong) JWView  *imageContentView;

@property (nonatomic, copy) void (^clickBlock)(NSUInteger);

@end

@implementation ApplicationAttachmentTableViewCell

+ (NSString *)identifier { return NSStringFromClass(self);}

+ (CGFloat)heightForCellWithImageCount:(NSUInteger)count {
    return [self heightForCellWithImageCount:count accessoryMode:NO];
}

+ (CGFloat)heightForCellWithImageCount:(NSUInteger)count accessoryMode:(BOOL)accessoryMode {
    if (!count) {
        return 44;
    }
    
    BOOL hasNextLine = count % 3;
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    NSInteger line = count / 3 + (hasNextLine ? 1 : 0);
    return 20 + (screenWidth - 80 - (accessoryMode ? 30 : 0)) *line / 3 + 20;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initComponents];
    }
    return self;
}

- (void)initComponents {
    [self.contentView addSubview:self.innerTitleLabel];
    [self.contentView addSubview:self.imageContentView];
    
    [self.innerTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).offset(15);
    }];
    
    [self.imageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(75);
        make.top.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-10);
    }];
}

#pragma mark - Interface Method
- (void)clickToSeeImage:(void (^)(NSUInteger))clickBlock {
    self.clickBlock = clickBlock;
}

- (void)setImages:(NSArray *)images {
    NSArray *reversedSubViews = [[[self.imageContentView subviews] reverseObjectEnumerator] allObjects];
    [reversedSubViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    static NSInteger colouns = 3;
    
    UIImageView *lastView = nil;
    for (NSInteger index = 0 ;index < images.count; index++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
    
        ApplicationAttachmentModel *image = [images objectAtIndex:index];
        
        if ([image thumbnailPath]) {
            imageView.image = [image thumbnail];
        }
        
        else {
            [imageView sd_setImageWithURL:[NSURL URLWithString:[[image path] stringByReplacingOccurrencesOfString:@"\\" withString:@"/"]] placeholderImage:[UIImage imageNamed:@"image_placeholder_loading"]];
        }
        
        [self.imageContentView addSubview:imageView];
        
        NSInteger row = index / colouns;
        NSInteger col = index % colouns;
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(imageView.mas_height);
            if (!row && !col) {
                // 第一块
                make.top.left.equalTo(self.imageContentView);
            }
            else if (row &&!col) {
                make.top.equalTo(lastView.mas_bottom).offset(10);
                make.left.equalTo(self.imageContentView);
            } else {
                make.left.equalTo(lastView.mas_right).offset(10);
                make.top.equalTo(lastView);
                if (col == 2) {
                    // 最后一块
                    make.right.equalTo(self.imageContentView);
                }
            }
            
            make.width.lessThanOrEqualTo(self.imageContentView).dividedBy(3);
            if (lastView) {
                make.width.equalTo(lastView);
            }
        }];
        
        imageView.tag = index;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickToSeeImageGesture:)];
        [imageView addGestureRecognizer:tapGesture];
        imageView.userInteractionEnabled = YES;
        
        lastView = imageView;
    }
    
    if (lastView) {
        [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.imageContentView);
        }];
    }
}

#pragma mark - Button Click
- (void)clickToSeeImageGesture:(UITapGestureRecognizer *)gesture {
    UIView *clickedView = gesture.view;
    if (self.clickBlock) {
        self.clickBlock(clickedView.tag);
    }
}

- (UILabel *)titleLabel {
    return self.innerTitleLabel;
}

#pragma mark - Initiializer 
- (UILabel *)innerTitleLabel {
    if (!_innerTitleLabel) {
        _innerTitleLabel = [UILabel new];
        _innerTitleLabel.font = [UIFont font_30];
        _innerTitleLabel.textColor = [UIColor blackColor];
        _innerTitleLabel.numberOfLines = 0;
        _innerTitleLabel.preferredMaxLayoutWidth = maxTitleWidth;
    }
    return _innerTitleLabel;
}

- (JWView *)imageContentView {
    if (!_imageContentView) {
        _imageContentView = [JWView new];
    }
    return _imageContentView;
}

@end
