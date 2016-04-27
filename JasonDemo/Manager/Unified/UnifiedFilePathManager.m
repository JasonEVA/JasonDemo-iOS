//
//  UnifiedFilePathManager.m
//  Parenting Strategy
//
//  Created by Remon Lv on 14-6-28.
//  Copyright (c) 2014年 Remon Lv. All rights reserved.
//

#import "UnifiedFilePathManager.h"
#import "UnifiedUserInfoManager.h"
//#import "MyDefine.h"
#import "NSString+Manager.h"

// 一级目录是登录用户名，二级目录是数据库/图片，三级目录是每个模块名称
#define KIND_SQL @"Sql"
#define KIND_IMAGE @"Image"

#define NAME_SQL            @"Sql"          // 数据库

#define NAME_MESSAGE        @"Message"      // 消息
#define NAME_MSGID          @"MsgId"        // 消息msgId
#define NAME_MESSAGE_STATUS @"MessageStatus"// 消息状态
#define NAME_MYDEPT         @"MyDept"       // 我的部门
#define NAME_NEARESTUSER    @"NearestUser"  // 最近联系人
#define NAME_FAVORITEUSER   @"FavoriteUser" // 收藏联系人
#define NAME_ALLCONTACTS    @"AllContacts"  // 联系人总表
#define NAME_GROUP          @"GroupInfo"    // 已有群
#define NAME_USERSETTING    @"UserSetting"  // 用户设置

#define FILE_ICON_TXT       @"file_icon_txt"
#define FILE_ICON_RAR       @"file_icon_rar"
#define FILE_ICON_XML       @"file_icon_xml"
#define FILE_ICON_PDF       @"file_icon_pdf"
#define FILE_ICON_UNKNOWN   @"file_icon_unknown"
#define FILE_ICON_XLS       @"file_icon_xls"
#define FILE_ICON_HTML5     @"file_icon_html5"
#define FILE_ICON_IMAGE     @"file_icon_image"
#define FILE_ICON_WORD      @"file_icon_word"
#define FILE_ICON_PPT       @"file_icon_ppt"

#define STR_DOCUMENTS @"Documents"

#define NAME_VIDEO          @"Video"            // 视频

@implementation UnifiedFilePathManager

// 单例
+ (UnifiedFilePathManager *)share
{
    static UnifiedFilePathManager *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[UnifiedFilePathManager alloc] init];
    });
    return shareInstance;
}

// 取出对应的数据库表名称
- (NSString *)getClassNameWithTag:(UnifiedClassManagerTag)tag
{
    NSString *name = @"";
    switch (tag) {
        case class_tag_sql:
            return [name stringByAppendingPathComponent:NAME_SQL];
        case class_tag_allContacts:
            return [name stringByAppendingPathComponent:NAME_ALLCONTACTS];
        default:
            return @"";
    }
}

// 取出对应的文件路径名称，采用每个类目名为一个文件夹，每个文件夹下保存图片和数据库
- (NSString *)getClassPathWithTag:(UnifiedClassManagerTag)tag
{
    // 得到模块名称
    NSString *name = [self getClassNameWithTag:tag];
    // 拼接完成路径
    name = [self getDocumentsPathWithDirName:name];
    
   // PRINT_STRING(name);

    return name;
}

// 取出对应的文件路径名称 拼接上自己要的路径
- (NSString *)getClassPathWithTag:(UnifiedClassManagerTag)tag WithComponent:(NSString *)component
{
    // 得到模块名称
    NSString *name = [self getClassNameWithTag:tag];
    name = [name stringByAppendingPathComponent:component];
    // 拼接完成路径
    name = [self getDocumentsPathWithDirName:name];
    return name;
}

// 返回包含到文件夹的全路径，如果没有则创建一个
- (NSString *)getDocumentsPathWithDirName:(NSString *)dirName
{
    // 判断本地是否存在存放图片的文件夹
    NSFileManager *fm = [NSFileManager defaultManager];
    // 文件夹不存在则创建
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // 当前登录用户名为总文件夹，确保切换登录账号不会造成数据错误
    NSString * documentsdir = [[paths objectAtIndex:0] stringByAppendingPathComponent:[[UnifiedUserInfoManager share] getAccountWithEncrypt:YES]];
    // 拼接上文件夹名称
    documentsdir = [documentsdir stringByAppendingPathComponent:dirName];
    BOOL isDir;
    BOOL isExist = [fm fileExistsAtPath:documentsdir isDirectory:&isDir];
    // 文件夹不存在
    if (!(isExist && isDir))
    {
        // 创建一个
        [fm createDirectoryAtPath:documentsdir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return documentsdir;
}

// 通过文件名/文件路径得到文件类型
- (Extentsion_kind)takeFileExtensionWithString:(NSString *)fileName
{
    // 得到文件的扩展名
    NSString *extension = [fileName pathExtension];
    extension = [extension lowercaseString];
    Extentsion_kind fileKind;
    
    if ([self isEqualToString:extension InArray:[NSArray arrayWithObjects:@"doc", @"docx", @"xls", @"xlsx", @"ppt", @"pdf", nil]])
    {
        fileKind = extension_office;
    }
    else if ([self isEqualToString:extension InArray:[NSArray arrayWithObjects:@"jpg", @"jpeg", @"png", @"gif", nil]])
    {
        fileKind = extension_image;
    }
    
    else if ([extension isEqualToString:@"txt"])
    {
        fileKind = extension_txt;
    }
    else if ([self isEqualToString:extension InArray:[NSArray arrayWithObjects:@"htm", @"html", nil]])
    {
        fileKind = extension_htm;
    }
    else
    {
        fileKind = extension_nil;
    }
    return fileKind;
}

// 通过文件名/文件路径得到文件类型图标
- (UIImage *)takeFileExtensionIconWithString:(NSString *)fileName
{
    NSString *strName = @"";
    // 得到文件的扩展名
    NSString *extension = [fileName pathExtension];
    extension = [extension lowercaseString];
    if ([extension isEqualToString:@"txt"])
    {
        strName = FILE_ICON_TXT;
    }
    else if ([self isEqualToString:extension InArray:[NSArray arrayWithObjects:@"htm", @"html", nil]])
    {
        strName = FILE_ICON_HTML5;
    }
    else if ([self isEqualToString:extension InArray:[NSArray arrayWithObjects:@"jpg", @"jpeg", @"png", @"gif", nil]])
    {
        strName = FILE_ICON_IMAGE;
    }
    else if ([extension isEqualToString:@"xml"])
    {
        strName = FILE_ICON_XML;
    }
    else if ([self isEqualToString:extension InArray:[NSArray arrayWithObjects:@"doc", @"docx", nil]])
    {
        strName = FILE_ICON_WORD;
    }    
    else if ([self isEqualToString:extension InArray:[NSArray arrayWithObjects:@"xls", @"xlsx", nil]])
    {
        strName = FILE_ICON_XLS;
    }
    else if ([extension isEqualToString:@"ppt"])
    {
        strName = FILE_ICON_PPT;
    }
    else if ([extension isEqualToString:@"pdf"])
    {
        strName = FILE_ICON_PDF;
    }
    else if ([self isEqualToString:extension InArray:[NSArray arrayWithObjects:@"rar", @"zip", nil]])
    {
        strName = FILE_ICON_RAR;
    }
    else
    {
        strName = FILE_ICON_UNKNOWN;
    }

    UIImage *img = [UIImage imageNamed:strName];
    return img;
}

// 写入临时缓存中并且返回路径数组
- (NSArray *)writeImagesToCacheWith:(NSArray *)images
{
    // 路径数组
    NSMutableArray *arrPath = [NSMutableArray arrayWithCapacity:images.count];
    
    // 批量写入缓存中
//    for (UIImage *image in images)
//    {
        // 转换成二进制
//        NSData *dataImag = UIImagePNGRepresentation(image);
        
        // 根据当前时间生成文件名
//        NSString *name = [NSString convertCurrentDateTimeToString];
//        NSString *imgName = [NSString stringWithFormat:@"%@.png",name];
        
        // 获取沙盒目录
//        NSString *fullPath = [[self getClassPathWithTag:class_tag_mail] stringByAppendingPathComponent:imgName];
        
        // 将图片写入文件
//        [dataImag writeToFile:fullPath atomically:YES];
        
        // 将地址加入数组中
//        [arrPath addObject:fullPath];
//    }
    return arrPath;
}

// 计算单个文件的大小
- (long long)takeFileSizeAtPath:(NSString *)filePath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath])
    {
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

/** 剥离沙盒全路径 留下Documents以后的相对路径
 */
- (NSString *)getRelativePathWithAllPath:(NSString *)allPath
{
    NSString *strResult = nil;
    NSRange rangeRelative = [allPath rangeOfString:STR_DOCUMENTS];
    if (rangeRelative.location != NSNotFound)
    {
        strResult = [allPath substringFromIndex:(rangeRelative.location + rangeRelative.length)];
    }
    
    return strResult;
}

/** 拼接沙盒全路径 拼接Documents以后的相对路径
 */
- (NSString *)getAllPathWithRelativePath:(NSString *)relativePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *strResult =  [paths objectAtIndex:0];
    strResult = [strResult stringByAppendingPathComponent:relativePath];
    
    return strResult;
}

/**批量删除某人或者群组的文件资源目录
 */
//- (void)clearAllFileForMessageWithTarget:(NSString *)target
//{
//        // 全路径
//        NSString *pathAll = [self getClassPathWithTag:class_tag_message WithComponent:target];
//    
//        // 文件操作类
//        NSFileManager *fm = [NSFileManager defaultManager];
//        BOOL isDir;
//        BOOL isExist = [fm fileExistsAtPath:pathAll isDirectory:&isDir];
//        BOOL result;
//    
//        // 判断文件夹是否存在
//        if ((isExist && isDir))
//        {
//            // 删除文件夹
//            if (![fm removeItemAtPath:pathAll error:nil])
//            {
//                result = NO;
//            }
//        }
//    
//        result = YES;
//}

// 删除某个类目的所有文件和文件夹
//- (BOOL)deleteAllFilesWithTag:(UnifiedFilePathManagerTag)tag
//{
//    // 文件夹路径
//    NSString *path = [self getFileNameWithTag:tag];
//    // 全路径
//    NSString *pathAll = [self getDocumentsPathWithDirName:path];
//    
//    // 文件操作类
//    NSFileManager *fm = [NSFileManager defaultManager];
//    BOOL isDir;
//    BOOL isExist = [fm fileExistsAtPath:pathAll isDirectory:&isDir];
//    
//    // 判断文件夹是否存在
//    if ((isExist && isDir))
//    {
//        // 删除文件夹
//        if (![fm removeItemAtPath:pathAll error:nil])
//        {
//            return NO;
//        }
//    }
//
//    return YES;
//}

// 保存视频的目录
- (NSString *)getVideoPath
{
    // 得到模块名称
    NSString *name = NAME_VIDEO;
    // 拼接完成路径
    name = [self getDocumentsPathWithDirName:name];
    
    NSLog(@"%@",name);
    
    return name;
}

- (NSString *)newFileWithType:(NSString *)type
{
    NSString *documentsPath = [self getVideoPath];
    NSTimeInterval date = [[NSDate date] timeIntervalSince1970];
    NSString *strDate = [NSString stringWithFormat:@"%.0lf.%@",date,type];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:strDate];
    NSLog(@"%@",filePath);
    return filePath;
}

- (NSString *)newFileWithType:(NSString *)type sessionPreset:(NSString *)sessionPreset
{
    NSString *documentsPath = [self getVideoPath];
    NSTimeInterval date = [[NSDate date] timeIntervalSinceDate:[[NSDate alloc] initWithTimeIntervalSince1970:143410000 + 1290690000]];
    NSString *strDate = [NSString stringWithFormat:@"%@_%.0lf.%@",[sessionPreset substringFromIndex:22],date,type];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:strDate];
    NSLog(@"%@",filePath);
    return filePath;
}

#pragma mark - Private Method
// 判断某个文件是否存在
- (BOOL)fileIsExist:(NSString *)filePath
{
    NSFileManager* fm = [NSFileManager defaultManager];
    BOOL isDir;
    BOOL isExist = [fm fileExistsAtPath:filePath isDirectory:&isDir];
    // 存在，且不是文件夹
    return (isExist && !isDir);
}

// 判断数组中是否存在string
- (BOOL)isEqualToString:(NSString *)string InArray:(NSArray *)array
{
    for (NSString *index in array)
    {
        if ([string isEqualToString:index])
        {
            return YES;
        }
    }
    return NO;
}

@end
