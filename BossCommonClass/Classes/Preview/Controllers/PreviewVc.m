//
//  PreviewVc.m
//  BossManager
//  附件在线预览页
//
//  Created by 贾远潮 on 2018/8/14.
//  Copyright © 2018年 贾远潮. All rights reserved.
//

#import "PreviewVc.h"
#import "BossBasicDefine.h"
#import "AFURLSessionManager.h"
#import <QuickLook/QuickLook.h>
#import "HWIFileDownloader.h"

@interface PreviewVc ()<HWIFileDownloadDelegate, QLPreviewControllerDataSource, QLPreviewControllerDelegate>

@property (nonatomic, strong) NSURL *fileUrl;

@property (nonatomic, strong) HWIFileDownloader *fileDownloader;

@end

@implementation PreviewVc

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"在线预览";
    
    NSString *excelDirectory = [NSString stringWithFormat:@"%@/conract",kDocumentPath];
    BOOL isDirectory;
    if ([[NSFileManager defaultManager] fileExistsAtPath:excelDirectory isDirectory:&isDirectory]) {
        if (!isDirectory) {
            [[NSFileManager defaultManager] createDirectoryAtPath:[NSString stringWithFormat:@"%@/conract",kDocumentPath] withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }else {
        [[NSFileManager defaultManager] createDirectoryAtPath:[NSString stringWithFormat:@"%@/conract",kDocumentPath] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *subStr = [self.fileURLStr substringToIndex:[self.fileURLStr rangeOfString:@"?"].location];
    NSString *fileName = [subStr substringFromIndex:[subStr rangeOfString:@"/" options:NSBackwardsSearch].location + 1];
    NSString *localFilePath = [NSString stringWithFormat:@"%@/conract/%@",kDocumentPath,fileName];
    
    NSLog(@"localFilePath : %@", localFilePath);
    
//    if([[NSFileManager defaultManager] fileExistsAtPath:localFilePath]){
//        self.fileUrl = [NSURL fileURLWithPath:localFilePath];
//        [self previewFile];
//        return;
//    }
    
    [self.view showLoadingView:@"加载中..."];
    self.fileDownloader = [[HWIFileDownloader alloc] initWithDelegate:self];
    [self.fileDownloader startDownloadWithIdentifier:fileName fromRemoteURL:[NSURL URLWithString:self.fileURLStr]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.fileDownloader invalidateSessionConfigurationAndCancelTasks:true];
    
}

#pragma mark - QLPreviewController 代理方法
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    return self.fileUrl;
}

#pragma mark - HWIFileDownloader 代理方法
- (void)incrementNetworkActivityIndicatorActivityCount
{
    
}
- (void)decrementNetworkActivityIndicatorActivityCount
{
    
}

- (void)customizeBackgroundSessionConfiguration:(NSURLSessionConfiguration *)backgroundSessionConfiguration {
    backgroundSessionConfiguration.allowsCellularAccess = true;
}

- (void)onAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge downloadIdentifier:(NSString *)downloadIdentifier completionHandler:(void (^)(NSURLCredential * _Nullable, NSURLSessionAuthChallengeDisposition))completionHandler
{
    NSLog(@" onAuthenticationChallenge : %@", downloadIdentifier);
    
    
    completionHandler([NSURLCredential credentialWithUser:downloadIdentifier password:downloadIdentifier persistence:NSURLCredentialPersistenceNone], NSURLSessionAuthChallengeUseCredential);
}

- (void)downloadDidCompleteWithIdentifier:(NSString *)identifier localFileURL:(NSURL *)localFileURL
{
    NSLog(@"download completed");
    
    [self.view dismissLoadingViewWithCompletion:nil];
    
    self.fileUrl = localFileURL;
    if(![QLPreviewController canPreviewItem:self.fileUrl]){
        [self.view showAnimationErrorStaus:@"该文件格式不支持！" completion:^(BOOL finish) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        return;
    }
    
    [self previewFile];
}

- (void)downloadFailedWithIdentifier:(NSString *)identifier error:(NSError *)error httpStatusCode:(NSInteger)httpStatusCode errorMessagesStack:(NSArray<NSString *> *)errorMessagesStack resumeData:(NSData *)resumeData
{
    NSLog(@"errorCode : %ld, errorMsg : %@", error.code, error.userInfo);
    
    [self.view dismissLoadingViewWithCompletion:^(BOOL finish) {
        [self.view showAnimationErrorStaus:@"文件下载失败！" completion:^(BOOL finish) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
}

- (NSURL *)localFileURLForIdentifier:(NSString *)identifier remoteURL:(NSURL *)remoteURL
{
    
    NSString *localFilePath = [NSString stringWithFormat:@"%@/conract/%@",kDocumentPath,identifier];
    
    return [NSURL fileURLWithPath:localFilePath];
}

- (void)downloadProgressChangedForIdentifier:(nonnull NSString *)aDownloadIdentifier
{
    NSLog(@"downloadProgressChangedForIdentifier aDownloadIdentifier : %@", aDownloadIdentifier);
}

- (void)downloadPausedWithIdentifier:(nonnull NSString *)aDownloadIdentifier
                          resumeData:(nullable NSData *)aResumeData
{
   NSLog(@"downloadPausedWithIdentifier aDownloadIdentifier : %@", aDownloadIdentifier);
}

- (void)resumeDownloadWithIdentifier:(nonnull NSString *)aDownloadIdentifier
{
    NSLog(@"resumeDownloadWithIdentifier aDownloadIdentifier : %@", aDownloadIdentifier);
}

#pragma mark -- private

- (void)previewFile
{
    QLPreviewController *qlVc = [[QLPreviewController alloc] init];
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.size.height -= kIsiPhoneX ? 40 : kStatusBarHeight + 40;
    rect.origin.y -= kIsiPhoneX ? kStatusBarHeight : 0;
    qlVc.view.frame = rect;
    qlVc.delegate = self;
    qlVc.dataSource = self;
    qlVc.navigationController.navigationBar.userInteractionEnabled = YES;
    qlVc.view.userInteractionEnabled = YES;
    
    [self addChildViewController:qlVc];
    [self.view addSubview:qlVc.view];
}

@end
