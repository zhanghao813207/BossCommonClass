//
//  NNBUtilRequest.m
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/26.
//

#import "NNBUtilRequest.h"
#import "NNBBasicRequest.h"
#import "BossBasicDefine.h"
#import "BossCache.h"
#import "NNBRequestManager.h"
#import "JYCSimpleToolClass.h"
#import "NSString+base.h"

@implementation NNBUtilRequest

/**
 发送验证码
 
 @param phoneNumber 手机号
 @param smsType 验证码类型
 @param begainSendBlock 开始发送验证码
 @param successBlock 发送成功的回调 OK：是否成功 mockMessage：测试环境（不发验证码）模拟数据
 */
+ (void)UtilRequestSendSMSWithPhhoneNumber:(NSString *)phoneNumber smsType:(NNBSendSMSType)smsType begainSend:(void(^)(void))begainSendBlock success:(void(^)(BOOL ok,NSString *mockMessage,BOOL is_first_login))successBlock fail:(void(^)(void))failBlock
{
    if (!phoneNumber) {
        DLog(@"手机号为空，请查看原因");
        return;
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
    
    NSLog(@"\n%@", kUrl);
    NSLog(@"\n%@", kUrlApiVersion(@"/1.0"));
    NSLog(@"\n%@", [self cmdRequest]);
    
    // 执行发送验证码请求
    [self requestSmsCode:kUrl parameters:paraDic CMD:[self cmdRequest] success:^(id responseObject) {
        NSLog(@"%@", responseObject);
        if (successBlock) {
            BOOL isFirstLogin;
            
            // 当标签为空时
            if ([responseObject[@"is_first_login"] isEqual:[NSNull null]]){
                
                NSLog(@"字符串为空");
                isFirstLogin = false;
            }else {
                isFirstLogin = [responseObject[@"is_first_login"] boolValue];
            };
            
            successBlock([responseObject[@"ok"] boolValue],responseObject[@"verify_code"],isFirstLogin);
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
    DLog(@"request params:\n%@",paraDic);
    DLog(@"request CMD:\n%@",[self cmdRequest]);
    
    // 执行发送验证码请求
    [self requestSmsCode:kUrl parameters:paraDic CMD:[self cmdRequest] success:^(id responseObject) {
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
    
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSince1970];
    NSString *path;
    if(operateType){
        path = [NSString stringWithFormat:@"%.0f.%@",timeInterval, operateType];
    } else {
        path = [NSString stringWithFormat:@"%.0f.jpg",timeInterval];
    }
    NSDictionary *paramDic = @{
                               @"file_name":path,
                               };
    
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"tool.tool.get_qiniu_token" success:^(id responseObject) {
        if (successBlock) {
            successBlock(responseObject[@"path"], responseObject[@"token"]);
        }
    } fail:^(id error) {
        if(failBlock){
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
    
    [NNBBasicRequest postLoginJsonWithUrl:url parameters:parameters CMD:cmd success:success fail:fail];
}

/**
 获取请求cmd，区分Boss骑士和Boss之家
 
 @return cmd字符串
 */
+ (NSString *)cmdRequest
{
    return @"auth.auth.send_verify_code";
}


/**
 获取S3配置信息
 
 @param domain 文件来源（staff：员工，material：物资，cost：费用，salary：薪资）
 @param successBlock 获取成功的回调 返回S3配置信息
 */
+ (void)requestGetS3ConfigInfoWithDomain:(NSString *)domain
                              filePolicy:(NSString *)filePolicy
                                 Success:(void(^)(NSString *url,NSString *fileType, NSDictionary *policyKey))successBlock
                                    fail:(void (^)(id error))failBlock{
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setValue:domain forKey:@"domain"];
    [paramDic setValue:filePolicy forKey:@"get_s3_policy"]; //jpg txt png
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"tool.tool.get_s3_policy" success:^(id responseObject) {
        NSDictionary *dic = responseObject;
        if (successBlock) {
            if (dic && [dic valueForKey:@"data"]){
                successBlock( [responseObject valueForKeyPath:@"data.url"],[responseObject valueForKeyPath:@"data.file_type"], [responseObject valueForKeyPath:@"data.fields"]);
            }
        }
    } fail:^(id error) {
        if(failBlock){
            failBlock(error);
        }
    }];
}

/**
 s3上传图片
 */
+ (void)uploadImageToS3WithData:(NSData *)data
                    contentType:(NSString *)contentType
                      bucketUrl:(NSString *)bucketUrl
                     policyDict:(NSDictionary *)policyDict
                        Success:(void(^)(NSString *fileKey))successBlock
                           fail:(void (^)(id error))failBlock
{

   // form表单
    AFHTTPSessionManager *sharedManager = [AFHTTPSessionManager manager];
    sharedManager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    sharedManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [sharedManager.requestSerializer setValue:@"multipart/form-data;" forHTTPHeaderField:@"Content-Type"];
    [sharedManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    sharedManager.requestSerializer.timeoutInterval = 60.f;
    [sharedManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [sharedManager.requestSerializer setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =@"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = @"";
    NSString *mineType = @"";
    if([NSString isEmptyStringWithString:contentType]||[contentType isEqualToString:@"jpg"]){
        fileName = [NSString stringWithFormat:@"%@.jpg", str];
        mineType = @"image/jpeg";
    }else{
        fileName = [NSString stringWithFormat:@"%@.%@",str,contentType];
        mineType = @"video/quicktime";
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:policyDict];
    NSString *keyStr = [policyDict valueForKey:@"key"];
    [sharedManager POST:bucketUrl parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 其中name字段是跟服务端协商规定好的,不可随意更改
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:mineType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        if(successBlock){
            successBlock(keyStr);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (failBlock){
            failBlock(@"");
        }
    }];
}


///**
// s3上传图片
// */
//+ (void)uploadImageToS3WithData:(NSData *)data
//                    contentType:(NSString *)contentType
//                      bucketUrl:(NSString *)bucketUrl
//                     policyDict:(NSDictionary *)policyDict
//                        Success:(void(^)(NSString *url,NSString *result))successBlock
//                           fail:(void (^)(id error))failBlock
//{
//    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
//       //分界线 --AaB03x
//       NSString *MPboundary = [[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
//       //结束符 AaB03x--
//       NSString *endMPboundary = [[NSString alloc]initWithFormat:@"%@--",MPboundary];
//       //http body的字符串
//       NSMutableString *body = [[NSMutableString alloc]init];
//       //参数的集合的所有key的集合
//       NSArray *keys= [policyDict allKeys];
//       //遍历keys
//       for(int i=0;i<[keys count];i++) {
//           //得到当前key
//           NSString *key=[keys objectAtIndex:i];
//           //添加分界线，换行
//           [body appendFormat:@"%@\r\n",MPboundary];
//           //添加字段名称，换2行
//           [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key];
//           //添加字段的值
//           [body appendFormat:@"%@\r\n",[policyDict objectForKey:key]];
//       }
//       //声明myRequestData，用来放入http body
//       NSMutableData *myRequestData = [NSMutableData data];
//       //将body字符串转化为UTF8格式的二进制
//       [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
//
//       //要上传的图片--得到图片的data
////       NSData* data = UIImageJPEGRepresentation(image, imageScale);
//       NSMutableString *imgbody = [[NSMutableString alloc] init];
//       //添加分界线，换行
//       [imgbody appendFormat:@"%@\r\n",MPboundary];
//
//       NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//       formatter.dateFormat =@"yyyyMMddHHmmss";
//       NSString *str = [formatter stringFromDate:[NSDate date]];
//       NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
//       [imgbody appendFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n", fileName];
//       //声明上传文件的格式
//       [imgbody appendFormat:@"Content-Type: application/octet-stream; charset=utf-8\r\n\r\n"];
//       //将body字符串转化为UTF8格式的二进制
//       [myRequestData appendData:[imgbody dataUsingEncoding:NSUTF8StringEncoding]];
//       //将image的data加入
//       [myRequestData appendData:data];
//       [myRequestData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//
//       //声明结束符：--AaB03x--
//       NSString *end = [[NSString alloc]initWithFormat:@"%@\r\n",endMPboundary];
//       //加入结束符--AaB03x--
//       [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
//       //设置HTTPHeader中Content-Type的值
//       //设置HTTPHeader
//     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:bucketUrl]];
//     NSString *content = [[NSString alloc]initWithFormat:@"multipart/form-data;boundary=%@",TWITTERFON_FORM_BOUNDARY];
//       [request setValue:content forHTTPHeaderField:@"Content-Type"];
//       //设置Content-Length
//       [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
//       //设置http body
//       [request setHTTPBody:myRequestData];
//       [request setHTTPMethod:@"POST"];
//        [request setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
//
//    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"%@#####%@",response,error);
//    }] resume];
//}


@end
