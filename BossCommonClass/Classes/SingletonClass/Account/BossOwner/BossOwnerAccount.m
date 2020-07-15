//
//  BossOwnerAccount.m
//  BossOwnerLogin
//
//  Created by 高炀辉 on 2019/4/30.
//

#import "BossOwnerAccount.h"
//@import 

@implementation BossOwnerAccount


- (NSDictionary *)decodeToDic
{
    if (self.accountModel) {
        NSDictionary *dic = @{@"account":self.accountModel ? [self.accountModel toDictionary] : @{}};
        return dic;
    }
    return @{};
}
- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    if ([key isEqualToString:@"account"]) {
        self.accountModel = [[BossOwnerUserModel alloc] initWithDictionary:value];
        return;
    }
    [super setValue:value forKey:key];
}
/**
 登录信息是否过期
 
 @param loginBlock 是否登录
 @param expeiredBlock 登录是否过期（只有登录才会回调是否过期）
 */
//+ (void)userIsLogin:(nonnull void (^)(BOOL))loginBlock Expired:(nonnull void (^)(BOOL))expeiredBlock {
//    <#code#>
//}

/**
 用户退出登录
 
 @param confirmBlock 点击确认后的回调
 @param viewController 弹出的登录
 */
+ (void)userIsLoginOutConfirm:(nonnull void (^)(BOOL))confirmBlock withController:(nonnull UIViewController *)viewController {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"确认退出登录？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        kCurrentBossKnightAccount = nil;
        kCurrentBossOwnerAccount = nil;
        kCache.umsAccessTokenModel = nil;
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_key"];
        if (!confirmBlock) {
            return;
        }
        confirmBlock(YES);
    }];
    [cancelAction setValue:[UIColor colorNamed:@"boss_000000-60_FFFFFF-60"] forKey:@"titleTextColor"];
    [alertController addAction:cancelAction];
    [alertController addAction:photoAction];
    [viewController.navigationController presentViewController:alertController animated:YES completion:nil];
}

/**
 判断用户是否登录
 
 @param success 成功登录
 @param viewController 弹出登录的控制器（一般为当前控制器）
 */
//+ (void)userIsLoginSuccess:(nonnull void (^)(BOOL, BOOL))success withController:(nonnull UIViewController *)viewController {
//    <#code#>
//}
+ (void)checkElectronicContract:(void(^)(void))onterContractBlock electronicContractBlock:(void(^)(void))electronicContractBlock withController:(UIViewController *)viewController
{
    // 电子签约
    if(kCurrentBossOwnerAccount.accountModel.checkElectronicContract){
        // 弹出签约/解约对话框
        NSString *message = kCurrentBossOwnerAccount.accountModel.checkStaffDeparture ? @"您有解约协议未签署\n请立刻前往签署" : @"您有合同未签约，请立即签约";
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        NSString *setUpTitle = kCurrentBossOwnerAccount.accountModel.checkStaffDeparture ? @"立即解约" : @"立即签约";
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

@end
