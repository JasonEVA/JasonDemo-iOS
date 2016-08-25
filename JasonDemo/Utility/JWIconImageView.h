//
//  JWIconImageView.h
//  JasonDemo
//
//  Created by jasonwang on 16/8/25.
//  Copyright © 2016年 jasonwang. All rights reserved.
//  使用ICONFONT管理图标类

#import <UIKit/UIKit.h>

@interface JWIconImageView : UILabel
/**
 *  通过设置自定义字体来实现图标显示，代替之前使用UIImageView显示图标
 *  参考教程：http://www.iconfont.cn/help/iconuse.html
 *
 *  @param iconName  图标对应文本值（Unicode 字符）
 
 这里有两个地方注意下：
 创建 UIFont 使用的是字体名，而不是文件名；
 文本值为 8 位的 Unicode 字符，我们可以打开 demo.html 查找每个图标所对应的 HTML 实体 Unicode 码，比如：
 
 "店" 对应的 HTML 实体 Unicode 码为：
 
 0x3439
 
 转换后Unicode 字符为
 
 \U00003439
 
 就是将 0x 替换为 \U 中间用 0 填补满长度为 8 个字符
 
 *  @param iconColor 图标颜色
 *  @param iconSize  图标大小
 *
 *  @return 图标label
 */
- (instancetype)initWithIconName:(NSString *)iconName iconColor:(UIColor *)iconColor iconSize:(CGFloat)iconSize;
@end
