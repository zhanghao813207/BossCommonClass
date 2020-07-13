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

@interface AgreementVc ()<WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation AgreementVc


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setToolbarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isAddPresent){
        [self setBackItem];
    }
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:traget action:nil];
    [self.view addGestureRecognizer:pan];
    
    if (!self.url) {
        self.url = AGREEMENTURL;
    }
    CGFloat webviewHeight = kScreenHeight - 64;
//    if (kIsiPhoneX){
//        webviewHeight = kScreenHeight - 64;
//    }
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, webviewHeight)];
    self.webView.backgroundColor =  [UIColor colorNamed:@"bgcolor_FFFFFF_000000"];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.opaque = NO;
    NSURL* url = [NSURL URLWithString: self.url];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    [self.webView loadRequest:request];//加载
    [self.view addSubview:self.webView];
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

#pragma mark - Web代理
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    // 加载成功后暗黑适配
    if (@available(iOS 12.0, *)) {
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            [self changeThemeToType:@"dark"];
        }else {
            [self changeThemeToType:@"light"];
        }
    }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    if (@available(iOS 12.0, *)) {
        if (previousTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            [self changeThemeToType:@"light"];
        }else {
            [self changeThemeToType:@"dark"];
        }
    }
}

// 切换黑白主题
- (void)changeThemeToType:(NSString *)style {
    if ([style isEqualToString:@"dark"]) {
        [self.webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#F8F8FF'" completionHandler:nil];
        [self.webView evaluateJavaScript:@"document.body.style.backgroundColor=\"#1E1E1E\"" completionHandler:nil];
    }else {
        [self.webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#000000'" completionHandler:nil];
        [self.webView evaluateJavaScript:@"document.body.style.backgroundColor=\"#FFFFFF\"" completionHandler:nil];
    }
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
