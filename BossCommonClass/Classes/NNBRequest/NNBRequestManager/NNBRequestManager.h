//
//  NNBRequestManager.h
//  NNBar_knight
//
//  Created by 贾远潮 on 2017/9/19.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "SaasModel.h"

UIKIT_EXTERN float const kNetworkTimeoutInterval;

@interface NNBRequestManager : AFHTTPSessionManager

/**
 单例类创建
 
 @return 单例对象
 */
+ (__kindof NNBRequestManager *)shareNNBRequestManager;

@property (nonatomic, strong) SaasModel *saasModel;

@property (nonatomic, readonly) NSString *url;

- (NSString *)getUrlByApiVersion:(NSString *)apiVersion;

/**
 添加token

 @param cmd 请求的服务
 */
- (void)addTokenWithCMD:(NSString *)cmd;

@end
