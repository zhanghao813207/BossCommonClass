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
    NSString *url = [NSString stringWithFormat:@"%@/account/gain_account_list", kUrlApiVersion(@"/1.0")];
    NSDictionary *paramDic = @{
                               @"permission_id":@"7-1",
                               @"account_id":accountId,
                               @"account_id_list":@[accountId],
                               @"page":@"1",
                               @"limit":@"10",
                               };
    [NNBBasicRequest postJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
        
        NSLog(@"BossAccountRequestGainAccountWithAccountId->response\n%@", responseObject);
        
        BossManagerAccountModel *accountModel = [[BossManagerAccountModel alloc] init];
        [accountModel setValuesForKeysWithDictionary:((NSArray *)responseObject[@"data"]).firstObject];
        
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
