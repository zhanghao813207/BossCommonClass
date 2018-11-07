//
//  SalaryComputeDatasetModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/7.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "ComputeDatasetInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SalaryComputeDatasetModel : NSObject

/**
 试算结果id
 */
@property (nonatomic, strong) NSString *_id;

/**
 计算任务ID
 */
@property (nonatomic, strong) NSString *task_id;

/**
 计算会话ID
 */
@property (nonatomic, strong) NSString *session_id;

/**
 类型 1（员工明细）2（商圈）3（城市）
 */
@property (nonatomic, assign) SalaryComputeTaskType type;

/**
 员工id
 */
@property (nonatomic, strong) NSString *staff_id;

/**
 供应商id
 */
@property (nonatomic, strong) NSString *supplier_id;

/**
 平台code
 */
@property (nonatomic, strong) NSString *platform_code;

/**
 城市code
 */
@property (nonatomic, strong) NSString *city_code;

/**
 商圈id
 */
@property (nonatomic, strong) NSString *biz_district_id;

/**
 工作类型 3001（全职）3002（兼职）
 */
@property (nonatomic, assign) STAFFWORKTYPE work_type;

/**
 薪资方案ID
 */
@property (nonatomic, strong) NSString *plan_id;

/**
 薪资方案版本ID
 */
@property (nonatomic, strong) NSString *plan_version_id;

/**
 薪资方案修订版本号（规则每次修改均变化）
 */
@property (nonatomic, strong) NSString *plan_revision_id;

/**
 计算结果集
 */
@property (nonatomic, strong) ComputeDatasetInfoModel *data;

/**
 源数据起始日期(yyyymmdd)
 */
@property (nonatomic, assign) NSInteger start_date;

/**
 源数据结束日期(yyyymmdd)
 */
@property (nonatomic, assign) NSInteger end_date;

/**
 创建时间
 */
@property (nonatomic, strong) NSString *created_at;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, assign) NSInteger from_date;

@property (nonatomic, assign) NSInteger to_date;

@property (nonatomic, strong) NSString *city_name;

@property (nonatomic, strong) NSString *updated_at;


@end

NS_ASSUME_NONNULL_END
