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
+ (void)authRequestLoginWithPhoneNumber:(NSString *)phoneNumber authCode:(NSString *)authCode success:(void (^)(NNBAccount *accountInfo))successBlock fail:(void(^)(id error))fail
{
    if (!phoneNumber || !authCode) {
        return;
    }
    NSDictionary *paramDic = @{
                               @"mobile":phoneNumber,
                               @"verify_code":authCode
                               };
    [NNBBasicRequest postLoginJsonWithUrl:BossBasicURL parameters:paramDic CMD:@"auth.account.login" success:^(id responseObject) {
        if ([self saveAccountInfoWithAccountDic:responseObject]) {
            if (successBlock) {
                successBlock(kCurrentAccount);
            }
        } else {
#ifdef NNBSELLER
            /* 销售版*/
            [[NNBSimpleToolClass getCurrentVC].view showStatus:@"当前账号没有地推销售权限"];
#elif defined NNBKNIGHT
            /* 骑士版*/
            [[NNBSimpleToolClass getCurrentVC].view showStatus:@"当前账号不具备骑士权限"];
#else
            /* 预留的其他app */
            
#endif
        }
    } fail:^(id error) {
        if (fail) {
            fail(error);
        }
    }];
}

+ (BOOL)saveAccountInfoWithAccountDic:(NSDictionary *)dic
{
    BOOL isSeller = NO;
    for (NSNumber *role in dic[@"roles"]) {
#ifdef NNBSELLER
        /* 销售版 */
        if ([role integerValue] == ACCOUNT_ROLE_SALES_MAN) {
            isSeller = YES;
            break;
        }
#elif defined NNBKNIGHT
        /* 骑士版 */
        if ([role integerValue] == ACCOUNT_ROLE_STORE_MAN_COURIER) {
            isSeller = YES;
            break;
        }
#else
        /* 预留的其他app */
        
#endif

    }
    if (!isSeller) {
        return isSeller;
    }
    [kCurrentAccount setValuesForKeysWithDictionary:dic];
    
    NSDictionary *localAccountInfoDic = @{
                                          @"account_id":dic[@"account_id"]?:@(0),
                                          @"name":dic[@"name"]?:@"",
                                          @"access_token":dic[@"access_token"]?:@"",
                                          @"mobile":dic[@"mobile"]?:@"",
                                          @"refresh_token":dic[@"refresh_token"]?:@"",
                                          @"expired_at":dic[@"expired_at"]?:@"",
                                          @"roles":dic[@"roles"]?:@[],
                                          @"account_info":@{@"city_code":dic[@"account_info"][@"city_code"]?:@""},
                                          };
    
    [kUserDefault setObject:localAccountInfoDic forKey:AccountInfoKey];
    
    [[NNBRequestManager shareNNBRequestManager] saveToken:kCurrentAccount.access_token refrech_token:kCurrentAccount.refresh_token expired_at:kCurrentAccount.expired_at];
    return isSeller;
}

@end
