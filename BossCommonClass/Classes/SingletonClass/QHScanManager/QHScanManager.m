//
//  QHScanManager.m
//  flashman
//
//  Created by 贾远潮 on 2017/8/2.
//  Copyright © 2017年 white. All rights reserved.
//

#import "QHScanManager.h"
#import <AVFoundation/AVFoundation.h>
#import "BossBasicDefine.h"

typedef void(^ResultBlock)(NSArray<NSString *> *resultStrs);

@interface QHScanManager ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *prelayer;

@property (nonatomic, copy) ResultBlock resultBlock;

@property (nonatomic, strong) NSMutableArray *deleteTempLayers;

@property (nonatomic, strong) UIView *scanView;

@end

@implementation QHScanManager

/**单例*/
+ (instancetype)shareScanManager
{
    static QHScanManager *manager = nil;
    static dispatch_once_t oneceToken;
    dispatch_once(&oneceToken, ^{
        manager = [[QHScanManager alloc] init];
    });
    return manager;
}

#pragma mark  -----懒加载
-(NSMutableArray *)deleteTempLayers
{
    if (!_deleteTempLayers) {
        _deleteTempLayers = [NSMutableArray array];
    }
    return _deleteTempLayers;
}

-(AVCaptureDeviceInput *)input
{
    if (!_input) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        _input = [[AVCaptureDeviceInput alloc] initWithDevice:device error:nil];
    }
    return _input;
}

-(AVCaptureMetadataOutput *)output
{
    if (!_output) {
        _output = [[AVCaptureMetadataOutput alloc] init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    }
    return _output;
}

-(AVCaptureSession *)session
{
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        
    }
    return _session;
}

-(AVCaptureVideoPreviewLayer *)prelayer
{
    if (!_prelayer) {
        _prelayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        _prelayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    return _prelayer;
}

/**判断是否有相机权限*/
- (BOOL)hasCamaraPermission
{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        DLog(@"相机权限受限");
        return NO;
    }
    return YES;
}

- (void)beginScanInView:(UIView *)view result:(void(^)(NSArray<NSString *> *resultStrs))resultBlock
{
    
    self.resultBlock = resultBlock;
    self.scanView = view;
    
    if ([self.session canAddInput:self.input] && [self.session canAddOutput:self.output]) {
        [self.session addInput:self.input];
        [self.session addOutput:self.output];
        [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode]];
    }else
    {
        resultBlock([NSArray array]);
        return;
    }
    
    
    if (![view.layer.sublayers containsObject:self.prelayer])
    {
        
        self.prelayer.frame = view.layer.bounds;
        [self.prelayer setBorderColor:kHexRGBA(0xffffff, 0.5).CGColor];
        
        [view.layer insertSublayer:self.prelayer atIndex:0];
    }
    
    [self.session startRunning];
    
}


- (void)stopScan
{
    [self.session stopRunning];
    [self.session removeInput:self.input];
    [self.session removeOutput:self.output];
}

/**重新开始扫描*/
- (void)resetScan
{
    if (_scanView && _resultBlock) {
        [self beginScanInView:self.scanView result:self.resultBlock];
    } else {
        DLog(@"重新扫描失败");
    }
}


-(void)setInsteretRect:(CGRect)originRect
{
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGFloat x = originRect.origin.x / screenBounds.size.width;
    CGFloat y = originRect.origin.y / screenBounds.size.height;
    CGFloat width = originRect.size.width / screenBounds.size.width;
    CGFloat height = originRect.size.height / screenBounds.size.height;
    
    self.output.rectOfInterest = CGRectMake(y, x, height, width);
}

- (BOOL)managerIsScanning
{
    BOOL scanning;
    if ([self.session isRunning]) {
        scanning = YES;
    } else {
        scanning = NO;
    }
    return scanning;
}

- (void)systemLightSwitch:(BOOL)open
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        if (open) {
            [device setTorchMode:AVCaptureTorchModeOn];
        } else {
            [device setTorchMode:AVCaptureTorchModeOff];
        }
        [device unlockForConfiguration];
    }
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSMutableArray *resultStrs = [NSMutableArray array];
    for (AVMetadataMachineReadableCodeObject *obj in metadataObjects)
    {
        [resultStrs addObject:obj.stringValue];
    }
    if (resultStrs && resultStrs.count > 0 && self.resultBlock) {
        self.resultBlock(resultStrs);
    }
}

/**
 开始扫描的方法 （自动对当前设备是否支持进行校验）
 
 @param inputRect 扫描的扫描点
 @param scanView 扫描的页面
 @param viewController 不支持设备弹框警告的控制器
 @param resultBlock 扫描结果
 */
- (void)startScanWithInputRect:(CGRect)inputRect scanView:(UIView *)scanView viewController:(UIViewController *)viewController result:(void(^)(NSArray<NSString *> *resultStrs))resultBlock
{
    [[QHScanManager shareScanManager] setInsteretRect:inputRect];
    if ([[QHScanManager shareScanManager] hasCamaraPermission]) {
        [[QHScanManager shareScanManager] beginScanInView:scanView result:resultBlock];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置中打开相机权限，如果确认已经开启权限，请重启app" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *setUpAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [viewController.navigationController popViewControllerAnimated:YES];
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]])
            {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }
        }];
        [alert addAction:cancelAction];
        [alert addAction:setUpAction];
        [viewController presentViewController:alert animated:YES completion:nil];
    }
}

@end
