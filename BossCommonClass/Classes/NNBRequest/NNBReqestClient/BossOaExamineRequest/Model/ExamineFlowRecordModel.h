//
//  ExamineFlowRecordModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/24.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "AccountModel.h"
#import "ExamineFlowNodeBriefModel.h"
@interface ExamineFlowRecordModel : NSObject

/**
 审批流转记录id
 */
@property (nonatomic, strong) NSString *_id;

/**
 归属流程节点序号, 0 代表是首个提报记录
 */
@property (nonatomic, assign) NSInteger index_num;

/**
 驳回至新记录
 */
@property (nonatomic, strong) NSString *reject_to_record_id;

/**
 驳回至节点
 */
@property (nonatomic, strong) NSString *reject_to_node_id;

/**
 驳回至节点信息
 */
@property (nonatomic, strong) ExamineFlowNodeBriefModel *reject_to_node_info;


/**
 审批状态
 */
@property (nonatomic, assign) OA_EXAMINE_NODE_STATE state;

/**
 当前记录的催办状态
 */
@property (nonatomic, assign) BOOL urge_state;

/**
 操作说明
 */
@property (nonatomic, strong) NSString *note;

/**
 审批流程节点ID: 提报记录节点为 None
 */
@property (nonatomic, strong) NSString *node_id;

/**
 审批流节点名称
 */
@property (nonatomic, strong) NSString *node_name;


/**
 创建时间
 */
@property (nonatomic, strong) NSString *created_at;

/**
 操作时间
 */
@property (nonatomic, strong) NSString *operated_at;


/**
 审批人列表
 */
@property (nonatomic, strong) NSArray <AccountModel *>*operate_account_list;


@end