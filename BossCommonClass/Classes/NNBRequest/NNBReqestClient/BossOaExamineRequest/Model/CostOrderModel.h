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
#import "BizExtraData.h"
#import "BusinessTravelOrderModel.h"

@interface CostOrderModel : NSObject

/**
 费用单ID
 */
@property (nonatomic, strong) NSString *_id;

/**
 城市名称列表
 */
@property (nonatomic, strong) NSArray *city_names;

@property (nonatomic, strong) NSArray *city_codes;


/**
 供应商名称列表
 */
@property (nonatomic, strong) NSArray *supplier_names;

@property (nonatomic, strong) NSArray *supplier_ids;


/**
 平台名称列表
 */
@property (nonatomic, strong) NSArray *platform_names;

@property (nonatomic, strong) NSArray *platform_ids;


/**
 商圈名称列表
 */
@property (nonatomic, strong) NSArray *biz_district_names;

@property (nonatomic, strong) NSArray *biz_district_ids;


/**
 费用分组名称
 */
@property (nonatomic, strong) NSString *cost_group_name;

/**
 发票标记(true 有 false 无)
 */
@property (nonatomic, assign) BOOL invoice_flag;

//发票抬头
@property (nonatomic, strong) NSString *invoice_title;

/**
 费用分摊方式
 */
@property (nonatomic, assign) ALLOCATION_MODE allocation_mode;

/**
 备注
 */
@property (nonatomic, strong) NSString *note;

/**
 附件地址列表
 */
@property (nonatomic, strong) NSArray *attachemnts;

/**
 附件下载地址列表
 */
@property (nonatomic, strong) NSArray *attachment_private_urls;

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

@property (nonatomic, strong) NSString *submit_at;

/**
 提交时间(201802 形式)
 */
@property (nonatomic, strong) NSString *submit_at_int;

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

#pragma mark - 差旅报销 - 相关属性

/**
 出差申请单ID
 */
@property (nonatomic, strong) NSString *biz_extra_travel_apply_order_id;

/**
 出差申请单
 */
@property (nonatomic, strong) BusinessTravelOrderModel *biz_extra_travel_apply_order_info;

/**
 差旅费用明细
 */
@property (nonatomic, strong) BizExtraData *biz_extra_data;


#pragma mark - Additional attribute

/**
 费用分摊方式 字符串
 */
@property (nonatomic, strong, readonly) NSString *allocation_name;

/**
    归属类型 有个人 团队
 */
@property (nonatomic, assign) CostCenterTypeV2 cost_center_type;


@end
