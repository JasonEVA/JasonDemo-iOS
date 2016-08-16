//
//  WebViewDemoViewController.m
//  JasonDemo
//
//  Created by jasonwang on 16/8/15.
//  Copyright © 2016年 jasonwang. All rights reserved.
//

#import "WebViewDemoViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface WebViewDemoViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)UIWebView *webView;
@property (nonatomic, weak) JSContext *context;

@end

@implementation WebViewDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setHidesBackButton:YES];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backArrow"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    [self.navigationItem setLeftBarButtonItem:leftBtn];

    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.delegate = self;
    NSURL *url = [NSURL URLWithString:@"http://59.63.163.44:8084/doctortoolslist"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.webView.scalesPageToFit = YES;
    [self.webView loadRequest:request];
    
    [self.view addSubview:self.webView];
    [self.navigationItem setTitle:@"医学公式"];
    // Do any additional setup after loading the view.
}
- (void)backClick {
    if (self.webView.canGoBack) {
        [self.webView goBack];
        [self.navigationItem setTitle:@"医学公式"];
    }
    else {
        if (self.navigationController.childViewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            return;
        }
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    self.context.exceptionHandler =
    ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
        NSLog(@"%@", exceptionValue);
    };
    self.context[@"NCClientJS"] = self;
    
//    NSString *jsStr = @"window.NCClientJS.getToolName(title)";
//    [self.context evaluateScript:jsStr];

}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}


- (void)getToolName:(NSString *)title{
    
    self.navigationItem.title = title;

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
