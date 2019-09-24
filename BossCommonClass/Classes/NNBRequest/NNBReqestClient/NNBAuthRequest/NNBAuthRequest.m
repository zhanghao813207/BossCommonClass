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
#import "configModel.h"
#import "MQTTDefine.h"

@implementation NNBAuthRequest

+ (void)authRequestLoginWithPhoneNumber:(SaasModel *)saasModel phoneNumber:(NSString *)phoneNumber authCode:(NSString *)authCode success:(void (^)(id accountInfo))successBlock fail:(void(^)(id error))fail
{
    if (!saasModel || !phoneNumber || !authCode) {
        return;
    }

    NSDictionary *paramDic = @{
                               @"phone":phoneNumber,
                               @"verify_code":authCode,
                               @"app_code":APPCODE
                               };
    
    [NNBBasicRequest postLoginJsonWithUrl:kUrl parameters:paramDic CMD:[self cmdRequest] success:^(id responseObject) {

         NSLog(@"登录postLoginJsonWithUrl->response\n%@", responseObject);
        
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
        
        kCache.currentSaasModel = saasModel;
        
        NSLog(@"NNBAuthRequest->authRequestLoginWithPhoneNumber->kCurrentBossKnightAccount\n%@", [kCurrentBossKnightAccount decodeToDic]);
        
        if (successBlock) {
            successBlock(knightAccount);
        }
        
#elif defined kBossManager
        kCurrentBossManagerAccount.isNeedUpdate = NO;
        
        TokenModel *token = [[TokenModel alloc] init];
        [token setValuesForKeysWithDictionary:responseObject];

        NSDictionary *dic = responseObject[@"config"];
        BossManagerAccount *managerAccount = [[BossManagerAccount alloc] init];
        if (dic) {
            configModel *model = [[configModel alloc] initWithDictionary:dic];
            [[NSUserDefaults standardUserDefaults] setObject:model.toDictionary forKey:@"umsconfig"];
            if (model){
                MessageBasicURL = [NSString stringWithFormat:@"%@/1.0", model.ums.url];
                MessageBasicURLV2 = [NSString stringWithFormat:@"%@/2.0", model.ums.url];
                MeetingBasicURL = [NSString stringWithFormat:@"%@/meeting/", model.h5.url];
                NSString *server = model.mqtt.server;
                if ([server containsString:@"tcp://"]){
                    NSArray *strArr = [server componentsSeparatedByString:@"//"];
                    if (strArr.count >= 2){
                        server = strArr[1];
                    }
                }
                mqttServer = server;
                mqttPort   = model.mqtt.port;
                mqttUserName = model.mqtt.userName;
                mqttPassword = model.mqtt.password;
                mqttClientId = model.mqtt.clientid;
                mqttSecretKey = model.mqtt.secretKey;
            }
            
            managerAccount.configModel = model;
        }
        managerAccount.tokenModel = token;
       
        kCurrentBossManagerAccount = managerAccount;
        
        [BossAccountRequest BossAccountRequestGainAccountWithAccountId:token.account_id success:^(BossManagerAccountModel *accountModel){
            
            kCache.lastLoginPhone = @"";
            [kCache removePhone:accountModel.phone];
            managerAccount.accountModel = accountModel;
            kCurrentBossManagerAccount = managerAccount;
            
            kCache.currentSaasModel = saasModel;
            
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
#elif defined kBossOwner
    cmd = @"auth.auth.send_verify_code";
#else
    cmd = nil;
#endif
    return cmd;
}

@end
