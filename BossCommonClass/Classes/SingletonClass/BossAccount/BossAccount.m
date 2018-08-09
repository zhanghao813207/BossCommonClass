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
    
    if ([key isEqualToString:@"permission"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            PermissionModel *model = [[PermissionModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.permission = [array copy];
        return;
    }

    if ([key isEqualToString:@"supplier_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            SupplierModel *model = [[SupplierModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.supplier_list = [array copy];
        return;
    }
    
    if ([key isEqualToString:@"city_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            CityModel *model = [[CityModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.city_list = [array copy];
        return;
    }

    if ([key isEqualToString:@"platform_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            PlatformModel *model = [[PlatformModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.platform_list = [array copy];
        return;
    }
    
    if ([key isEqualToString:@"biz_district_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            BizDistrictModel *model = [[BizDistrictModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.biz_district_list = [array copy];
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
    if (kCurrentBossAccount.account_id && ![kCurrentBossAccount.account_id isEqualToString:@""]) {
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
            kCurrentBossAccount.isFirstLogin = NO;
            success(isLogin,YES);
        }];
        BossWhiteNavigationController *loginNC = [[BossWhiteNavigationController alloc] initWithRootViewController:loginVC];
        [viewController.navigationController presentViewController:loginNC animated:!kCurrentBossAccount.isFirstLogin completion:nil];
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
            [kCurrentBossAccount setValuesForKeysWithDictionary:dic];
            kCurrentBossAccount.isNeedUpdate = YES;
            kCurrentBossAccount.isFirstLogin = YES;
            if (!expeiredBlock) {
                return;
            }
            expeiredBlock(YES);
        } else {
            // 过期的情况（目前不做处理，相当于没有登录过，会去重新登录(同安卓一样)）后期可以考虑刷新tocken
            kCurrentBossAccount.isFirstLogin = YES;
            if (!expeiredBlock) {
                return;
            }
            expeiredBlock(NO);
        }
    } else {
        // 没有登录过
        kCurrentBossAccount.isFirstLogin = YES;
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

/**
 模型转字典
 
 @return 字典
 */
- (NSDictionary *)decodeToDic
{
    NSDictionary *localAccountInfoDic = @{
                                          @"state":@(self.state),
                                          @"position_id":@(self.position_id),
                                          @"gid":@(self.gid),

                                          @"account_id":self.account_id ? : @"",
                                          @"phone":self.phone ? : @"",
                                          @"staff_id":self.staff_id ? : @"",
                                          @"name":self.name ? : @"",
                                          @"updated_at":self.updated_at ? : @"",
                                          @"operator_id":self.operator_id ? : @"",
                                          @"position_name":self.position_name ? : @"",
                                          @"created_at":self.created_at ? : @"",
                                          @"operator_name":self.operator_name ? : @"",
                                          @"_id":self._id ? : @"",


                                          @"access_token":self.access_token ? : @"",
                                          @"refresh_token":self.refresh_token ? : @"",
                                          @"expired_at":self.expired_at ? : @"",

                                          
                                          @"supplier_cascade_list":self.supplier_cascade_list ? : @[],
                                          @"city_cascade_list":self.city_cascade_list ? : @[],
                                          
                                          @"permission": [JYCSimpleToolClass encodeArrayToArray:self.permission],
                                          @"city_list": [JYCSimpleToolClass encodeArrayToArray:self.city_list],
                                          @"platform_list": [JYCSimpleToolClass encodeArrayToArray:self.platform_list],
                                          @"biz_district_list": [JYCSimpleToolClass encodeArrayToArray:self.biz_district_list],
                                          @"supplier_list": [JYCSimpleToolClass encodeArrayToArray:self.supplier_list],

                                          };
    return localAccountInfoDic;
}

@end
