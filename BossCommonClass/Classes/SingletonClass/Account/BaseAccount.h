//
//  BaseAccount.h
//  AFNetworking
//
//  Created by 张浩 on 2019/2/21.
//

#import <Foundation/Foundation.h>
#import "TokenModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BaseAccount

/**
 判断用户是否登录
 
 @param success 成功登录
 @param viewController 弹出登录的控制器（一般为当前控制器）
 */
+ (void)userIsLoginSuccess:(void (^)(BOOL isSuccess, BOOL isFirstLogin))success withController:(UIViewController *)viewController;

/**
 判断登录信息是否过期
 
 @param loginBlock 是否登录
 @param expeiredBlock 登录是否过期（只有登录才会回调是否过期）
 */
+ (void)userIsLogin:(void(^)(BOOL isLogin))loginBlock Expired:(void (^)(BOOL isExpired))expeiredBlock;

/**
 用户退出登录
 
 @param confirmBlock 点击确认后的回调
 @param viewController 弹出的登录
 */
+ (void)userIsLoginOutConfirm:(void(^)(BOOL isLoginOut))confirmBlock withController:(UIViewController *)viewController;

/**
 模型转字典
 
 @return 字典
 */
- (NSDictionary *)decodeToDic;

@end

@interface BaseAccount : NSObject

@property (nonatomic, strong) TokenModel *tokenModel;

/**
 个人信息是否需要更新
 */
@property (nonatomic, assign) BOOL isNeedUpdate;

/**
 判断用户是否是第一次登录
 */
@property (nonatomic, assign) BOOL isFirstLogin;

@end

NS_ASSUME_NONNULL_END
