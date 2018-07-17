//
//  NNBAuthRequest.m
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/27.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "NNBAuthRequest.h"
#import "NNBBasicRequest.h"
#import "NNBRequestManager.h"
#import "QHErrorView.h"

@implementation NNBAuthRequest

/**
 登录接口
 
 @param phoneNumber 手机号
 @param authCode 验证码
 @param successBlock 成功的回调（返回当前登录用户的信息，是单例类 也可以用[NNBAccount defaultAccount]获取）
 */
+ (void)authRequestLoginWithPhoneNumber:(NSString *)phoneNumber authCode:(NSString *)authCode success:(void (^)(id accountInfo))successBlock fail:(void(^)(id error))fail
{
    if (!phoneNumber || !authCode) {
        return;
    }
    
#ifdef kBossKnight
    NSString *url = [NSString stringWithFormat:@"%@auth/app_login",BossBasicURL];
#elif defined kBossManager
    NSString *url = [NSString stringWithFormat:@"%@auth/login",BossBasicURL];
#else
    NSString *url = [NSString stringWithFormat:@"%@auth/app_login",BossBasicURL];
#endif


    NSDictionary *paramDic = @{
                               @"phone":phoneNumber,
                               @"verify_code":authCode,
                               @"app_code":APPCODE
                               };
    [NNBBasicRequest postLoginJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
        if ([NNBRequestManager saveAccountInfoWithAccountDic:responseObject]) {
#ifdef kBossKnight
            kCurrentAccount.isNeedUpdate = NO;
            if (successBlock) {
                successBlock(kCurrentAccount);
            }
#elif defined kBossManager
            kCurrentBossAccount.isNeedUpdate = NO;
            if (successBlock) {
                successBlock(kCurrentBossAccount);
            }
#else
            kCurrentAccount.isNeedUpdate = NO;
            if (successBlock) {
                successBlock(kCurrentAccount);
            }
#endif
        } else {
            
        }
    } fail:^(id error) {
        if (fail) {
            fail(error);
        }
    }];
}

@end
