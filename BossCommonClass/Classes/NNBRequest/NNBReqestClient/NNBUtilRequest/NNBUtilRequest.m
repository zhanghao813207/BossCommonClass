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
 @param successBlock 发送成功的回调 OK：是否成功 mockMessage：测试环境（不发验证码）模拟数据
 */
+ (void)UtilRequestSendSMSWithPhhoneNumber:(NSString *)phoneNumber smsType:(NNBSendSMSType)smsType success:(void(^)(BOOL ok,NSString *mockMessage))successBlock fail:(void(^)())failBlock
{
    if (!phoneNumber) {
        DLog(@"手机号为空，请查看原因");
    }
    NSString *url = [NSString stringWithFormat:@"%@",BossBasicURL];
    NSLog(@"%@",BossBasicURL);
    NSDictionary *paraDic = @{
                              @"mobile":phoneNumber,
                              @"type":@(smsType)
                              };
    [NNBBasicRequest postLoginJsonWithUrl:url parameters:paraDic CMD:@"io.sms.send" success:^(id responseObject) {
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
+ (void)UtilRequestSendVoiceSMSWithPhhoneNumber:(NSString *)phoneNumber smsType:(NNBSendSMSType)smsType success:(void(^)(BOOL ok,NSString *mockMessage))successBlock fail:(void(^)())failBlock
{
    if (!phoneNumber) {
        DLog(@"手机号为空，请查看原因");
    }
    NSString *url = [NSString stringWithFormat:@"%@",BossBasicURL];
    NSDictionary *paraDic = @{
                              @"mobile":phoneNumber,
                              @"type":@(smsType)
                              };
    [NNBBasicRequest postLoginJsonWithUrl:url parameters:paraDic CMD:@"io.sms.send_voice" success:^(id responseObject) {
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
+ (void)UtilRequestGetQNTokenWithOperateType:(NSString *)operateType Success:(void(^)(NSString *path,NSString *qiniu_token))successBlock
{
//    NSString *path = [JYCSimpleToolClass qiniuPathWithOperateType:operateType];
    NSString *path = @"";
    NSDictionary *paramDic = @{
                               @"path":path,
                               };
    [NNBBasicRequest postJsonWithUrl:BossBasicURL parameters:paramDic CMD:@"io.qiniu.get_token" success:^(id responseObject) {
        if (successBlock) {
            successBlock(responseObject[@"qiniu_path"], responseObject[@"qiniu_token"]);
        }
    } fail:^(id error) {
        
    }];
}


@end
