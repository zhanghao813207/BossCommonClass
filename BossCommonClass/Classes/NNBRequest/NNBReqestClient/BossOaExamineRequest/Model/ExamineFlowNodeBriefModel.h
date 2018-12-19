//
//  ExamineFlowNodeBriefModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/31.
//

#import <Foundation/Foundation.h>
#import "AccountModel.h"

@interface ExamineFlowNodeBriefModel : NSObject

/**
 节点id
 */
@property (nonatomic, strong) NSString *_id;

/**
 节点名称
 */
@property (nonatomic, strong) NSString *name;

/**
 节点审批人摘要列表
 */
@property (nonatomic, strong) NSArray <AccountModel *>*account_list;

/**
 是否是支付节点
 */
@property (nonatomic, assign) BOOL is_payment_node;

/**
 流程节点索引序号， 0 开始
 */
@property (nonatomic, assign) NSInteger index_num;

/**
  是否可修改提报的费用记录
 */
@property (nonatomic, assign) BOOL can_update_cost_record;

/**
 费用记录修改规则
 */
@property (nonatomic, assign) CostUpdateRule cost_update_rule;

@property (nonatomic, assign) NodePickMode pick_mode;

@property (nonatomic, assign) NodeApproveMode approve_mode;


@end
