//
//  QHScanManager.h
//  flashman
//
//  Created by 贾远潮 on 2017/8/2.
//  Copyright © 2017年 white. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QHScanManager : NSObject

+ (instancetype)shareScanManager;

/**判断是否有相机权限*/
- (BOOL)hasCamaraPermission;

/**开始扫描*/
- (void)beginScanInView:(UIView *)view result:(void(^)(NSArray<NSString *> *resultStrs))resultBlock;

/**停止扫描*/
- (void)stopScan;

/**重新开始扫描*/
- (void)resetScan;

/**设置兴趣点*/
- (void)setInsteretRect:(CGRect)originRect;

/**获取manager是否正在扫描*/
- (BOOL)managerIsScanning;

/**
 灯光是否打开

 @param open YES 开 NO 关
 */
- (void)systemLightSwitch:(BOOL)open;

/**
 开始扫描的方法 （自动对当前设备是否支持进行校验）

 @param inputRect 扫描的扫描点
 @param scanView 扫描的页面
 @param viewController 不支持设备弹框警告的控制器
 @param resultBlock 扫描结果
 */
- (void)startScanWithInputRect:(CGRect)inputRect scanView:(UIView *)scanView viewController:(UIViewController *)viewController result:(void(^)(NSArray<NSString *> *resultStrs))resultBlock;


@end
