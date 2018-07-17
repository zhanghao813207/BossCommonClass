//
//  BossAccount.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/7/16.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "JurisdictionalPositionModel.h"
#import "JurisdictionalRoleModel.h"
#import "PermissionModel.h"
#import "AllowExchangeAccountModel.h"
#import "RegionModel.h"

@interface BossAccount : NSObject

+ (__kindof BossAccount *)defaultAccount;

/**
 用户id
 */
@property (nonatomic, strong) NSString *account_id;

/**
 权限
 */
@property (nonatomic, strong) PermissionModel *permission;

/**
 可管辖职位列表
 */
@property (nonatomic, strong) NSArray <JurisdictionalPositionModel *>*jurisdictional_position_list;

/**
 用户手机号
 */
@property (nonatomic, strong) NSString *phone;

/**
 员工id
 */
@property (nonatomic, strong) NSString *staff_id;
/**
 用户姓名
 */
@property (nonatomic, strong) NSString *name;

/**
 范围
 */
@property (nonatomic, strong) NSArray <RegionModel *>*region;

/**
 权限id列表
 */
@property (nonatomic, strong) NSArray *permission_id_list;

/**
 可切换的账号
 */
@property (nonatomic, strong) NSArray <AllowExchangeAccountModel *>*allow_exchange_account;

/**
 职位id
 */
@property (nonatomic, assign) PositionID position_id;

/**
 角色id
 */
@property (nonatomic, assign) NSInteger gid;

/**
 可管辖角色列表
 */
@property (nonatomic, strong) NSArray <JurisdictionalRoleModel *>*jurisdictional_role_list;

/**
 access_token
 */
@property (nonatomic, strong) NSString *access_token;

/**
 refresh_token
 */
@property (nonatomic, strong) NSString *refresh_token;

/**
 过期时间
 */
@property (nonatomic, strong) NSString *expired_at;

#pragma mark -- help property

/**
 个人信息是否需要更新
 */
@property (nonatomic, assign) BOOL isNeedUpdate;

/**
 判断用户是否是第一次登录
 */
@property (nonatomic, assign) BOOL isFirstLogin;

/**
 判断用户是否登录
 
 @param success 成功登录
 @param viewController 弹出登录的控制器（一般为当前控制器）
 */
+ (void)userIsLoginSuccess:(void (^)(BOOL isSuccess, BOOL isFirstLogin))success withController:(UIViewController *)viewController;

/**
 当前用户是否登录，登录信息是否过期
 
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

/**
 清除登录数据
 */
+ (void)clearAccountInfo;

@end
