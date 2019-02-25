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
#import "BossAccountRequest.h"
#import "BossKnightAccount.h"
#import "BossManagerAccount.h"
#import "BossCache.h"
#import "SaasModel.h"

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

    NSDictionary *paramDic = @{
                               @"phone":phoneNumber,
                               @"verify_code":authCode,
                               @"app_code":APPCODE
                               };
    
    [NNBBasicRequest postLoginJsonWithUrl:kUrl parameters:paramDic CMD:[self cmdRequest] success:^(id responseObject) {

         NSLog(@"postLoginJsonWithUrl->response\n%@", responseObject);
        
#ifdef kBossKnight
        if ([NNBRequestManager saveAccountInfoWithAccountDic:responseObject]) {
            kCurrentBossKnightAccount.isNeedUpdate = NO;
            if (successBlock) {
                successBlock(kCurrentBossKnightAccount);
            }
        } else {

        }
#elif defined kBossManager
        kCurrentBossManagerAccount.isNeedUpdate = NO;
        
        TokenModel *token = [[TokenModel alloc] init];
        [token setValuesForKeysWithDictionary:responseObject];
        
        
//        NSDictionary *dic = @{
//                              @"account_id":responseObject[@"account_id"],
//                              @"access_token":responseObject[@"access_token"],
//                              @"refresh_token":responseObject[@"refresh_token"],
//                              @"expired_at":responseObject[@"expired_at"],
//                              };
//        [kCurrentBossAccount setValuesForKeysWithDictionary:dic];
//        [[NNBRequestManager shareNNBRequestManager] saveToken:kCurrentBossAccount.access_token refrech_token:kCurrentBossAccount.refresh_token expired_at:kCurrentBossAccount.expired_at];
        
        BossManagerAccount *managerAccount = [[BossManagerAccount alloc] init];
        managerAccount.tokenModel = token;
        
        kCurrentBossManagerAccount = managerAccount;
        
        [BossAccountRequest BossAccountRequestGainAccountWithAccountId:token.account_id success:^(BossManagerAccountModel *accountModel){
            
            managerAccount.accountModel = accountModel;
            kCurrentBossManagerAccount = managerAccount;
            
            [kCache addAccount:[kCurrentBossManagerAccount decodeToDic]];
            
            NSLog(@"NNBAuthRequest->authRequestLoginWithPhoneNumber->kCurrentBossManagerAccount\n%@", [kCurrentBossManagerAccount decodeToDic]);
            
            NSLog(@"NNBAuthRequest->authRequestLoginWithPhoneNumber->saasAccountList\n%@",kCache.saasAccountList);
            
            if (successBlock) {
                successBlock(managerAccount);
            }
        } fail:^(id error) {
            if (fail) {
                fail(error);
            }
        }];
#else
//        if ([NNBRequestManager saveAccountInfoWithAccountDic:responseObject]) {
//            kCurrentAccount.isNeedUpdate = NO;
//            if (successBlock) {
//                successBlock(kCurrentBossKnightAccount);
//            }
//        } else {
//
//        }
#endif
    } fail:^(id error) {
        if (fail) {
            fail(error);
        }
    }];
}

/**
 获取登陆cmd，区分Boss骑士和Boss之家

 @return cmd字符串
 */
+ (NSString *)cmdRequest
{
    NSString *cmd;

#ifdef kBossKnight
    cmd = @"auth.auth.app_login";
#elif defined kBossManager
    cmd = @"auth.auth.login";
#else
    cmd = nil;
#endif
    return cmd;
}

@end
