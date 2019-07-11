//
//  BossOwnerAccount.m
//  BossOwnerLogin
//
//  Created by 高炀辉 on 2019/4/30.
//

#import "BossOwnerAccount.h"

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
        if (!confirmBlock) {
            return;
        }
        confirmBlock(YES);
    }];
    
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


@end
