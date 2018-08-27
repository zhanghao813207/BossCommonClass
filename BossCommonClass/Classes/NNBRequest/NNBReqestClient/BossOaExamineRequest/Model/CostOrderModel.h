//
//  CostOrderModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/24.
//

#import <Foundation/Foundation.h>
#import "PayeeInfoModel.h"
#import "CostAccountingModel.h"
#import "AccountModel.h"
#import "OaHouseContractModel.h"
#import "CostAllocationModel.h"
@interface CostOrderModel : NSObject

/**
 费用单ID
 */
@property (nonatomic, strong) NSString *_id;

/**
 城市名称列表
 */
@property (nonatomic, strong) NSArray *city_names;

/**
 供应商名称列表
 */
@property (nonatomic, strong) NSArray *supplier_names;

/**
 平台名称列表
 */
@property (nonatomic, strong) NSArray *platform_names;

/**
 商圈名称列表
 */
@property (nonatomic, strong) NSArray *biz_district_names;

/**
 费用分组名称
 */
@property (nonatomic, strong) NSString *cost_group_name;

/**
 发票标记(true 有 false 无)
 */
@property (nonatomic, assign) BOOL invoice_flag;

/**
 备注
 */
@property (nonatomic, strong) NSString *note;

/**
 附件地址列表
 */
@property (nonatomic, strong) NSArray *attachemnts;

/**
 用途
 */
@property (nonatomic, strong) NSString *usage;

/**
 收款人信息
 */
@property (nonatomic, strong) PayeeInfoModel *payee_info;

/**
 总金额
 */
@property (nonatomic, assign) NSInteger total_money;

/**
 创建时间
 */
@property (nonatomic, strong) NSString *created_at;

/**
 费用科目
 */
@property (nonatomic, strong) CostAccountingModel *cost_accounting_info;


#pragma mark - detail

/**
 申请人信息
 */
@property (nonatomic, strong) AccountModel *apply_account_info;

/**
 租房合同
 */
@property (nonatomic, strong) OaHouseContractModel *biz_extra_house_contract_info;

/**
 OA 成本费用记录分摊清单
 */
@property (nonatomic, strong) NSArray <CostAllocationModel *>*cost_allocation_list;


@end
