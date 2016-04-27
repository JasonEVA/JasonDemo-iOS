//
//  UnifiedEggHuntManager.h
//  launcher
//
//  Created by williamzhang on 15/12/24.
//  Copyright © 2015年 William Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnifiedEggHuntManager : NSObject

/**
 *  审查是否需要彩蛋
 *
 *  @param string     审查语句
 *  @param targetView 彩蛋添加目标View
 */
+ (void)reviewKeywordFrom:(NSString *)reviewString TargetView:(UIView *)targetView;

@end
