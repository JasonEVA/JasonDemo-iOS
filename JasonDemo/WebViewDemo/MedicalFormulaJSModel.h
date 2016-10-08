//
//  MedicalFormulaJSModel.h
//  MintmedicalSDK
//
//  Created by jasonwang on 16/8/16.
//  Copyright © 2016年 JasonWang. All rights reserved.
//  js注入模型 防止内存泄漏

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
@class UIWebView;
@protocol MintMedicalDocToolWebViewSExportProtocol <JSExport> //这是一个协议，如果采用协议的方法交互，自己定义的协议必须遵守此协议
//方法名需要和web前端协商定好一样，否则调用不到
- (void)getToolName:(NSString *)title;
- (void)goToPrescribeWithUserId:(NSString *)userId :(NSString *)healthyId;
@end

@protocol MedicalFormulaJSModelDelegate <NSObject>   //模型的回调方法

- (void)MedicalFormulaJSModelDelegateCallBack_titel:(NSString *)titel;

@end

@interface MedicalFormulaJSModel : NSObject <MintMedicalDocToolWebViewSExportProtocol>
@property (nonatomic, weak)id<MedicalFormulaJSModelDelegate> delegate;
@property (nonatomic, weak) JSContext *jsContext;
@property (nonatomic, weak) UIWebView *webView;
@end
