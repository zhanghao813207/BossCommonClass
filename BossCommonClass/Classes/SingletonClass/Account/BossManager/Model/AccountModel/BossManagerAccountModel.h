//
//  BossManagerAccountModel.h
//  AFNetworking
//
//  Created by 张浩 on 2019/2/20.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "PermissionModel.h"
#import "SupplierModel.h"
#import "CityModel.h"
#import "PlatformModel.h"
#import "BizDistrictModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface BossManagerAccountModel : NSObject

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
 人员id
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

/// 是否是超级管理员
@property (nonatomic, assign) BOOL is_admin;


///**
// 保险授权
// */
//@property (nonatomic, assign,readonly) BOOL safeAuth;
//

/**
 模型转字典
 
 @return 字典
 */
- (NSDictionary *)decodeToDic;

@end

NS_ASSUME_NONNULL_END
