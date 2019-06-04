//
//  EntrustAccountRegistrationManager.h
//  BossCommonClass
//
//  Created by 张浩 on 2019/5/22.
//

#import <Foundation/Foundation.h>
#import "IndividualRegisterResultModel.h"
#import "IndividualRegisterStateModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 委托个户注册相关接口
 */
@interface EntrustAccountRegistrationRequest : NSObject

typedef void (^successRegister)(IndividualRegisterResultModel *result);

typedef void (^successGetIndividualRegisterState)(IndividualRegisterStateModel *result);

typedef void (^failBlock)(void);

/**
 注册用户接口

 @param successBlock 注册成功回调
 @param failBlock 注册失败回调
 */
+ (void)registerIndividualRegister:(successRegister)successBlock failBlock:(failBlock)failBlock;

/**
 查询个户注册状态接口

 @param successBlock 查询成功回调
 @param failBlock 查询失败回调
 */
+ (void)getIndividualRegisterState:(successGetIndividualRegisterState)successBlock failBlock:(failBlock)failBlock;

@end

NS_ASSUME_NONNULL_END
