//
//  NNBRequestManager.h
//  NNBar_knight
//
//  Created by 贾远潮 on 2017/9/19.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

UIKIT_EXTERN float const kNetworkTimeoutInterval;

@interface NNBRequestManager : AFHTTPSessionManager

/**
 单例类创建
 
 @return 单例对象
 */
+ (__kindof NNBRequestManager *)shareNNBRequestManager;

/**
 添加token

 @param cmd 请求的服务
 */
- (void)addTokenWithCMD:(NSString *)cmd;

/**
 判断accountTocken是否过期
 
 @param expired_atString 过期时间的时间戳
 @return 是否过期
 */
- (BOOL)accountTockenIsExpiredWithExpired_at:(NSString *)expired_atString;

/**
 保存token
 
 @param token app的接入token
 @param refresh_token 刷新的token
 @param expired_at 过期时间
 */
- (void)saveToken:(NSString *)token
    refrech_token:(NSString *)refresh_token
       expired_at:(NSString *)expired_at;

/**
 清除token
 */
- (void)cleanToken;


@end
