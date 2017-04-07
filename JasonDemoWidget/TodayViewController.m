//
//  TodayViewController.m
//  JasonDemoWidget
//
//  Created by jasonwang on 2017/2/28.
//  Copyright © 2017年 jasonwang. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TodayViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置weidget展示大小
    self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 2000);
    [self.view addSubview:self.tableView];
    [self.tableView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 2000)];

    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0) {
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    }
    else {
        
    }
    [self baseRequest];

}
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
//词典转换为字符串
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (void)baseRequest {
    NSURL *url = [NSURL URLWithString:@"http://182.92.8.118:10018/uniqueComservice2/base.do?do=httpInterface&module=patientMsgService&method=getUnReadPatientMsgType"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
//    request.HTTPBody = [[self dictionaryToJson:@{@"param":@"A2468245801BDC06744FBA49EA34528AF04989C4594CC2CE12BED7549037EC685885522E00AA05F996F87F9E7EDCA46586A97E33F9B5EC86E6757C80E542E0413C937A7D9D996705ACA25F689FAEA43FEF5C46752EE671C4ED0AC04523B9D444C6BB0B8A27F90311B46B10718572EF8AE84DC2F61B7AC02B3AEDD42CA1AC96E112B9BC91AB8E09141D4D61635B7798D654FBD741997E7F999163533CC5290A8B6852C6BA1DB58C481872DD2E6B120C27262490967786F0763CAE1FECB7995B873CC9D7655E429AD8A50445BB9BBD90EBA71F6F1B929215A53382AACA609BB7E09206F445A23705E0FB5510A38EE153DBA13ACC9C48C5A9ADAC963331EDD65F7599734E91130B7F7A15952E6E0523BB60E54AB37F8FC66D44"}] dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:@{@"param":@"A2468245801BDC06C2687A604FC5E0A66344342C91773AA86EC35BE9F4D94047D9D9161326FB5C5338077FAEA27175D787C032E119D07AA45A890A4E2ECB09C6B46B10718572EF8A909A51E3DF4DD1C5A5035F0BA29F3B284B83DB8A927D691113B6922FD8E8EC60F02566793B5F4643BFD52928B1E2687B32DA9E70BA321F27E9E911C645A283FDB1978AC7573CC94678741D2E0ABF861681A2B1943115F33F8F866597446B7277267079C642013B246DBA2264ACD760827AD36ECC59036B5005EE3E621399649C4F017E0A146C458CAF18D3792FF726134862DFAE02FE1AEFAF8200C627237C57"} options:0 error:nil]];
    NSURLSession *session = [NSURLSession sharedSession];
    // 由于要先对request先行处理,我们通过request初始化task
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                        completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                            
                                            
                                        }];
    [task resume];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self openURLContainingAPP];
}

- (void)openURLContainingAPP{
    //通过extensionContext借助host app调起app
    [self.extensionContext openURL:[NSURL URLWithString:@"JasonDemo://TTT"] completionHandler:^(BOOL success) {
        NSLog(@"open url result:%d",success);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize{
    
    if (activeDisplayMode == NCWidgetDisplayModeExpanded) {
        
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 2000);
        
    }else{
        
        self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 110);
    }
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}
#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"123"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setSeparatorInset:UIEdgeInsetsZero];
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
        }

    }
    [cell.textLabel setText:@"通知栏提醒"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.00001;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.rowHeight = 75;
    }
    return _tableView;
}
@end
