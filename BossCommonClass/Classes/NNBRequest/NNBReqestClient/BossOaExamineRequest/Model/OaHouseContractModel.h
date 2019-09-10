//
//  OaHouseContractModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/24.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"

@interface OaHouseContractModel : NSObject

/**
 房屋/合同 id
 */
@property (nonatomic, strong) NSString *_id;

/**
 房屋编号
 */
@property (nonatomic, strong) NSString *house_num;

/**
 房屋地址
 */
@property (nonatomic, strong) NSString *house_address;

/**
 房东姓名
 */
@property (nonatomic, strong) NSString *landlord_name;

/**
 用途
 */
@property (nonatomic, strong) NSString *usage;

/**
 附件地址
 */
@property (nonatomic, strong) NSArray *attachment_private_urls;

/**
 押几付几
 */
@property(nonatomic, assign)NSInteger payment_method_pledge;

@property(nonatomic, assign)NSInteger payment_method_rent;

/**
 执行状态(房屋状态)
 */
@property (nonatomic, assign) OA_HOUSE_STATES state;

/**
 面积
 */
@property (nonatomic, strong) NSString *area;

/**
 合同租期起始时间(租房)
 */
@property (nonatomic) NSInteger contract_start_date;

/**
 合同租期结束时间（租房）
 */
@property (nonatomic) NSInteger contract_end_date;

/**
 押金
 */
@property (nonatomic, assign) NSInteger pledge_money;

/**
 中介费
 */
@property (nonatomic, assign) NSInteger agent_money;

/**
 租金（租房)
 */
@property (nonatomic, assign) NSInteger month_money;

/**
 每次付款月数（租房）
 */
@property (nonatomic, assign) NSInteger pay_time;

/**
 单次/续租付款（租房）
 */
@property (nonatomic, assign) NSInteger perid_money;

/**
 提前付款天数
 */
@property (nonatomic, assign) NSInteger prepare_pay_days;

/**
 房屋断租余额
 */
@property (nonatomic, assign) NSInteger remain_money;

/**
 房屋断租日期
 */
@property (nonatomic, strong) NSString *break_date;

/**
 退租押金
 */
@property (nonatomic, assign) NSInteger deposit_money;

/**
 退租押金损失
 */
@property (nonatomic, assign) NSInteger lost_money;

/**
 记录下一次续租续租时间
 */
@property (nonatomic, strong) NSString *next_pay_time;

/**
 续租次数
 */
@property (nonatomic, assign) NSInteger pay_num;

/**
 附件地址列表
 */
@property (nonatomic, strong) NSArray *attachments;


@end
