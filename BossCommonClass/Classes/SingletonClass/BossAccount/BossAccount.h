//
//  BossAccount.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/7/16.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "PermissionModel.h"
#import "SupplierModel.h"
#import "CityModel.h"
#import "PlatformModel.h"
#import "BizDistrictModel.h"

@interface BossAccount : NSObject

+ (__kindof BossAccount *)defaultAccount;

/**
 用户id
 */
@property (nonatomic, strong) NSString *account_id;

/**
 权限
 */
@property (nonatomic, strong) NSArray <PermissionModel *>*permission;

/**
 供应商级联
 */
@property (nonatomic, strong) NSArray *supplier_cascade_list;

/**
 城市级联
 */
@property (nonatomic, strong) NSArray *city_cascade_list;

/**
 更新时间
 */
@property (nonatomic, strong) NSString *updated_at;

/**
 用户手机号
 */
@property (nonatomic, strong) NSString *phone;

/**
 操作人ID
 */
@property (nonatomic, strong) NSString *operator_id;

/**
 角色
 */
@property (nonatomic, strong) NSString *position_name;

/**
 员工id
 */
@property (nonatomic, strong) NSString *staff_id;

/**
 用户姓名
 */
@property (nonatomic, strong) NSString *name;

/**
 城市列表
 */
@property (nonatomic, strong) NSArray <CityModel *>*city_list;

/**
 平台列表
 */
@property (nonatomic, strong) NSArray <PlatformModel *>*platform_list;

/**
 商圈列表
 */
@property (nonatomic, strong) NSArray <BizDistrictModel *>*biz_district_list;

/**
 供应商列表
 */
@property (nonatomic, strong) NSArray <SupplierModel *>*supplier_list;

/**
 创建时间
 */
@property (nonatomic, strong) NSString *created_at;

/**
 状态
 */
@property (nonatomic, assign) NSInteger state;

/**
 职位id
 */
@property (nonatomic, assign) PositionID position_id;

/**
 角色id
 */
@property (nonatomic, assign) NSInteger gid;

/**
 操作人
 */
@property (nonatomic, strong) NSString *operator_name;

/**
 用户ID
 */
@property (nonatomic, strong) NSString *_id;

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
