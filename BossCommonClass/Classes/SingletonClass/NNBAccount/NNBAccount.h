//
//  NNBAccount.h
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/27.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProviderModel.h"
#import "AccountInfoModel.h"
#import "NNBBasicDefine.h"
@interface NNBAccount : NSObject

+ (__kindof NNBAccount *)defaultAccount;

/**
 当前登录者ID
 */
@property (nonatomic, assign, readonly) NSInteger account_id;

/**
 姓名
 */
@property (nonatomic, strong, readonly) NSString *name;

/**
 Access token
 */
@property (nonatomic, strong, readonly) NSString *access_token;

/**
 手机号
 */
@property (nonatomic, strong, readonly) NSString *mobile;

/**
 Refresh token
 */
@property (nonatomic, strong, readonly) NSString *refresh_token;

/**
 过期时间 (时间戳)
 */
@property (nonatomic, strong, readonly) NSString *expired_at;

/**
 所属组织／服务商 (貌似当前接口已经没有此参数)
 */
@property (nonatomic, strong, readonly) ProviderModel *provider;

/**
 用户角色 (ACCOUNT_ROLE)列表
 */
@property (nonatomic, strong, readonly) NSArray *roles;

/**
 用户信息
 */
@property (nonatomic, strong, readonly) AccountInfoModel *account_info;

/**
 当前执行的任务id taskID
 */
@property (nonatomic, strong, readonly) NSString *taskId;

/**
 更新当前的任务id
 
 @param taskId 任务id
 */
- (void)updateCurrentTaskId:(NSString *)taskId;

/**
 当前账号的工作状态 默认为 休息(ACCOUNT_STATE_REST)
 */
@property (nonatomic, assign, readonly) ACCOUNT_STATE workState;

/**
 更新工作状态

 @param workState 工作状态
 */
- (void)updateWorkingState:(ACCOUNT_STATE)workState;

/**
 当前扫楼的ID
 */
@property (nonatomic, strong, readonly) NSString *currentBuildingID;

/**
 更新扫楼ID

 @param currentBuildingID 扫楼ID
 */
- (void)updateCurrentBuildingID:(NSString *)currentBuildingID;


/** 用户-- 判断用户有没有登录 */
+ (void)userIsLoginSuccess:(void (^)(BOOL isSuccess))success withController:(UIViewController *)viewController;


@end
