//
//  BossKnightAccount.h
//  BossKnightAccount
//
//  Created by 贾远潮 on 2017/9/27.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "BossKnightAccountModel.h"
#import "ContractBelongModel.h"
#import "BaseAccount.h"

@interface BossKnightAccount : BaseAccount <BaseAccount>

@property (nonatomic, strong) BossKnightAccountModel *accountModel;

#pragma mark --method

/**
 判断用户是否信息完善
 
 @param perfectBlock 完善
 @param toPerfectBlock 去完善
 @param viewController 弹出去完善的按钮
 */
//+ (void)userInfoIsPerfect:(void(^)(BOOL isPerfect))perfectBlock toPerfect:(void(^)(void))toPerfectBlock withController:(UIViewController *)viewController;

/**
 判断健康证是否即将到期/已过期

 @param unexpiredBlock              未过期/未到即将过期
 @param toHealthCertificateBlock    去更新
 @param cancelBlock                 取消回调
 @param viewController              上下文
 */
+ (void)checkHealthCertificateExpiredRemind:(void(^)(void))unexpiredBlock toHealthCertificateBlock:(void(^)(void))toHealthCertificateBlock cancelBlock:(void(^)(void))cancelBlock withController:(UIViewController *)viewController;

/**
 判断是否需电子签约
 
 @param onterContractBlock      其他签约回调
 @param electronicContractBlock 电子签约回调
 @param viewController          弹出去完善的按钮
 */
+ (void)checkElectronicContract:(void(^)(void))onterContractBlock electronicContractBlock:(void(^)(void))electronicContractBlock withController:(UIViewController *)viewController;

@end
