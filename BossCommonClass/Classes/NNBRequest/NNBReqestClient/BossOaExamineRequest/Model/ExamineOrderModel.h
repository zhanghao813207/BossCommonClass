//
//  ExamineOrderModel.h
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/8.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "ExamineFlowTemplateModel.h"
#import "AccountModel.h"
#import "ExamineFlowRecordModel.h"
#import "CostOrderModel.h"
#import "ExamineFlowNodeModel.h"
#import "SalaryPlaneModel.h"
#import "PayrollStatementModel.h"

@interface ExamineOrderModel : NSObject

#pragma mark --brief

/**
 单笔流水号
 */
@property (nonatomic, strong) NSString *_id;

/**
 申请人ID
 */
@property (nonatomic, strong) NSString *apply_account_id;


/**
 审批流程ID
 */
@property (nonatomic, strong) NSString *flow_id;

/**
 审批流的人员
 */
@property (nonatomic, strong) NSArray *flow_accounts;

/**
 审批流通知抄送人员
 */
@property (nonatomic, strong) NSArray *cc_accounts;


/**
 前一个审批记录
 */
@property (nonatomic, strong) NSString *last_record_id;

/**
 当前进行的审批记录
 */
@property (nonatomic, strong) NSString *current_record_id;

/**
 当前审批节点ID, None 代表是提报节点
 */
@property (nonatomic, strong) NSString *current_flow_node;

/**
 流程状态
 */
@property (nonatomic, assign) OA_EXAMINE_STATE state;

/**
 节点的业务审批状态
 */
@property (nonatomic, assign) OA_EXAMINE_NODE_STATE biz_state;

/**
 本次审批的费用单IDs
 */
@property (nonatomic, strong) NSArray *cost_order_ids;

/**
 本次申请的总金额
 */
@property (nonatomic, assign) NSInteger total_money;

/**
 打款状态
 */
@property (nonatomic, assign) PAY_STATE paid_state;

/**
 打款备注
 */
@property (nonatomic, strong) NSString *paid_note;

/**
 附件地址
 */
@property (nonatomic, strong) NSArray *attachments;

/**
 创建时间
 */
@property (nonatomic, strong) NSString *created_at;

/**
 更新时间
 */
@property (nonatomic, strong) NSString *updated_at;

/**
 提交时间(成本归属时间）
 */
@property (nonatomic, strong) NSString *submit_at;

/**
 微信时间格式
 */
@property (nonatomic, strong) NSString *wchat_submit_at;


/**
 完成时间
 */
@property (nonatomic, strong) NSString *done_at;


#pragma mark --detaile

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
 审批流模版摘要
 */
@property (nonatomic, strong) ExamineFlowTemplateModel *flow_info;

/**
 申请人信息
 */
@property (nonatomic, strong) AccountModel *apply_account_info;

/**
 当前节点可审核操作（通过/驳回）的人员列表
 */
@property (nonatomic, strong) NSArray  <AccountModel *>*current_operate_account_list;

/**
 当前等待处理的人员账号列表
 */
@property (nonatomic, strong) NSArray <NSString *>*current_pending_accounts;


/**
 当前节点的审批记录详情
 */
@property (nonatomic, strong) NSArray <ExamineFlowRecordModel *>*current_record_list;

/**
 审批单的流转明细记录，倒序排列
 */
@property (nonatomic, strong) NSArray <ExamineFlowRecordModel *>*flow_record_list;

@property (nonatomic, strong) ExamineFlowNodeModel *current_flow_node_info;

/**
 消费单列表
 */
@property (nonatomic, strong) NSArray <CostOrderModel *> *cost_order_list;

/**
 薪资方案版本
 */
@property (nonatomic, strong) NSString *salary_plan_version_id;

@property (nonatomic, strong) SalaryPlaneModel *salary_plan_version_info;

/**
 薪资单版本
 */
@property (nonatomic, strong) NSString *payroll_statement_id;

@property (nonatomic, strong) PayrollStatementModel *payroll_statement_info;

@property (nonatomic, strong) NSArray <NSDictionary *>*file_url_list;

#pragma mark -- 计算属性
/**
 审批单的流转 flow_record_list 计算得来
 */
@property (nonatomic, strong) NSArray <ExamineFlowNodeModel *>*flow_node_list;

/**
 当前节点的详情 current_record_list 计算得来
 */
@property (nonatomic, strong) ExamineFlowNodeModel *current_node;


@property (nonatomic, strong) NSDictionary *file_url_dic;




@end
