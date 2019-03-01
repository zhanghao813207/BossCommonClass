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
#import "BossKnightAccountModel.h"
#import "NSDate+Helper.h"

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
        kCurrentBossKnightAccount.isNeedUpdate = NO;
        
        TokenModel *token = [[TokenModel alloc] init];
        [token setValuesForKeysWithDictionary:responseObject];
        token.account_id = [responseObject objectForKey:@"_id"];
        
        NSString *normalTime = [JYCSimpleToolClass fastChangeToNormalTimeWithString:token.expired_at];
        NSDate *date = [NSDate dateFromString:normalTime withFormat:@"yyyy-MM-dd HH:mm:ss"];
        token.expired_at = [NSString stringWithFormat:@"%.0f", [date timeIntervalSince1970]];
        
        BossKnightAccountModel *accountModel = [[BossKnightAccountModel alloc] init];
        [accountModel setValuesForKeysWithDictionary:responseObject];
        
        BossKnightAccount *knightAccount = [[BossKnightAccount alloc]init];
        knightAccount.tokenModel = token;
        knightAccount.accountModel = accountModel;
        
        kCurrentBossKnightAccount = knightAccount;
        
        kCache.currentSaasModel = [NNBRequestManager shareNNBRequestManager].saasModel;
        
        NSLog(@"NNBAuthRequest->authRequestLoginWithPhoneNumber->kCurrentBossKnightAccount\n%@", [kCurrentBossKnightAccount decodeToDic]);
        
        if (successBlock) {
            successBlock(knightAccount);
        }
        
#elif defined kBossManager
        kCurrentBossManagerAccount.isNeedUpdate = NO;
        
        TokenModel *token = [[TokenModel alloc] init];
        [token setValuesForKeysWithDictionary:responseObject];
        
        BossManagerAccount *managerAccount = [[BossManagerAccount alloc] init];
        managerAccount.tokenModel = token;
        kCurrentBossManagerAccount = managerAccount;
        
        [BossAccountRequest BossAccountRequestGainAccountWithAccountId:token.account_id success:^(BossManagerAccountModel *accountModel){
        
            kCache.lastLoginPhone = @"";
            [kCache removePhone:accountModel.phone];
            managerAccount.accountModel = accountModel;
            kCurrentBossManagerAccount = managerAccount;
            
            kCache.currentSaasModel = [NNBRequestManager shareNNBRequestManager].saasModel;
            
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
