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
@protocol MintMedicalDocToolWebViewSExportProtocol <JSExport>

- (void)getToolName:(NSString *)title;

@end

@protocol MedicalFormulaJSModelDelegate <NSObject>

- (void)MedicalFormulaJSModelDelegateCallBack_titel:(NSString *)titel;

@end

@interface MedicalFormulaJSModel : NSObject <MintMedicalDocToolWebViewSExportProtocol>
@property (nonatomic, weak)id<MedicalFormulaJSModelDelegate> delegate;
@property (nonatomic, weak) JSContext *jsContext;
@property (nonatomic, weak) UIWebView *webView;
@end
