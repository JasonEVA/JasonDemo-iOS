//
//  ApplicationAttachmentModel.m
//  launcher
//
//  Created by williamzhang on 15/10/27.
//  Copyright © 2015年 William Zhang. All rights reserved.
//

#import "ApplicationAttachmentModel.h"
#import "NSDictionary+SafeManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImage+Manager.h"

static NSString *const d_showID  = @"ShowID";
static NSString *const d_title   = @"title";
static NSString *const d_path    = @"path";
static NSString *const d_size    = @"size";
static NSString *const d_pathurl = @"pathUrl";

@implementation ApplicationAttachmentModel

+ (UIImage *)originalImageFromAsset:(ALAsset *)asset {
    if (!asset) {
        return [UIImage new];
    }
    
    ALAssetRepresentation *representation = [asset defaultRepresentation];
    return [UIImage imageWithCGImage:[representation fullScreenImage]];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        _showId  = [dict valueStringForKey:d_showID];
        _title   = [dict valueStringForKey:d_title];
        _path    = [dict valueStringForKey:d_path];
        _size    = [[dict valueNumberForKey:d_size] longValue];
        _pathURL = [dict valueStringForKey:d_pathurl];
    }
    return self;
}

- (instancetype)initWithLocalPath:(NSURL *)localPath {
    self = [super init];
    if (self) {
        _localPath = [localPath absoluteString];
    }
    return self;
}

- (instancetype)initWithLocalImage:(UIImage *)localImage {
    self = [super init];
    if (self) {
        UIImage *thumbail = [UIImage compressImage:localImage
                                      ScaledToSize:CGSizeMake(100, 100)];
        _thumbnailPath = [self writeToFileImage:thumbail];
        _localPath     = [self writeToFileImage:localImage];
    }
    return self;
}

- (UIImage *)thumbnail {
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:self.thumbnailPath];
    return [UIImage imageWithContentsOfFile:filePath];
}

- (UIImage *)originalImage {
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:self.localPath];
    return [UIImage imageWithContentsOfFile:filePath];
}

#pragma mark - Private Method
- (NSString *)writeToFileImage:(UIImage *)image {
    NSString *fileName = [NSString stringWithFormat:@"%@_%@",[[NSProcessInfo processInfo] globallyUniqueString], @"image.png"];
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
    
    [UIImageJPEGRepresentation(image, 1) writeToFile:filePath options:NSDataWritingAtomic error:nil];
    return fileName;
}

@end
