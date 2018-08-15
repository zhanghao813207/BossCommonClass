//
//  ExamineFlowModel.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/8.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "ExamineNodeMdoel.h"
#import "ApplyOrderModel.h"
@interface ExamineFlowModel : NSObject

/**
 审批树
 */
@property (nonatomic, strong) NSArray *examine_tree;

/**
 是否显示催报按钮
 */
@property (nonatomic, assign) BOOL can_alert;

/**
 包含的申请单条数
 */
@property (nonatomic, assign) NSInteger apply_order_len;

/**
 费用类型列表
 */
@property (nonatomic, strong) NSArray *costclass_list;

/**
 审批单id(数字)
 */
@property (nonatomic, strong) NSString *examine_id_figure;

/**
 是否能编辑
 */
@property (nonatomic, assign) BOOL conceal;

/**
 备注
 */
@property (nonatomic, strong) NSString *pay_note;

/**
 创建时间
 */
@property (nonatomic, strong) NSString *created_at;

/**
 申请人
 */
@property (nonatomic, strong) NSString *apply_account;


/**
 状态 -1 不通过 0 待提交 1 等待审核 2 审核通过
 */
@property (nonatomic, assign) OA_EXAMINE_STATE  state;

/**
 出纳编辑付款状态
 */
@property (nonatomic, assign) NSInteger pay_state;

/**
 费用模板
 */
@property (nonatomic, assign) NSInteger templateID;

/**
 是否能够审批
 */
@property (nonatomic, assign) BOOL can_examine;

/**
 审批流名称
 */
@property (nonatomic, strong) NSString *flow_name;

/**
 总金额
 */
@property (nonatomic, assign) CGFloat total_money;

/**
 判断当前账号是否有权限编辑付款状态 角色为出纳为1 有权限, 其他为-1 无权限
 */
@property (nonatomic, assign) NSInteger is_operate;

/**
 归属城市名称
 */
@property (nonatomic, strong) NSArray <NSString *>*city_list;

/**
 最新审批信息
 */
@property (nonatomic, strong) ExamineNodeMdoel *examine;

/**
 审批信息
 */
@property (nonatomic, strong) NSArray <ExamineNodeMdoel *>*examine_list;

/**
 归属供应商名称
 */
@property (nonatomic, strong) NSArray *supplier_list;

/**
 审批流名称
 */
@property (nonatomic, strong) NSString *examineflow_name;

/**
 审批细节列表
 */
@property (nonatomic, strong) NSArray <ExamineNodeMdoel *>*examineflow_detail_list;

/**
 申请单
 */
@property (nonatomic, strong) NSArray <ApplyOrderModel *>*data;

/**
 归属平台名称
 */
@property (nonatomic, strong) NSArray *platform_list;

/**
 职位
 */
@property (nonatomic, assign) NSInteger gid;

/**
 流水号
 */
@property (nonatomic, strong) NSString *examine_id;

/**
 催报按钮显示状态(催办提醒false/已催办true)
 */
@property (nonatomic, assign) BOOL is_alert;

@property (nonatomic, strong, readonly) NSString *gidString;


@end
