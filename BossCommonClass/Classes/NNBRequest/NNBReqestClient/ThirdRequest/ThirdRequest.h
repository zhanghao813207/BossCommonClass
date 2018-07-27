//
//  ThirdRequest.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/7/27.
//

#import <Foundation/Foundation.h>

@interface ThirdRequest : NSObject

/**
 通过银行卡号获取

 @param bankcardId 银行卡号
 @param successBlock 获取成功
 @param failBlock 获取失败
 */
+ (void)ThirdRequestGetBankByBankcardId:(NSString *)bankcardId success:(void(^)(BOOL response,NSString *bankName))successBlock fail:(void(^)(NSError *err))failBlock;

@end
