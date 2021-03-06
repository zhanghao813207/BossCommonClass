//
//  NNBRequestManager.m
//  NNBar_knight
//
//  Created by 贾远潮 on 2017/9/19.
//

#import "NNBRequestManager.h"
#import "JYCAES256.h"
#import "NSDate+Helper.h"
#import "BossBasicDefine.h"
#import "JYCSimpleToolClass.h"

float const kNetworkTimeoutInterval = 60.0f;

@interface NNBRequestManager ()

@property (nonatomic, readonly) NSString *bossPrefix;

@property (nonatomic, readonly) NSString *accessKey;

@property (nonatomic, readonly) NSString *secretKey;

@property (nonatomic, readonly) NSString *accessToken;

/**
 保存当前的请求地址 用来切换相应的token和url
 */
@property (nonatomic, copy)NSString *cmd;

@end

@implementation NNBRequestManager

static NNBRequestManager *sharedManager = nil;

+ (__kindof NNBRequestManager *)shareNNBRequestManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [NNBRequestManager manager];
        [sharedManager configureManager];
    });

    return sharedManager;
}

- (void)configureManager
{
    // 临时取消证书校验 下一个版本开启
    // NSString *certFilePath = [[NSBundle mainBundle] pathForResource:@"aoaosong" ofType:@"cer"];
    // NSData *certData = [NSData dataWithContentsOfFile:certFilePath];
    // NSSet *certSet = [NSSet setWithObject:certData];
//    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:certSet];
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
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
// TODO:
- (void)addTokenWithCMD:(NSString *)cmd
{
    self.cmd = cmd;
    // 获取系统当前时间戳
    int date = (int)[[NSDate date] timeIntervalSince1970];
    // header中添加X-MSG_ID
    [sharedManager.requestSerializer setValue:[NSString stringWithFormat:@"%@,%d",[JYCSimpleToolClass getUUID],date] forHTTPHeaderField:@"X-MSG-ID"];
    NSLog(@"%@",cmd);
    // 校验cmd是否为nil
    if(cmd && ([cmd hasPrefix:@"qlife_boss"] ||[cmd hasPrefix:@"qlife"] || [cmd hasPrefix:@"datahub_qlife"]))
    {
        [sharedManager.requestSerializer setValue:cmd forHTTPHeaderField:@"X-CMD"];
        
    }else if (cmd) {
        // cmd添加前缀
        // header中添加X-CMD
        [sharedManager.requestSerializer setValue:[NSString stringWithFormat:@"%@.%@",self.bossPrefix,cmd] forHTTPHeaderField:@"X-CMD"];
    }
    
    [sharedManager.requestSerializer setValue:sharedManager.accessKey forHTTPHeaderField:@"X-APP-KEY"];
    
    // “X-AUTH”:  未登录或已登陆但是发送验证码接口
    // "X-TOKEN": 已登录但不是发送验证码接口
    if ([BossBasicPrefix isEqualToString:@"qlife"]) {
        // 获取验证码 登录 都使用 X-AUTH;
        if ([@"auth.auth.send_verify_code" isEqualToString:cmd] || [@"auth.auth.login" isEqualToString:cmd] || [@"qlife.event.event_storage.bulk_insert" isEqualToString:cmd] ||[@"tool.tool.get_configs" isEqualToString:cmd]||[@"auth.auth.sim_login" isEqualToString:cmd]  ) {
            // header中添加X-AUTH
            [sharedManager.requestSerializer setValue:[sharedManager headAuthStr:date] forHTTPHeaderField:@"X-AUTH"];
            [sharedManager.requestSerializer setValue:nil forHTTPHeaderField:@"X-TOKEN"];
        }else {
            NSLog(@"X-token%@", sharedManager.accessToken);
            NSString *X_TOKEN = [NSString stringWithFormat:@"%@,%@",sharedManager.accessToken,[sharedManager headTokenStr:date]];
            [sharedManager.requestSerializer setValue:X_TOKEN forHTTPHeaderField:@"X-TOKEN"];
            [sharedManager.requestSerializer setValue:nil forHTTPHeaderField:@"X-AUTH"];
        }
        
    } else {
        if(!kCache.netConfig || !kCache.checkLogin || [@"auth.auth.send_verify_code" isEqualToString:cmd]){
            // header中添加X-AUTH
            [sharedManager.requestSerializer setValue:[sharedManager headAuthStr:date] forHTTPHeaderField:@"X-AUTH"];
            [sharedManager.requestSerializer setValue:nil forHTTPHeaderField:@"X-TOKEN"];
        }else{
            // // header中添加X-TOKEN
            NSLog(@"X-token%@", sharedManager.accessToken);
            NSString *X_TOKEN = [NSString stringWithFormat:@"%@,%@",sharedManager.accessToken,[sharedManager headTokenStr:date]];
            [sharedManager.requestSerializer setValue:X_TOKEN forHTTPHeaderField:@"X-TOKEN"];
            [sharedManager.requestSerializer setValue:nil forHTTPHeaderField:@"X-AUTH"];
        }
    }
    NSLog(@"HTTPRequestHeaders = %@",sharedManager.requestSerializer.HTTPRequestHeaders);
}

// AUTH请求方式 hMD5加密
- (NSString *)headAuthStr:(int)date{
    
    NSString *str = [JYCSimpleToolClass HmacMD5:sharedManager.secretKey?:@"" data:[NSString stringWithFormat:@"%@:%d",[JYCSimpleToolClass getUUID],date]];
    return str;
}

// TOKEN请求方式 hMD5加密
- (NSString *)headTokenStr:(int)date {
    NSString *str = [JYCSimpleToolClass HmacMD5:sharedManager.secretKey?:@"" data:[NSString stringWithFormat:@"%@:%@:%d",sharedManager.accessToken,[JYCSimpleToolClass getUUID],date]];
    return str;
}

- (NSString *)bossPrefix {
    return [self.cmd hasPrefix:@"ums."] ? BossUmsPrefix : BossBasicPrefix;
}

- (NSString *)accessKey
{

    if ([self.cmd hasPrefix:@"ums."]) {
        return kCache.umsAccessKey;
    }
    return kCache.accessKey;
}

- (NSString *)secretKey
{

    if ([self.cmd hasPrefix:@"ums."]) {
        return kCache.umsSecretKey;
    }
    return kCache.secretKey;
}

- (NSString *)accessToken
{
    if ([self.cmd hasPrefix:@"ums."]) {
        return kCache.umsAccessToken;
    }
    return kCache.accessToken;
}
+ (NSDictionary *)requestHeader{
    return sharedManager.requestSerializer.HTTPRequestHeaders;
}
@end
