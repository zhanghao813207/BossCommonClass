//
//  NNBUtilRequest.h
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/26.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
@interface NNBUtilRequest : NSObject

/**
 发送验证码
 
 @param phoneNumber 手机号
 @param smsType 验证码类型
 @param begainSendBlock 开始发送验证码
 @param successBlock 发送成功的回调 OK：是否成功 mockMessage：测试环境（不发验证码）模拟数据
 */
+ (void)UtilRequestSendSMSWithPhhoneNumber:(NSString *)phoneNumber smsType:(NNBSendSMSType)smsType begainSend:(void(^)(void))begainSendBlock success:(void(^)(BOOL ok,NSString *mockMessage,BOOL is_first_login))successBlock fail:(void(^)(void))failBlock;

/**
 发送语音验证码
 
 @param phoneNumber 手机号
 @param smsType 验证码类型
 @param successBlock 发送成功的回调 OK：是否成功 mockMessage：测试环境（不发验证码）模拟数据
 */
+ (void)UtilRequestSendVoiceSMSWithPhhoneNumber:(NSString *)phoneNumber smsType:(NNBSendSMSType)smsType success:(void(^)(BOOL ok,NSString *mockMessage))successBlock fail:(void(^)(void))failBlock;

/**
 获取七牛token
 
 @param operateType 操作类型
 @param successBlock 获取成功的回调 返回七牛token
 */
+ (void)UtilRequestGetQNTokenWithOperateType:(NSString *)operateType Success:(void(^)(NSString *path,NSString *qiniu_token))successBlock fail:(void(^)(id error))failBlock;


+ (void)uploadImageToS3WithData:(NSData *)data
        key:(NSString *)key
     bucket:(NSString *)bucket
contentType:(NSString *)contentType
                        Success:(void(^)(NSString *path,NSString *qiniu_token))successBlock fail:(void (^)(id error))failBlock;
/**
 获取S3配置信息
 
 @param domain 文件来源（staff：员工，material：物资，cost：费用，salary：薪资）
 @param successBlock 获取成功的回调 返回S3配置信息
 */
+ (void)requestGetS3ConfigInfoWithDomain:(NSString *)domain Success:(void(^)(NSString *url,NSString *key))successBlock fail:(void (^)(id error))failBlock;

@end
