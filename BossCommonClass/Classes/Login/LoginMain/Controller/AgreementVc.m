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
#import "JYCMethodDefine.h"

@interface AgreementVc ()

@end

@implementation AgreementVc


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;

    [self.navigationController setToolbarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isAddPresent){
        [self setBackItem];
    }
    self.view.backgroundColor = [UIColor whiteColor];
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    [self.view addGestureRecognizer:pan];
    
    if (!self.url) {
        self.url = AGREEMENTURL;
    }
    CGFloat webviewHeight = kScreenHeight - 64;
    if (kIsiPhoneX){
        webviewHeight = kScreenHeight - 64 - 34;
    }
//    CGRect bounds = [[UIScreen mainScreen]applicationFrame];
    WKWebView* webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, webviewHeight)];
    webView.backgroundColor = [UIColor whiteColor];
//    webView.scalesPageToFit = YES;//自动对页面进行缩放以适应屏幕
    NSURL* url = [NSURL URLWithString: self.url];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [webView loadRequest:request];//加载
    [self.view addSubview:webView];
}

-(void)setBackItem
{
    UIBarButtonItem *buttonItem_back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"popBack"] style:UIBarButtonItemStyleDone target:self action:@selector(popToLastViewController:)];
    [buttonItem_back setTintColor:[UIColor blackColor]];
    self.navigationItem.leftBarButtonItem = buttonItem_back;
}


- (void)popToLastViewController:(UIBarButtonItem *)sender
{
    if (self.backBlock){
        self.backBlock();
    }
    [self.navigationController popViewControllerAnimated:YES];

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
