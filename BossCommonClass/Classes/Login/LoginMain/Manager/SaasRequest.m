//
//  SaasRequest.m
//  AFNetworking
//
//  Created by 张浩 on 2019/2/18.
//

#import "SaasRequest.h"
#import "NNBBasicRequest.h"
#import "NNBRequestManager.h"

@implementation SaasRequest

/**
 获取Saas平台信息
 
 @param successBlock 成功回调
 @param failBlock 失败回调
 */
+ (void)getSaasResult:(NSString *)merchantCode success:(void(^)(SaasModel *saasModel))successBlock fail:(void(^)(void))failBlock
{
    NSDictionary *paramDic = @{
                               @"merchant_code":merchantCode,  // 商户号
                               @"app_code":APPCODE             // app code
                               };
    
    [NNBBasicRequest postLoginJsonWithUrl:kUrl parameters:paramDic CMD:@"saas.saas_app.get" success:^(id responseObject){
        if (!successBlock) {
            return;
        }
        NSLog(@"SaasRequest->getSaasResult->response:\n%@",responseObject);
        
        SaasModel *saasModel = [[SaasModel alloc] init];
        [saasModel setValuesForKeysWithDictionary:responseObject];
        successBlock(saasModel);
    } fail:^(id error) {
        if (!failBlock) {
            return;
        }
        failBlock();
    }];
}

@end
