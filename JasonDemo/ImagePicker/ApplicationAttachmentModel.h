//
//  ApplicationAttachmentModel.h
//  launcher
//
//  Created by williamzhang on 15/10/27.
//  Copyright © 2015年 William Zhang. All rights reserved.
//  application 附件

#import <UIKit/UIKit.h>

@class ALAsset;

@interface ApplicationAttachmentModel : NSObject

@property (nonatomic, copy  ) NSString *showId;
@property (nonatomic, copy  ) NSString *title;
@property (nonatomic, copy  ) NSString *path;
@property (nonatomic, copy  ) NSString *pathURL;
@property (nonatomic, assign) long     size;

@property (nonatomic, readonly) NSString *localPath;
@property (nonatomic, readonly) NSString *thumbnailPath;

@property (nonatomic, readonly) UIImage *thumbnail;
@property (nonatomic, readonly) UIImage *originalImage;

+ (UIImage *)originalImageFromAsset:(ALAsset *)asset;

- (instancetype)initWithDict:(NSDictionary *)dict;
- (instancetype)initWithLocalImage:(UIImage *)localImage;

@end
