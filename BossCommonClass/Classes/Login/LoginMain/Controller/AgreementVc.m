//
//  AgreementVc.m
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/5/7.
//

#import "AgreementVc.h"
#import "BossConstDataDefine.h"
#import "AFHTTPSessionManager.h"
#import <WebKit/WebKit.h>

@interface AgreementVc ()

@end

@implementation AgreementVc
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    [self.view addGestureRecognizer:pan];
    
    if (!self.url) {
        self.url = AGREEMENTURL;
    }
//    CGRect bounds = [[UIScreen mainScreen]applicationFrame];
    WKWebView* webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50)];
//    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    NSURL* url = [NSURL URLWithString: self.url];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];//加载
    [self.view addSubview:webView];
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
