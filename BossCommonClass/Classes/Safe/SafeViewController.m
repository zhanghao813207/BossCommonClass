//
//  SafeViewController.m
//  BossManager
//
//  Created by 易庆萍 on 2020/5/26.
//  Copyright © 2020 欧客云. All rights reserved.
//

#import "SafeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <WebKit/WebKit.h>
#import "WKWebViewJavascriptBridge.h"
#import "NSString+base.h"
#import "BossBasicDefine.h"
#import "AFNetworking.h"
#import "SafeTipViewController.h"

API_AVAILABLE(ios(8.0))
@interface SafeViewController ()<WKNavigationDelegate,WKUIDelegate>
// WKwebview
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) WKWebViewConfiguration *configuration;
// jsBridge的方式跟JS交互
@property (nonatomic, strong) WKWebViewJavascriptBridge* bridge;

@property (nonatomic, strong) UIProgressView *progress;//加载进度

@property (nonatomic, strong) NSString *safeUrl;

@end

@implementation SafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kHexRGBA(0xFFFFFF, 1);
    self.safeUrl = @"https://emcs.pa18.com/ust?key=12005120000000577887&appType=01";
    [self configJsBridge];
    //kvo监听，获得页面加载进度值和title
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    [self netWorkStartMonitor];
    
    SafeTipViewController *safeTipVC = [[SafeTipViewController alloc]init];
    [self.navigationController presentViewController:safeTipVC animated:YES completion:nil];
}

// 监测网络连接状况
- (void)netWorkStartMonitor{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable){
            [self.view showAnimationErrorStaus:@"网络已断开,请检查网络连接状态" completion:nil];
        }
    }];
}

-(void)configJsBridge{
    self.configuration = [[WKWebViewConfiguration alloc] init];
    self.configuration.userContentController = [WKUserContentController new];
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptEnabled = YES;
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    self.configuration.preferences = preferences;
    
    // 禁用长按手势
    NSMutableString *javascript = [NSMutableString string];
    [javascript appendString:@"document.documentElement.style.webkitTouchCallout='none';"]; //禁止长按
    WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:javascript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    [self.configuration.userContentController addUserScript:noneSelectScript];
    
    CGFloat webHeight = kScreenHeight - 64 ;
    if (kIsiPhoneX){
        webHeight = kScreenHeight - 88 - 34 ;
    }
    // 初始化WkWebView
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, webHeight) configuration:self.configuration];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.safeUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    [WKWebViewJavascriptBridge enableLogging];
    // 建立 WKWebViewJavascriptBridge 和 WebView 之间的关系。
    _bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
    [_bridge setWebViewDelegate:self];
    [self.view addSubview:self.webView];
    [self.webView loadRequest:req];
}

#pragma mark - 标签直接调起打电话和支付宝支付
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void(^)(WKNavigationActionPolicy))decisionHandler{
    NSURL *url = navigationAction.request.URL;
    NSString *scheme = [url scheme];
    if ([scheme isEqualToString:@"tel"]) {
        NSString *resourceSpecifier = [url resourceSpecifier];
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", resourceSpecifier];
        /// 防止iOS 10及其之后，拨打电话系统弹出框延迟出现
        dispatch_async(dispatch_get_main_queue() , ^{
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:nil completionHandler:^(BOOL success) {}];
            }
        });
    }else if([scheme isEqualToString:@"alipay"] || [scheme isEqualToString:@"alipays"]){//  则跳转到本地支付宝App
         // 跳转支付宝App
         NSString *requestUrl = url.absoluteString;
         //  以？号来切割字符串
         NSArray *urlBaseArr = [requestUrl componentsSeparatedByString:@"?"];
         if (urlBaseArr.count > 0){
             NSString *urlBaseStr = urlBaseArr.firstObject;
             NSString *urlNeedDecode = urlBaseArr.lastObject;
             //  将截取以后的Str，做一下URLDecode，方便处理数据
             NSMutableString *afterDecodeStr = [NSMutableString stringWithString:[self URLDecodedString:urlNeedDecode]];
             //  替换里面的默认Scheme为自己的Scheme
             NSString *afterHandleStr = [afterDecodeStr stringByReplacingOccurrencesOfString:@"alipays" withString:BUNDLEID];
             //  然后把处理后的，和最开始切割的做下拼接，就得到了最终的字符串
             NSString *finalStr = [NSString stringWithFormat:@"%@?%@",urlBaseStr, [self  URLEncodeString:afterHandleStr]];
             
             BOOL isSucc = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:finalStr]];
             if (isSucc) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     if (@available(iOS 10.0, *)) {
                         [[UIApplication sharedApplication]openURL:[NSURL URLWithString:finalStr] options:nil completionHandler:^(BOOL success) {}];
                     }
                 });
             }
         }
     }else if([scheme isEqualToString:@"weixin"] ){
         /// 防止iOS 10及其之后，拨打电话系统弹出框延迟出现
                dispatch_async(dispatch_get_main_queue() , ^{
                    if (@available(iOS 10.0, *)) {
                        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url.absoluteString] options:nil completionHandler:^(BOOL success) {}];
                    }
                });
     }
    
  decisionHandler(WKNavigationActionPolicyAllow);
}
//  URLEncode的方法
-  (NSString *)URLEncodeString:(NSString*)str{
    NSString *unencodedString = str;
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)unencodedString,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
    return encodedString;
}

- (NSString*)URLDecodedString:(NSString*)str {
    NSString *decodedString = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}


#pragma mark - 返回

- (void)popToLastViewController:(UIBarButtonItem *)sender
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark KVO的监听代理 -- 网页加载进度
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]){//加载进度值
        if (object == self.webView){
            [self.progress setAlpha:1.0f];
            [self.progress setProgress:self.webView.estimatedProgress animated:YES];
            if(self.webView.estimatedProgress >= 1.0f){
                [UIView animateWithDuration:0.5f
                                      delay:0.3f
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                    [self.progress setAlpha:0.0f];
                }completion:^(BOOL finished){
                    [self.progress setProgress:0.0f animated:NO];
                }];
            }
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else if ([keyPath isEqualToString:@"title"]){//网页title
        if (object == self.webView){
            self.navigationItem.title = self.webView.title;
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (UIProgressView *)progress
{
    if (_progress == nil){
        _progress = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 2)];
        _progress.tintColor = [UIColor blueColor];
        _progress.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:_progress];
    }
    return _progress;
}

- (void)dealloc{
    
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

@end


