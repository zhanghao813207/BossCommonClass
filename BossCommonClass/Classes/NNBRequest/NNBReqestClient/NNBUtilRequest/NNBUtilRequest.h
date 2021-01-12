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
+ (void)UtilRequestSendSMSWithPhhoneNumber:(NSString *)phoneNumber smsType:(NNBSendSMSType)smsType begainSend:(void(^)(void))begainSendBlock success:(void(^)(BOOL ok,NSString *mockMessage,BOOL is_first_login))successBlock fail:(void(^)(id error))failBlock;

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

/**
 获取S3配置信息
 
 @param domain 文件来源（account：员工，material：物资，cost：费用，salary：薪资 ,asyn_task: 异步任务 ,district:商圈 ,city:城市,coach:私教,individual:个户注册,internal_recommend:内推,oa:OA  ,organization:岗位/部门,owner:业主,personal_company:个独个户）
 @param successBlock 获取成功的回调 返回S3配置信息
 */
+ (void)requestGetS3ConfigInfoWithDomain:(NSString *)domain
                              filePolicy:(NSString *)filePolicy
                                 Success:(void(^)(NSString *url, NSDictionary *policyKey))successBlock
                                    fail:(void (^)(id error))failBlock;

/**
 s3上传图片
 */
+ (void)uploadImageToS3WithData:(NSData *)data
                    contentType:(NSString *)contentType
                      bucketUrl:(NSString *)bucketUrl
                     policyDict:(NSDictionary *)policyDict
                        Success:(void(^)(NSString *fileKey))successBlock
                           fail:(void (^)(id error))failBlock;


/**
   获取银行卡信息查询接口
*/
+(void)requestGetBankCardInfoQueryUrl;

+(void)requestGetEnumModelInfoSuccess:(void (^)(NSDictionary *))success fail:(void (^)(id error))fail;

@end
