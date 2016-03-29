//
//  MyToolBar.h
//  Shape
//
//  Created by jasonwang on 15/10/23.
//  Copyright © 2015年 jasonwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyToolBarDelegate <NSObject>

@optional

- (void)MyToolBarDelegateCallBack_CancelClick;
- (void)MyToolBarDelegateCallBack_SaveClick;

- (void)MyToolBarDelegateCallBack_CancelClickWithTag:(NSInteger)tag;
- (void)MyToolBarDelegateCallBack_SaveClickWithTag:(NSInteger)tag;

@end

@interface MyToolBar : UIToolbar
@property (nonatomic, weak) id <MyToolBarDelegate>  MyDelegate;
- (void)setMyTitel:(NSString *)titel;

@end
