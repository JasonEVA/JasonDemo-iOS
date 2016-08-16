//
//  WebViewDemoViewController.h
//  JasonDemo
//
//  Created by jasonwang on 16/8/15.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol MintMedicalDocToolWebViewSExportProtocol <JSExport>

- (void)getToolName:(NSString *)title;

@end

@interface WebViewDemoViewController : UIViewController <MintMedicalDocToolWebViewSExportProtocol>

@end
