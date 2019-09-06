//
//  BossAccount.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/7/16.
//

#import "BossManagerAccount.h"
#import "BossWhiteNavigationController.h"
#import "LoginVC.h"
#import "NNBRequestManager.h"
#import "SaasModel.h"
#import "MQTTClientModel.h"

@implementation BossManagerAccount

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
        BossManagerAccountModel *model = [[BossManagerAccountModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.accountModel = model;
        return;
    }
    if ([key isEqualToString:@"config"]) {
        configModel *model = [[configModel alloc] initWithDictionary:value];
        self.configModel = model;
        return;
    }
    
    
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

+ (void)userIsLoginSuccess:(void (^)(BOOL isSuccess, BOOL isFirstLogin))success saasAccountBlock:(void(^)(void))saasAccountBlock withController:(UIViewController *)viewController{
    
    // 当前用户已经登录
    if (kCurrentBossManagerAccount) {
        if (success) {
            success(YES,NO);
        }
        return;
    }
    
    // 用户需要登录
    if ([viewController isKindOfClass:[UIViewController class]]) {
        
        NSMutableArray *saasDicList = kCache.saasAccountList;
        if(saasDicList.count == 0 || (saasDicList.count == 1 && [[saasDicList[0] objectForKey:@"accountList"] count] == 1)){
            LoginVC *loginVC = [[LoginVC alloc] init];
            [loginVC setLoginSuccessBlock:^(BOOL isLogin) {
                if (!success) {
                    return;
                }
                kCurrentBossManagerAccount.isFirstLogin = NO;
                success(isLogin,YES);
            }];
            BossWhiteNavigationController *loginNC = [[BossWhiteNavigationController alloc] initWithRootViewController:loginVC];
            [viewController.navigationController presentViewController:loginNC animated:!kCurrentBossManagerAccount.isFirstLogin completion:nil];
            [viewController.tabBarController setSelectedIndex:0];
            return;
        }
        
        if(saasAccountBlock){
            saasAccountBlock();
        }
    }
}

/**
 判断用户是否登录
 
 @param success 成功登录
 @param viewController 弹出登录的控制器（一般为当前控制器）
 */
+ (void)userIsLoginSuccess:(void (^)(BOOL isSuccess, BOOL isFirstLogin))success withController:(UIViewController *)viewController
{    
//    DLog(@"userIsLoginSuccess->currentSaas\n%@",[kCache.currentSaasModel decodeToDic]);
//
//    DLog(@"userIsLoginSuccess->currentBossManagerAccount\n%@", [kCurrentBossManagerAccount decodeToDic]);
//
//    DLog(@"NNBAuthRequest->authRequestLoginWithPhoneNumber->saasAccountList\n%@",kCache.saasAccountList);
    
    // 当前用户已经登录
    if (kCurrentBossManagerAccount) {
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
            kCurrentBossManagerAccount.isFirstLogin = NO;
            success(isLogin,YES);
            
        }];
        BossWhiteNavigationController *loginNC = [[BossWhiteNavigationController alloc] initWithRootViewController:loginVC];
        [viewController.navigationController presentViewController:loginNC animated:!kCurrentBossManagerAccount.isFirstLogin completion:nil];
        [viewController.tabBarController setSelectedIndex:0];
    }
}

/**
 当前用户是否登录，登录信息是否过期
 
 @param loginBlock 是否登录
 @param expeiredBlock 登录是否过期（只有登录才会回调是否过期）
 */
+ (void)userIsLogin:(void(^)(BOOL isLogin))loginBlock Expired:(void (^)(BOOL isExpired))expeiredBlock
{
    [kCache initNetConfig:kCache.currentSaasModel];
    if (kCurrentBossManagerAccount) {
        // 未过期的情况 用户上次登录过 且 不需要重新登录
        if (!kCurrentBossManagerAccount.tokenModel.checkExpired) {
            kCurrentBossManagerAccount.isNeedUpdate = YES;
            kCurrentBossManagerAccount.isFirstLogin = YES;
            if (!expeiredBlock) {
                return;
            }
            expeiredBlock(YES);
        } else {
            // 过期的情况（目前不做处理，相当于没有登录过，会去重新登录(同安卓一样)）后期可以考虑刷新tocken
            kCurrentBossManagerAccount.isFirstLogin = YES;
            if (!expeiredBlock) {
                return;
            }
            expeiredBlock(NO);
        }
    } else {
        // 没有登录过
        kCurrentBossManagerAccount.isFirstLogin = YES;
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
        [[MQTTClientModel sharedInstance] disconnect];
        NSString *logoutPhone = kCurrentBossManagerAccount.accountModel.phone;
        kCache.lastLoginPhone = logoutPhone;
        [kCache addPhone:logoutPhone];
        kCurrentBossManagerAccount = nil;
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
