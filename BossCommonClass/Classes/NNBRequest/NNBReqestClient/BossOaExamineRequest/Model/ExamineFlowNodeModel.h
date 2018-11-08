//
//  ExamineFlowNodeModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/24.
//

#import "ExamineFlowNodeBriefModel.h"
#import "ExamineFlowRecordModel.h"

@interface ExamineFlowNodeModel : ExamineFlowNodeBriefModel

/**
 流程节点索引序号， 0 开始
 */
@property (nonatomic, assign) NSInteger index_num;

#pragma mark -- 计算属性
/**
 审批流记录列表
 */
@property (nonatomic, strong) NSArray <ExamineFlowRecordModel *>*record_list;

/**
 审批状态
 */
@property (nonatomic, assign) OA_EXAMINE_NODE_STATE state;

/**
 当前记录的催办状态
 */
@property (nonatomic, assign) BOOL urge_state;


@end
