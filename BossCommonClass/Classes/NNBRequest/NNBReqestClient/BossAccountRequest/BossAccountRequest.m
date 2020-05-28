//
//  BossAccountRequest.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/8.
//

#import "BossAccountRequest.h"
#import "BossBasicDefine.h"
#import "NNBBasicRequest.h"
#import "NNBRequestManager.h"
#import "BossManagerAccount.h"
@implementation BossAccountRequest

/**
 获取账号信息
 
 @param accountId 账号id
 @param successBlock 成功的回调
 @param failBlock 失败的回调
 */
+ (void)BossAccountRequestGainAccountWithAccountId:(NSString *)accountId success:(void(^)(BossManagerAccountModel *))successBlock fail:(void(^)(id error))failBlock
{
//    NSString *url = [NSString stringWithFormat:@"%@/account/gain_account_detail", kUrlApiVersion(@"/1.0")];
//    NSDictionary *paramDic = @{
//                               @"id":accountId
//                               };
//    [NNBBasicRequest postJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
//
//        NSLog(@"BossAccountRequestGainAccountWithAccountId->response\n%@", responseObject);
//
//        BossManagerAccountModel *accountModel = [[BossManagerAccountModel alloc] init];
//        [accountModel setValuesForKeysWithDictionary:responseObject];
//
//        if (successBlock) {
//            successBlock(accountModel);
//        }
//    } fail:^(id error) {
//        if(failBlock){
//            failBlock(error);
//        }
//    }];
    
    
    NSDictionary *paramDic = @{
                               @"_id":accountId
                               };
    [NNBBasicRequest postJsonWithUrl:kUrl parameters:paramDic CMD:@"account.account.get" success:^(id responseObject) {

        NSLog(@"BossAccountRequestGainAccountWithAccountId->response\n%@", responseObject);

        BossManagerAccountModel *accountModel = [[BossManagerAccountModel alloc] init];
        NSDictionary *dict = responseObject;
        if ([dict.allKeys containsObject:@"employee_info"]) {
            [accountModel setValuesForKeysWithDictionary:responseObject[@"employee_info"]];
        }
        accountModel._id = responseObject[@"_id"];
        accountModel.phone = responseObject[@"phone"];
        accountModel.name = responseObject[@"name"];
        if (successBlock) {
            successBlock(accountModel);
        }
    } fail:^(id error) {
        if(failBlock){
            failBlock(error);
        }
    }];
}

@end
