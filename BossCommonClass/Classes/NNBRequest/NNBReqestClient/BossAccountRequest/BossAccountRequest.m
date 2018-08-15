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
@implementation BossAccountRequest

/**
 获取账号信息
 
 @param accountId 账号id
 @param successBlock 成功的回调
 @param failBlock 失败的回调
 */
+ (void)BossAccountRequestGainAccountWithAccountId:(NSString *)accountId success:(void(^)(void))successBlock fail:(void(^)(id error))failBlock
{
    NSString *url = [NSString stringWithFormat:@"%@account/gain_account_list",BossBasicURL];
    NSDictionary *paramDic = @{
                               @"permission_id":@"7-1",
                               @"account_id":accountId,
                               @"account_id_list":@[accountId],
                               @"page":@"1",
                               @"limit":@"10",
                               };
    [NNBBasicRequest postJsonWithUrl:url parameters:paramDic CMD:nil success:^(id responseObject) {
        if ([NNBRequestManager saveAccountInfoWithAccountDic:((NSArray *)responseObject[@"data"]).firstObject]) {
            kCurrentBossAccount.isNeedUpdate = NO;
            if (successBlock) {
                successBlock();
            }
        } else {
            
        }
    } fail:^(id error) {
        if(failBlock){
            failBlock(error);
        }
    }];
}

@end
