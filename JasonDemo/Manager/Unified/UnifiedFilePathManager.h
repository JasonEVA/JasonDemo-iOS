//
//  UnifiedFilePathManager.h
//  Parenting Strategy
//
//  Created by Remon Lv on 14-6-28.
//  Copyright (c) 2014年 Remon Lv. All rights reserved.
//  统一管理————文件路径

#import <UIKit/UIKit.h>

typedef enum
{
    class_tag_sql,                      // 数据库

    class_tag_min = 0,
    
    class_tag_allContacts,             // 联系人总表
    
    class_tag_max,
    
    class_tag_message,                 // 消息总表（包含了聊天消息和APP消息）
    
} UnifiedClassManagerTag;     // 模块

typedef enum
{
    extension_office,        // office文档
    extension_office_ppt,    // ppt
    extension_office_word,   // word
    extension_office_xls,    // xls
    extension_txt,           // txt
    extension_htm,           // htm,html
    extension_image,         // image
    extension_xml,           // xml
    extension_pdf,           // pdf
    extension_rar,           // rar,zip
    extension_nil,           // 未知格式
} Extentsion_kind;           // 扩展名

@interface UnifiedFilePathManager : NSObject

// 单例
+ (UnifiedFilePathManager *)share;

// 取出对应模块的名称
- (NSString *)getClassNameWithTag:(UnifiedClassManagerTag)tag;

// 取出对应模块的路径名称
- (NSString *)getClassPathWithTag:(UnifiedClassManagerTag)tag;

// 取出对应的文件路径名称 拼接上自己要的路径
- (NSString *)getClassPathWithTag:(UnifiedClassManagerTag)tag WithComponent:(NSString *)component;

// 通过文件名/文件路径得到文件类型
- (Extentsion_kind)takeFileExtensionWithString:(NSString *)fileName;

// 通过文件名/文件路径得到文件类型图标
- (UIImage *)takeFileExtensionIconWithString:(NSString *)fileName;

// 将图片写入临时缓存中并且返回路径数组
- (NSArray *)writeImagesToCacheWith:(NSArray *)images;

// 计算单个文件的大小
- (long long)takeFileSizeAtPath:(NSString *)filePath;

/** 保存视频的目录 */
- (NSString *)getVideoPath;

/** 视频格式 */
- (NSString *)newFileWithType:(NSString *)type;

/** 视频格式 清晰度 */
- (NSString *)newFileWithType:(NSString *)type sessionPreset:(NSString *)sessionPreset;


// ***************以下方法为进出数据库的方法*************
/** 剥离沙盒全路径 留下Documents以后的相对路径
 */
- (NSString *)getRelativePathWithAllPath:(NSString *)allPath;

/** 拼接沙盒全路径 拼接Documents以后的相对路径
 */
- (NSString *)getAllPathWithRelativePath:(NSString *)relativePath;

/**批量删除某人或者群组的文件资源目录
 */
//- (void)clearAllFileForMessageWithTarget:(NSString *)target;

@end
