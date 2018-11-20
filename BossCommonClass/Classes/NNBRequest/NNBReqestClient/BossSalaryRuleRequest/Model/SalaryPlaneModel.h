//
//  SalaryPlaneModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "ComputeDatasetInfoModel.h"
#import "SalaryComputeDatasetModel.h"
#import "TemplateRuleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SalaryPlaneModel : NSObject

@property (nonatomic, strong) NSString *_id;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *revision;

@property (nonatomic, strong) NSString *platform_code;

@property (nonatomic, strong) NSString *supplier_id;

@property (nonatomic, strong) NSString *city_code;

@property (nonatomic, strong) NSString *biz_district_id;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, assign) StatementDataDomain domain;

@property (nonatomic, strong) NSArray *rules;

@property (nonatomic, strong) NSString *config_version_id;

@property (nonatomic, strong) NSString *from_date;

@property (nonatomic, strong) NSString *to_date;

@property (nonatomic, strong) NSString *oa_applied_at;

@property (nonatomic, strong) NSString *oa_done_at;

@property (nonatomic, strong) NSString *active_at;

@property (nonatomic, strong) NSString *closed_at;

@property (nonatomic, strong) NSString *updated_at;

@property (nonatomic, strong) NSString *created_at;

@property (nonatomic, strong) NSString *disabled_at;

@property (nonatomic, strong) NSString *creator_id;

@property (nonatomic, strong) NSString *operator_id;

@property (nonatomic, strong) NSString *oa_apply_operator_id;

@property (nonatomic, strong) NSString *oa_operator_id;

@property (nonatomic, strong) NSString *dry_run_task_id;

@property (nonatomic, strong) NSString *city_name;

@property (nonatomic, strong) NSString *biz_district_name;

@property (nonatomic, strong) NSString *plan_id;

@property (nonatomic, strong) NSString *plan_version_id;

@property (nonatomic, strong) NSString *plan_revision_id;

/**
 试算上下文
 */
@property (nonatomic, strong) NSDictionary *compute_context;

@property (nonatomic, strong) NSString *vdoing;

/**
 试算数据
 */
@property (nonatomic, strong) ComputeDatasetInfoModel *compute_data_set;

@property (nonatomic, strong) SalaryComputeDatasetModel *compute_task_info;

/**
 是否允许试算
 */
@property (nonatomic, assign) BOOL can_allow_compute;

/**
 是否可以编辑
 */
@property (nonatomic, assign) BOOL can_allow_edit;

/**
 城市名字
 */
@property (nonatomic, strong) NSString *oa_application_order_id;

@property (nonatomic, strong) NSString *platform_name;

@property (nonatomic, strong) NSString *salary_var_plan_id;

@property (nonatomic, strong) NSString *salary_var_plan_version_id;

@property (nonatomic, strong) NSString *supplier_name;

@property (nonatomic, strong) NSArray <TemplateRuleModel *>*rules_list;

@property (nonatomic, strong) NSString *computeMonth;


@end

NS_ASSUME_NONNULL_END
