//
//  RequestTestViewController.m
//  JasonDemo
//
//  Created by jasonwang on 2017/3/17.
//  Copyright © 2017年 jasonwang. All rights reserved.
//

#import "RequestTestViewController.h"
#import <AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface RequestTestViewController ()
@property (nonatomic, strong) UILabel *waitingView;
@end

@implementation RequestTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.waitingView = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].applicationFrame.size.width / 2 - 25, [UIScreen mainScreen].applicationFrame.size.height / 2 - 25, 100, 100)];
    [self.waitingView setText:@"请求中"];
    [self.view addSubview:self.waitingView];
    NSString *URL = @"http://182.92.8.118:10018/uniqueComservice2/base.do?do=httpInterface&module=patientMsgService&method=getUnReadPatientMsgType";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString* strEncode = @"A2468245801BDC06C2687A604FC5E0A66344342C91773AA86EC35BE9F4D94047D9D9161326FB5C5338077FAEA27175D787C032E119D07AA45A890A4E2ECB09C6B46B10718572EF8A909A51E3DF4DD1C5A5035F0BA29F3B284B83DB8A927D691113B6922FD8E8EC60F02566793B5F4643BFD52928B1E2687B32DA9E70BA321F27E9E911C645A283FDB1978AC7573CC94678741D2E0ABF861681A2B1943115F33F8F866597446B7277267079C642013B246DBA2264ACD760827AD36ECC59036B5005EE3E621399649C4F017E0A146C458CAF18D3792FF726134862DFAE02FE1AEFAF8200C627237C57";

    NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:strEncode, @"param", nil];
    [self.waitingView setHidden:NO];
    [manager POST:URL parameters:postDict progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.waitingView setText:@"请求成功"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.waitingView setText:@"请求失败"];
    }];
    
    // Do any additional setup after loading the view.
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
