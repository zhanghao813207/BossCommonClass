//
//  ApplyOrderModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/9.
//

#import <Foundation/Foundation.h>
#import "PayeeInfoModel.h"
#import "BossBasicDefine.h"
@interface ApplyOrderModel : NSObject

@property (nonatomic, strong) NSString *_id;

/**
 科目
 */
@property (nonatomic, strong) NSString *catalog_name;

/**
 城市列表
 */
@property (nonatomic, strong) NSArray *city_list;

/**
 费用类型名称
 */
@property (nonatomic, strong) NSString *costclass_name;

/**
 费用类型type OS_COSTCLASS_TYPE
 */
@property (nonatomic, strong) NSArray <NSNumber *>*costclass_type;

/**
 城市列表
 */
@property (nonatomic, strong) NSArray *city_name_list;


/**
 创建时间
 */
@property (nonatomic, strong) NSString *created_at;

/**
 平台列表
 */
@property (nonatomic, strong) NSArray *platform_list;

/**
 供应商列表
 */
@property (nonatomic, strong) NSArray *supplier_list;

@property (nonatomic, assign) CGFloat total_money;

/**
 报销金额
 */
@property (nonatomic, assign) CGFloat reimb_money;


/**
 收款人信息
 */
@property (nonatomic, strong) PayeeInfoModel *payee_info;

/**
 断租余额
 */
@property (nonatomic, assign) CGFloat remain_money;

/**
 退租押金
 */
@property (nonatomic, assign) CGFloat deposit;

/**
 成本归属
 */
@property (nonatomic, assign) NSInteger cost_belong;

/**
合同租期起始时间
 */
@property (nonatomic, strong) NSString *contract_start_date;

/**
 申请人姓名
 */
@property (nonatomic, strong) NSString *apply_account_name;

/**
 成本归属详情 数组项为字典  只有一个key platform_code
 */
@property (nonatomic, strong) NSArray <NSDictionary *>*cost_belong_items;

/**
 成本归属详情 数组项为字典  只有一个key platform_code
 */
@property (nonatomic, strong) NSArray *cost_belong_items_zh;

/**
 成本中心
 */
@property (nonatomic, assign) NSInteger cost_center;

@property (nonatomic, strong) NSString *costclass_id;

/**
 备注
 */
@property (nonatomic, strong) NSString *desc;

/**
 审批流id
 */
@property (nonatomic, strong) NSString *examine_id;

/**
 审批单id(数字)
 */
@property (nonatomic, strong) NSString *examine_id_figure;

@property (nonatomic, assign) MOBILE_EXAMINE_TYPES examine_state;

/**
 附件地址列表
 */
@property (nonatomic, strong) NSArray <NSDictionary *>*files_address;

/**
 是否开具发票
 */
@property (nonatomic, assign) BOOL has_invoice;

/**
 历史订单
 */
@property (nonatomic, strong) NSArray <ApplyOrderModel *>*history_id_list;

/**
 房屋编号
 */
@property (nonatomic, strong) NSString *house_num;

/**
 月租金
 */
@property (nonatomic, assign) CGFloat month_rent;

@property (nonatomic, strong) NSDictionary *operation;

/**
 申请单id数字
 */
@property (nonatomic, strong) NSString *order_id_figure;

/**
 每次付款月数
 */
@property (nonatomic, assign) NSInteger pay_time;

/**
 提前付款天数
 */
@property (nonatomic, assign) NSInteger payment_date;

@property (nonatomic, strong) NSArray <NSString *>*platform_code;

/**
 职位id
 */
@property (nonatomic, assign) NSInteger position_id;

/**
 房屋状态
 */
@property (nonatomic, assign) OA_HOUSE_STATES thing_state;

/**
 用途
 */
@property (nonatomic, strong) NSString *use;

/**
 面积
 */
@property (nonatomic, assign) CGFloat area;

/**
 合同租期结束时间
 */
@property (nonatomic, strong) NSString *contract_end_date;

/**
 科目
 */
@property (nonatomic, strong) NSString *catalog_id;

/**
 房屋断租日期
 */
@property (nonatomic, strong) NSString *relet_break_date;

/**
 房屋状态字符串
 */
@property (nonatomic, strong, readonly) NSString *thingStateString;

/**
 成本中心字符
 */
@property (nonatomic, strong, readonly) NSString *costCenterString;

/**
 成本归属字符
 */
@property (nonatomic, strong, readonly) NSString *costBelongString;


@end
