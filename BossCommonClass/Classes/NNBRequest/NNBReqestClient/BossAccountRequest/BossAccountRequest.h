//
//  BossAccountRequest.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/8.
//

#import <Foundation/Foundation.h>
#import <BossManagerAccountModel.h>

@interface BossAccountRequest : NSObject

/**
 获取账号信息

 @param accountId 账号id
 @param successBlock 成功的回调
 @param failBlock 失败的回调
 */
+ (void)BossAccountRequestGainAccountWithAccountId:(NSString *)accountId success:(void(^)(BossManagerAccountModel *))successBlock fail:(void(^)(id error))failBlock;

@end
