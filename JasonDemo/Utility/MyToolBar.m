//
//  MyToolBar.m
//  Shape
//
//  Created by jasonwang on 15/10/23.
//  Copyright © 2015年 jasonwang. All rights reserved.
//

#import "MyToolBar.h"
#import "UIColor+Hex.h"

typedef NS_ENUM(NSInteger, buttonTag) {
    cancelTag = 2000,
    confirmTag
    
};

@implementation MyToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
            }
    return self;
}

- (void)setMyTitel:(NSString *)titel
{
    [self setBackgroundColor:[UIColor whiteColor]];
    UIBarButtonItem *fixedButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target: nil action: nil];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]
                                     
                                     initWithTitle:@"取消"
                                     
                                     style:UIBarButtonItemStylePlain
                                     
                                     target:self
                                     
                                     action:@selector(action:)];
    //[cancelButton setTintColor:[UIColor themeOrange_ff5d2b]];
    [cancelButton setTag:cancelTag];
    
    UIBarButtonItem *confirmButton = [[UIBarButtonItem alloc]
                                      
                                      initWithTitle:@"确定"
                                      
                                      style:UIBarButtonItemStylePlain
                                      
                                      target:self
                                      
                                      action:@selector(action:)];
    //[confirmButton setTintColor:[UIColor themeOrange_ff5d2b]];
    [confirmButton setTag:confirmTag];
    UIBarButtonItem *titelButton = [[UIBarButtonItem alloc]
                                    
                                    initWithTitle:titel
                                    
                                    style:UIBarButtonItemStylePlain
                                    
                                    target:nil
                                    
                                    action:nil];
    [titelButton setTintColor:[UIColor blackColor]];
    
    NSArray *myToolBarItems = [NSArray arrayWithObjects:cancelButton,fixedButton,titelButton,fixedButton,confirmButton, nil];
    [self setItems:myToolBarItems animated:YES];

}

- (void)action:(UIBarButtonItem *)button
{
    if (button.tag == confirmTag) {
        if ([self.MyDelegate respondsToSelector:@selector(MyToolBarDelegateCallBack_SaveClick)]) {
            [self.MyDelegate MyToolBarDelegateCallBack_SaveClick];
        }
        if ([self.MyDelegate respondsToSelector:@selector(MyToolBarDelegateCallBack_SaveClickWithTag:)]) {
            [self.MyDelegate MyToolBarDelegateCallBack_SaveClickWithTag:self.tag];
        }

        
    }
    else if (button.tag == cancelTag)
    {
        if ([self.MyDelegate respondsToSelector:@selector(MyToolBarDelegateCallBack_CancelClick)]) {
            [self.MyDelegate MyToolBarDelegateCallBack_CancelClick];
        }
        if ([self.MyDelegate respondsToSelector:@selector(MyToolBarDelegateCallBack_CancelClickWithTag:)]) {
            [self.MyDelegate MyToolBarDelegateCallBack_CancelClickWithTag:self.tag];
        }

    }
    
}


@end
