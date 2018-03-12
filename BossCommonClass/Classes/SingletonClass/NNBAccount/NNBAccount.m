//
//  NNBAccount.m
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/27.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "NNBAccount.h"
#import "NNBWhiteNavigationController.h"
#import "LoginVC.h"

@interface NNBAccount()

@property (nonatomic, assign) NSInteger account_id;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *access_token;

@property (nonatomic, strong) NSString *mobile;

@property (nonatomic, strong) NSString *refresh_token;

@property (nonatomic, strong) NSString *expired_at;

@property (nonatomic, strong) ProviderModel *provider;

@property (nonatomic, strong) AccountInfoModel *account_info;

@property (nonatomic, strong) NSString *taskId;

@property (nonatomic, strong) NSArray *roles;

@end


@implementation NNBAccount

static NNBAccount *defaultAccount = nil;

+ (__kindof NNBAccount *)defaultAccount
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultAccount = [[NNBAccount alloc] init];
    });
    return defaultAccount;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"provider"]) {
        ProviderModel *providerModel = [[ProviderModel alloc] init];
        if ([value isKindOfClass:[NSDictionary class]]) {
            [providerModel setValuesForKeysWithDictionary:value];
        }
        self.provider = providerModel;
    } else if([key isEqualToString:@"account_info"]){
        AccountInfoModel *model = [[AccountInfoModel alloc] init];
        if ([value isKindOfClass:[NSDictionary class]]) {
            [model setValuesForKeysWithDictionary:value];
        }
        self.account_info = model;
    } else if([key isEqualToString:@"roles"]){
        self.roles = value;
    } else if([key isEqualToString:@"expired_at"]){
        self.expired_at = [NSString stringWithFormat:@"%@",value];
    } else {
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key
{
    
}

- (void)updateCurrentTaskId:(NSString *)taskId
{
    self.taskId = taskId;
    if (!taskId) {
        [kUserDefault removeObjectForKey:@"currentTaskId"];
        return;
    }
    [kUserDefault setObject:taskId forKey:@"currentTaskId"];
    [kUserDefault synchronize];
}

- (NSString *)taskId
{
    if (!_taskId) {
        _taskId = [kUserDefault objectForKey:@"currentTaskId"];
    }
    return _taskId;
}

/**
 更新工作状态
 
 @param workState 工作状态
 */
- (void)updateWorkingState:(ACCOUNT_STATE)workState
{
    _workState = workState;
}

/**
 更新扫楼ID
 
 @param currentBuildingID 扫楼ID
 */
- (void)updateCurrentBuildingID:(NSString *)currentBuildingID
{
    _currentBuildingID = currentBuildingID;
}

/** 用户-- 判断用户有没有登录 */
+ (void)userIsLoginSuccess:(void (^)(BOOL isSuccess))success withController:(UIViewController *)viewController
{
    // 当前用户已经登录
    if (kCurrentAccount.account_id != 0) {
        if (success) {
            success(YES);
        }
        return;
    }
    // 用户需要登录
    if ([viewController isKindOfClass:[UIViewController class]]) {
        LoginVC *loginVC = [[LoginVC alloc] init];
        loginVC.loginSuccessBlock = success;
        NNBWhiteNavigationController *loginNC = [[NNBWhiteNavigationController alloc] initWithRootViewController:loginVC];
        [viewController.navigationController presentViewController:loginNC animated:YES completion:nil];
    }
}



@end
