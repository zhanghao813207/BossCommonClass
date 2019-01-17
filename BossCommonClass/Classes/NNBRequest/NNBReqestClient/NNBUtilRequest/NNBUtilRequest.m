//
//  NNBUtilRequest.m
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/26.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "NNBUtilRequest.h"
#import "NNBBasicRequest.h"
#import "BossBasicDefine.h"
@implementation NNBUtilRequest

/**
 发送验证码
 
 @param phoneNumber 手机号
 @param smsType 验证码类型
 @param begainSendBlock 开始发送验证码
 @param successBlock 发送成功的回调 OK：是否成功 mockMessage：测试环境（不发验证码）模拟数据
 */
+ (void)UtilRequestSendSMSWithPhhoneNumber:(NSString *)phoneNumber smsType:(NNBSendSMSType)smsType begainSend:(void(^)(void))begainSendBlock success:(void(^)(BOOL ok,NSString *mockMessage))successBlock fail:(void(^)(void))failBlock
{
    if (!phoneNumber) {
        DLog(@"手机号为空，请查看原因");
    }
    
    NSMutableDictionary *paraDic = @{
                              @"phone":phoneNumber,
                              @"if_voice":@(NO)
                              }.mutableCopy;
    
    if (smsType == NNBSendSMSTypeChangePhoneNumber) {
        [paraDic setValue:@"exchange_mobile" forKey:@"event"];
    }
    
    if (begainSendBlock) {
        begainSendBlock();
    }
    
    // 执行发送验证码请求
    [self requestSmsCode:[self urlReuest] parameters:paraDic CMD:[self cmdRequest] success:^(id responseObject) {
        if (successBlock) {
            successBlock([responseObject[@"ok"] boolValue],responseObject[@"verify_code"]);
        }
    } fail:^(id error) {
        if (failBlock) {
            failBlock();
        }
    }];
}

/**
 发送语音验证码
 
 @param phoneNumber 手机号
 @param smsType 验证码类型
 @param successBlock 发送成功的回调 OK：是否成功 mockMessage：测试环境（不发验证码）模拟数据
 */
+ (void)UtilRequestSendVoiceSMSWithPhhoneNumber:(NSString *)phoneNumber smsType:(NNBSendSMSType)smsType success:(void(^)(BOOL ok,NSString *mockMessage))successBlock fail:(void(^)(void))failBlock
{
    if (!phoneNumber) {
        DLog(@"手机号为空，请查看原因");
    }

    NSMutableDictionary *paraDic = @{
                                     @"phone":phoneNumber,
                                     @"if_voice":@(YES)
                                     }.mutableCopy;
    
    if (smsType == NNBSendSMSTypeChangePhoneNumber) {
        [paraDic setValue:@"exchange_mobile" forKey:@"event"];
    }
    
    // 执行发送验证码请求
    [self requestSmsCode:[self urlReuest] parameters:paraDic CMD:[self cmdRequest] success:^(id responseObject) {
        if (successBlock) {
            successBlock([responseObject[@"ok"] boolValue],responseObject[@"verify_code"]);
        }
    } fail:^(id error) {
        if (failBlock) {
            failBlock();
        }
    }];
}

/**
 获取七牛token

 @param operateType 操作类型
 @param successBlock 获取成功的回调 返回七牛token
 */
+ (void)UtilRequestGetQNTokenWithOperateType:(NSString *)operateType Success:(void(^)(NSString *path,NSString *qiniu_token))successBlock fail:(void (^)(id error))failBlock
{
//    NSString *path = [JYCSimpleToolClass qiniuPathWithOperateType:operateType];
    
    NSString *url = [NSString stringWithFormat:@"%@upload/get_token",BossBasicURL];
    
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSince1970];
    
    NSString *path = [NSString stringWithFormat:@"%.0f.jpg",timeInterval];
    NSDictionary *paramDic = @{
                               @"file_name":path,
                               };
    [NNBBasicRequest getJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
        if (successBlock) {
            successBlock(responseObject[@"path"], responseObject[@"token"]);
        }
    } fail:^(id error) {
        if(error){
            failBlock(error);
        }
    }];
}


/**
 发送验证码请求

 @param url 请求url
 @param parameters 请求参数
 @param cmd 请求cmd
 @param success 请求成功回调
 @param fail 请求失败回调
 */
+ (void)requestSmsCode:(NSString *)url parameters:(id)parameters CMD:(NSString *)cmd success:(void (^)(id responseObject))success fail:(void (^)(id error))fail{
#ifdef kBossKnight
    [NNBBasicRequest getLoginJsonWithUrl:url parameters:parameters CMD:cmd success:success fail:fail];
#else
    [NNBBasicRequest postLoginJsonWithUrl:url parameters:parameters CMD:cmd success:success fail:fail];
#endif
}

/**
 获取请求url,区分Boss骑士和Boss之家

 @return 请求url
 */
+ (NSString *)urlReuest
{
    NSString *url;
    
#ifdef kBossKnight
    url = [NSString stringWithFormat:@"%@auth/send_verify_code",BossBasicURL];
#elif defined kBossManager
    url = BossBasicURLV2;
#else
    url = BossBasicURLV2;
#endif
    return url;
}

/**
 获取请求cmd，区分Boss骑士和Boss之家
 
 @return cmd字符串
 */
+ (NSString *)cmdRequest
{
    NSString *cmd;
    
#ifdef kBossKnight
    cmd = nil;
#elif defined kBossManager
    cmd = @"auth.auth.send_verify_code";
#else
    cmd = @"auth.auth.send_verify_code";
#endif
    return cmd;
}


@end
