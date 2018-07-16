//
//  BossAccount.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/7/16.
//

#import "BossAccount.h"
#import "BossWhiteNavigationController.h"
#import "LoginVC.h"
#import "NNBRequestManager.h"

@implementation BossAccount

static BossAccount *defaultAccount = nil;

+ (__kindof BossAccount *)defaultAccount
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultAccount = [[BossAccount alloc] init];
    });
    return defaultAccount;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
//    if ([key isEqualToString:@"sku_lines"]) {
//        PosInfoModel *model = [[PosInfoModel alloc] init];
//        [model setValuesForKeysWithDictionary:value];
//        self.sku_lines = model;
//        return;
//    }
//
//    if ([key isEqualToString:@"sku_lines"]) {
//        NSMutableArray *array = [NSMutableArray array];
//        for (NSDictionary *dic in value) {
//            PosInfoModel *model = [[PosInfoModel alloc] init];
//            [model setValuesForKeysWithDictionary:dic];
//            [array addObject:model];
//        }
//        self.sku_lines = [array copy];
//        return;
//    }
    
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
    if (defaultAccount.account_id && ![defaultAccount.account_id isEqualToString:@""]) {
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
            defaultAccount.isFirstLogin = NO;
            success(isLogin,YES);
        }];
        BossWhiteNavigationController *loginNC = [[BossWhiteNavigationController alloc] initWithRootViewController:loginVC];
        [viewController.navigationController presentViewController:loginNC animated:!defaultAccount.isFirstLogin completion:nil];
    }
}

/**
 当前用户是否登录，登录信息是否过期
 
 @param loginBlock 是否登录
 @param expeiredBlock 登录是否过期（只有登录才会回调是否过期）
 */
+ (void)userIsLogin:(void(^)(BOOL isLogin))loginBlock Expired:(void (^)(BOOL isExpired))expeiredBlock
{
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:AccountInfoKey];
    if (dic) {
        // 未过期的情况 用户上次登录过 且 不需要重新登录
        if (![[NNBRequestManager shareNNBRequestManager] accountTockenIsExpiredWithExpired_at:dic[@"expired_at"]]) {
            [kCurrentAccount setValuesForKeysWithDictionary:dic];
            kCurrentAccount.isNeedUpdate = YES;
            kCurrentAccount.isFirstLogin = YES;
            if (!expeiredBlock) {
                return;
            }
            expeiredBlock(NO);
        } else {
            // 过期的情况（目前不做处理，相当于没有登录过，会去重新登录(同安卓一样)）后期可以考虑刷新tocken
            kCurrentAccount.isFirstLogin = YES;
            if (!expeiredBlock) {
                return;
            }
            expeiredBlock(YES);
        }
    } else {
        // 没有登录过
        kCurrentAccount.isFirstLogin = YES;
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
        [self clearAccountInfo];
        if (!confirmBlock) {
            return;
        }
        confirmBlock(YES);
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:photoAction];
    [viewController.navigationController presentViewController:alertController animated:YES completion:nil];
}

+ (void)clearAccountInfo
{
    defaultAccount = [[BossAccount alloc] init];
    [kUserDefault removeObjectForKey:AccountInfoKey];
    [kUserDefault synchronize];
    [[NNBRequestManager shareNNBRequestManager] cleanToken];
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
    NSDictionary *localAccountInfoDic = @{
                                          @"position_id":@(self.position_id),
                                          @"gid":@(self.gid),

                                          @"account_id":self.account_id ? : @"",
                                          @"phone":self.phone ? : @"",
                                          @"staff_id":self.staff_id ? : @"",
                                          @"name":self.name ? : @"",

                                          @"access_token":self.access_token ? : @"",
                                          @"refresh_token":self.refresh_token ? : @"",
                                          @"expired_at":self.expired_at ? : @"",

                                          @"permission":self.permission ? : @[],
                                          @"all_permission":self.all_permission ? : @[],
                                          @"region":self.region ? : @[],
                                          @"permission_id_list":self.permission_id_list ? : @[],
                                          @"allow_exchange_account":self.allow_exchange_account ? : @[],
                                          @"jurisdictional_role_list":self.jurisdictional_role_list ? : @[],
                                          
                                          @"jurisdictional_position_list":self.jurisdictional_position_list ? [self encodeArrayToArray:self.jurisdictional_position_list] : @[],

                                          };
    return localAccountInfoDic;
}

@end
