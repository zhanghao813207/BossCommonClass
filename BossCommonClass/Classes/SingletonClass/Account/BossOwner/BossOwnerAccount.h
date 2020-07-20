//
//  BossOwnerAccount.h
//  BossOwnerLogin
//
//  Created by 高炀辉 on 2019/4/30.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "BossOwnerUserModel.h"
#import "BaseAccount.h"

NS_ASSUME_NONNULL_BEGIN

@interface BossOwnerAccount : BaseAccount <BaseAccount>

@property (nonatomic, strong) BossOwnerUserModel *accountModel;

/**
 判断是否需电子签约
 
 @param onterContractBlock      其他签约回调
 @param electronicContractBlock 电子签约回调
 @param viewController          弹出去完善的按钮
 */
+ (void)checkElectronicContract:(void(^)(void))onterContractBlock electronicContractBlock:(void(^)(void))electronicContractBlock withController:(UIViewController *)viewController;

- (NSDictionary *)decodeToDic:(BossOwnerUserModel *)accountModel;

@end

NS_ASSUME_NONNULL_END
