//
//  NNBRequestManager.m
//  NNBar_knight
//
//  Created by 贾远潮 on 2017/9/19.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "NNBRequestManager.h"
#import "JYCAES256.h"
#import "NSDate+Helper.h"
#import "BossBasicDefine.h"
#import "JYCSimpleToolClass.h"
#import "BossManagerAccount.h"
#import "BossKnightAccount.h"
#import "SaasModel.h"

float const kNetworkTimeoutInterval = 60.0f;

@interface NNBRequestManager ()

@property (nonatomic, copy) NSString *APP_ACCESS_TOKEN;
@property (nonatomic, copy) NSString *refresh_token;
@property (nonatomic, copy) NSString *expired_at;

@end

@implementation NNBRequestManager

static NNBRequestManager *sharedManager = nil;

+ (__kindof NNBRequestManager *)shareNNBRequestManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [NNBRequestManager manager];
        [sharedManager createAllTokens];
        [sharedManager configureManager];
    });

    return sharedManager;
}

- (void)createAllTokens
{
    NSDictionary *APP_TOKEN = [kUserDefault objectForKey:@"APP_TOKEN"];
    NSString *expired_atString = APP_TOKEN[@"expired_at"];
}

- (void)configureManager
{
    NSString *certFilePath = [[NSBundle mainBundle] pathForResource:@"aoaosong" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:certFilePath];
    NSSet *certSet = [NSSet setWithObject:certData];
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:certSet];
    policy.allowInvalidCertificates = YES;
    policy.validatesDomainName = NO;
    sharedManager.securityPolicy = policy;
    
    sharedManager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [AFCompoundResponseSerializer compoundSerializerWithResponseSerializers:@[[AFHTTPRequestSerializer serializer],[AFJSONResponseSerializer serializer]]];
    sharedManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [sharedManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    [sharedManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    sharedManager.requestSerializer.timeoutInterval = kNetworkTimeoutInterval;
    [sharedManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [sharedManager.requestSerializer setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    
}

- (void)addTokenWithCMD:(NSString *)cmd
{
    // 获取系统当前时间戳
    int date = (int)[[NSDate date] timeIntervalSince1970];
    // header中添加X-MSG_ID
    [sharedManager.requestSerializer setValue:[NSString stringWithFormat:@"%@,%d",[JYCSimpleToolClass getUUID],date] forHTTPHeaderField:@"X-MSG-ID"];
    
    // 校验cmd是否为nil
    if (cmd) {
        
        // cmd添加前缀boss.
        // header中添加X-CMD
        [sharedManager.requestSerializer setValue:[NSString stringWithFormat:@"boss.%@",cmd] forHTTPHeaderField:@"X-CMD"];
    }
    
    [sharedManager.requestSerializer setValue:kAccessKey forHTTPHeaderField:@"X-APP-KEY"];
    
    // “X-AUTH”:  未登录或已登陆但是发送验证码接口
    // "X-TOKEN": 已登录但不是发送验证码接口
    if(!kCache.currentSaasModel || !kCache.checkLogin || [@"auth.auth.send_verify_code" isEqualToString:cmd]){
        // header中添加X-AUTH
        [sharedManager.requestSerializer setValue:[NNBRequestManager headAuthStr:date] forHTTPHeaderField:@"X-AUTH"];
        [sharedManager.requestSerializer setValue:nil forHTTPHeaderField:@"X-TOKEN"];
    }else{
        // // header中添加X-TOKEN
        NSString *X_TOKEN = [NSString stringWithFormat:@"%@,%@",[NNBRequestManager accessToken],[NNBRequestManager headTokenStr:date]];
        [sharedManager.requestSerializer setValue:X_TOKEN forHTTPHeaderField:@"X-TOKEN"];
        [sharedManager.requestSerializer setValue:nil forHTTPHeaderField:@"X-AUTH"];
    }
    DLog(@"HTTPRequestHeaders = %@",sharedManager.requestSerializer.HTTPRequestHeaders);
}

// AUTH请求方式 hMD5加密
+ (NSString *)headAuthStr:(int)date{
    
    NSString *str = [JYCSimpleToolClass HmacMD5:kSeretKey data:[NSString stringWithFormat:@"%@:%d",[JYCSimpleToolClass getUUID],date]];
    return str;
}

// TOKEN请求方式 hMD5加密
+ (NSString *)headTokenStr:(int)date {
    NSString *str = [JYCSimpleToolClass HmacMD5:kSeretKey data:[NSString stringWithFormat:@"%@:%@:%d",[NNBRequestManager accessToken],[JYCSimpleToolClass getUUID],date]];
    return str;
}

// 保存token信息
- (void)saveToken:(NSString *)token
    refrech_token:(NSString *)refresh_token
       expired_at:(NSString *)expired_at {
    
    self.APP_ACCESS_TOKEN = token;
    self.refresh_token = refresh_token;
    self.expired_at = expired_at;
    
    [kUserDefault setObject:@{@"access_token":token,@"refresh_token":refresh_token,@"expired_at":expired_at} forKey:@"APP_TOKEN"];
    [kUserDefault synchronize];
}

// 清除token信息
- (void)cleanToken {
    self.APP_ACCESS_TOKEN = @"";
    self.refresh_token = @"";
    self.expired_at = @"";
    [[NSUserDefaults standardUserDefaults] setObject:@{} forKey:@"APP_TOKEN"];
    [kUserDefault removeObjectForKey:@"APP_TOKEN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)saveAccountInfoWithAccountDic:(NSDictionary *)dic
{
    if (!dic) {
        return NO;
    }
    
    DLog(@"account data:\n%@", dic);
    
    NSDictionary *accountDic;
    
#ifdef kBossKnight
    [kCurrentBossKnightAccount.accountModel setValuesForKeysWithDictionary:dic];
    
    accountDic = [kCurrentBossKnightAccount decodeToDic];
    
    [kUserDefault setObject:localAccountInfoDic forKey:AccountInfoKey];
    [kUserDefault synchronize];
    return YES;
#elif defined kBossManager
    [kCurrentBossManagerAccount.accountModel setValuesForKeysWithDictionary:dic];
    
    accountDic = [kCurrentBossManagerAccount decodeToDic];
    
    // [kUserDefault setObject:accountDic forKey:AccountInfoKey];
    [kUserDefault synchronize];
    return YES;
#else
    return YES;
#endif

}

+ (NSString *)accessToken
{

#ifdef kBossKnight
    return kCurrentBossKnightAccount.tokenModel.access_token;
#elif defined kBossManager
    return kCurrentBossManagerAccount.tokenModel.access_token;
#else
    return @"";
#endif
    
}

@end
