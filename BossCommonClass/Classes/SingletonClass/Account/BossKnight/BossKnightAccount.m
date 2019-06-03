//
//  BossKnightAccount.m
//  BossKnightAccount
//
//  Created by 贾远潮 on 2017/9/27.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "BossKnightAccount.h"
#import "BossWhiteNavigationController.h"
#import "LoginVC.h"
#import "NNBRequestManager.h"
#import "NSDate+Helper.h"
#import "SaasModel.h"
#import "MQTTClientModel.h"

@implementation BossKnightAccount

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"token"]) {
        TokenModel *model = [[TokenModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.tokenModel = model;
        return;
    }
    
    if ([key isEqualToString:@"account"]) {
        BossKnightAccountModel *model = [[BossKnightAccountModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.accountModel = model;
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

/**
 判断用户是否登录
 
 @param success 成功登录
 @param viewController 弹出登录的控制器（一般为当前控制器）
 */
+ (void)userIsLoginSuccess:(void (^)(BOOL isSuccess, BOOL isFirstLogin))success withController:(UIViewController *)viewController
{
    // 当前用户已经登录
    if (kCurrentBossKnightAccount) {
        if (success) {
            success(YES,NO);
        }
        return;
    }
    // 用户需要登录
    if ([viewController isKindOfClass:[UIViewController class]]) {
        LoginVC *loginVC = [[LoginVC alloc] init];
        [loginVC setLoginSuccessBlock:^(BOOL isLogin) {
            if (!success) {
                return;
            }
            kCurrentBossKnightAccount.isFirstLogin = NO;
            success(isLogin,YES);
        }];
        BossWhiteNavigationController *loginNC = [[BossWhiteNavigationController alloc] initWithRootViewController:loginVC];
        [viewController.navigationController presentViewController:loginNC animated:!kCurrentBossKnightAccount.isFirstLogin completion:nil];
    }
}

/**
 判断用户是否信息完善
 
 @param perfectBlock 完善
 @param toPerfectBlock 去完善
 @param viewController 弹出去完善的按钮
 */
+ (void)userInfoIsPerfect:(void(^)(BOOL isPerfect))perfectBlock toPerfect:(void(^)(void))toPerfectBlock withController:(UIViewController *)viewController
{
    // 当前用户信息未完善
    if (!kCurrentBossKnightAccount.accountModel.userInfoIsPerfect) {
        // 用户需要完善
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先完善个人信息" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *setUpAction = [UIAlertAction actionWithTitle:@"立即完善" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (!toPerfectBlock) {
                return;
            }
            toPerfectBlock();
        }];
        [alert addAction:cancelAction];
        [alert addAction:setUpAction];
        [viewController presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    // 信息已完善
    if (perfectBlock) {
        perfectBlock(YES);
    }
}

+ (void)checkHealthCertificateExpiredRemind:(void(^)(void))unexpiredBlock toHealthCertificateBlock:(void(^)(void))toHealthCertificateBlock cancelBlock:(void(^)(void))cancelBlock withController:(UIViewController *)viewController
{
    // 判断健康证即将到期|已到期
    if(kCurrentBossKnightAccount.accountModel.checkHealthCertificateExpired || kCurrentBossKnightAccount.accountModel.checkHealthCertificateExpiring){
        
        NSString *message =kCurrentBossKnightAccount.accountModel.checkHealthCertificateExpired ? @"骑士您好，您的健康证已到期，请及时更新健康证信息" : [NSString stringWithFormat:@"骑士您好，您的健康证将在%@过期，请提前办理，及时更新健康证信息", kCurrentBossKnightAccount.accountModel.getHealthCertificateEndDate];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if(cancelBlock){
                cancelBlock();
            }
        }];
        UIAlertAction *setUpAction = [UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if(toHealthCertificateBlock){
                toHealthCertificateBlock();
            }
        }];
        [alert addAction:cancelAction];
        [alert addAction:setUpAction];
        [viewController presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    if(unexpiredBlock){
        unexpiredBlock();
    }
}

/**
 判断是否需电子签约
 
 @param onterContractBlock      其他签约回调
 @param electronicContractBlock 电子签约回调
 @param viewController          弹出去完善的按钮
 */
+ (void)checkElectronicContract:(void(^)(void))onterContractBlock electronicContractBlock:(void(^)(void))electronicContractBlock withController:(UIViewController *)viewController
{
    // 电子签约
    if(kCurrentBossKnightAccount.accountModel.checkElectronicContract){
        // 弹出签约/解约对话框
        NSString *message = kCurrentBossKnightAccount.accountModel.checkStaffDeparture ? @"您有解约协议未签署\n请立刻前往签署" : @"您有合同未签约，请立即签约";
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        NSString *setUpTitle = kCurrentBossKnightAccount.accountModel.checkStaffDeparture ? @"立即解约" : @"立即签约";
        UIAlertAction *setUpAction = [UIAlertAction actionWithTitle:setUpTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if(electronicContractBlock){
                electronicContractBlock();
            }
        }];
        [alert addAction:cancelAction];
        [alert addAction:setUpAction];
        [viewController presentViewController:alert animated:YES completion:nil];
        return;
    }

    // 纸质签约
    if (onterContractBlock) {
        onterContractBlock();
    }
    return;
    
}

/**
 登录信息是否过期
 
 @param loginBlock 是否登录
 @param expeiredBlock 登录是否过期（只有登录才会回调是否过期）
 */
+ (void)userIsLogin:(void(^)(BOOL isLogin))loginBlock Expired:(void (^)(BOOL isExpired))expeiredBlock
{
    [kCache initNetConfig:kCache.currentSaasModel];
    if (kCurrentBossKnightAccount) {
        // 未过期的情况 用户上次登录过 且 不需要重新登录
        if (!kCurrentBossKnightAccount.tokenModel.checkExpired) {
            kCurrentBossKnightAccount.isNeedUpdate = YES;
            kCurrentBossKnightAccount.isFirstLogin = YES;
            if (!expeiredBlock) {
                return;
            }
            expeiredBlock(NO);
        } else {
            // 过期的情况（目前不做处理，相当于没有登录过，会去重新登录(同安卓一样)）后期可以考虑刷新tocken
            kCurrentBossKnightAccount.isFirstLogin = YES;
            if (!expeiredBlock) {
                return;
            }
            expeiredBlock(YES);
        }
    } else {
        // 没有登录过
        kCurrentBossKnightAccount.isFirstLogin = YES;
        if (!loginBlock) {
            return;
        }
    }
}

/**
 用户退出登录
 
 @param confirmBlock 点击确认后的回调
 @param viewController 弹出的登录
 */
+ (void)userIsLoginOutConfirm:(void(^)(BOOL isLoginOut))confirmBlock withController:(UIViewController *)viewController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"确认退出登录？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        kCache.lastLoginPhone = kCurrentBossKnightAccount.accountModel.phone;
        kCache.isFirstHealCertificate = YES;
        kCurrentBossKnightAccount = nil;
        if (!confirmBlock) {
            return;
        }
        confirmBlock(YES);
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:photoAction];
    [viewController.navigationController presentViewController:alertController animated:YES completion:nil];
}

- (NSArray *)encodeArrayToArray:(NSArray *)array
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (id model in array) {
        if ([model respondsToSelector:@selector(decodeToDic)]) {
            NSDictionary *dic = [model decodeToDic];
            [arrayM addObject:dic];
        }
    }
    return [arrayM copy];
}

/**
 模型转字典
 
 @return 字典
 */
- (NSDictionary *)decodeToDic
{
    NSDictionary *dic = @{
                          @"token":self.tokenModel ? [self.tokenModel decodeToDic] : @{},
                          @"account":self.accountModel ? [self.accountModel decodeToDic] : @{}
                          };
    return dic;
}

@end
