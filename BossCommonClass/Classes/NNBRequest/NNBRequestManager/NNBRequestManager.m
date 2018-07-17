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
float const kNetworkTimeoutInterval = 30.0f;

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
    if (![self accountTockenIsExpiredWithExpired_at:expired_atString]){
        self.APP_ACCESS_TOKEN = APP_TOKEN[@"access_token"];
        self.refresh_token = APP_TOKEN[@"refresh_token"];
        self.expired_at = APP_TOKEN[@"expired_at"];
    }else {
        self.APP_ACCESS_TOKEN = @"";
        self.refresh_token = @"";
        self.expired_at = @"";
    }
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

    [sharedManager.requestSerializer setValue:ACCESS_KEY forHTTPHeaderField:@"X-APP-KEY"];
    
    [sharedManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    [sharedManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    sharedManager.requestSerializer.timeoutInterval = kNetworkTimeoutInterval;
    [sharedManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [sharedManager.requestSerializer setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    
}

/**
 判断accountTocken是否过期

 @param expired_atString 过期时间的时间戳
 @return 是否过期
 */
- (BOOL)accountTockenIsExpiredWithExpired_at:(NSString *)expired_atString
{
    if (!expired_atString) {
        return YES;
    }
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval =  currentDate.timeIntervalSince1970;
    NSTimeInterval expired_at = [expired_atString doubleValue];
    return timeInterval >= expired_at ? YES : NO;
}

- (void)addTokenWithCMD:(NSString *)cmd
{
    int date = (int)[[NSDate date] timeIntervalSince1970];
    [sharedManager.requestSerializer setValue:[NSString stringWithFormat:@"%@,%d",[JYCSimpleToolClass getUUID],date] forHTTPHeaderField:@"X-MSG-ID"];
    if (cmd) {
        [sharedManager.requestSerializer setValue:[NSString stringWithFormat:@"nnbar.%@",cmd] forHTTPHeaderField:@"X-CMD"];
    }
    if (self.APP_ACCESS_TOKEN.length > 0) {
        NSString *X_TOKEN = [NSString stringWithFormat:@"%@,%@",self.APP_ACCESS_TOKEN,[NNBRequestManager headTokenStr:date]];
        [sharedManager.requestSerializer setValue:X_TOKEN forHTTPHeaderField:@"X-TOKEN"];
        [sharedManager.requestSerializer setValue:nil forHTTPHeaderField:@"X-AUTH"];
    }else {
        [sharedManager.requestSerializer setValue:[NNBRequestManager headAuthStr:date] forHTTPHeaderField:@"X-AUTH"];
        [sharedManager.requestSerializer setValue:nil forHTTPHeaderField:@"X-TOKEN"];
    }
    DLog(@"HTTPRequestHeaders = %@",sharedManager.requestSerializer.HTTPRequestHeaders);
}

// AUTH请求方式 hMD5加密
+ (NSString *)headAuthStr:(int)date{
    NSString *str = [JYCSimpleToolClass HmacMD5:SECRET_KEY data:[NSString stringWithFormat:@"%@:%d",[JYCSimpleToolClass getUUID],date]];
    return str;
}

// TOKEN请求方式 hMD5加密
+ (NSString *)headTokenStr:(int)date {
    NSString *str = [JYCSimpleToolClass HmacMD5:SECRET_KEY data:[NSString stringWithFormat:@"%@:%@:%d",sharedManager.APP_ACCESS_TOKEN,[JYCSimpleToolClass getUUID],date]];
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
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)saveAccountInfoWithAccountDic:(NSDictionary *)dic
{
    if (!dic) {
        return NO;
    }
    
#ifdef kBossKnight
    [kCurrentAccount setValuesForKeysWithDictionary:dic];
    
    NSDictionary *localAccountInfoDic = [kCurrentAccount decodeToDic];
    
    [kUserDefault setObject:localAccountInfoDic forKey:AccountInfoKey];
    [kUserDefault synchronize];
    
    [[NNBRequestManager shareNNBRequestManager] saveToken:kCurrentAccount.access_token refrech_token:kCurrentAccount.refresh_token expired_at:kCurrentAccount.expired_at];
    return YES;
#elif defined kBossManager
    [kCurrentBossAccount setValuesForKeysWithDictionary:dic];
    
    NSDictionary *localAccountInfoDic = [kCurrentBossAccount decodeToDic];
    
    [kUserDefault setObject:localAccountInfoDic forKey:AccountInfoKey];
    [kUserDefault synchronize];
    
    [[NNBRequestManager shareNNBRequestManager] saveToken:kCurrentBossAccount.access_token refrech_token:kCurrentBossAccount.refresh_token expired_at:kCurrentBossAccount.expired_at];
    return YES;
#else
    return YES;
#endif

}

@end
