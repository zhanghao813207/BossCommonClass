//
//  ApplicationUrgeRecordModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/9/2.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "AccountModel.h"
#import "ExamineOrderModel.h"
#import "ExamineFlowRecordModel.h"
@interface ApplicationUrgeRecordModel : NSObject

/**
 催办记录id
 */
@property (nonatomic, strong) NSString *_id;

/**
 OA申请审批单ID
 */
@property (nonatomic, strong) NSString *order_id;

/**
 审批流程ID
 */
@property (nonatomic, strong) NSString *flow_id;

/**
 审批流程节点ID
 */
@property (nonatomic, strong) NSString *node_id;

/**
 OA审批单流转明细记录ID
 */
@property (nonatomic, strong) NSString *flow_record_id;

/**
 发起人id
 */
@property (nonatomic, strong) NSString *created_by;

/**
 催办对象(审批人) 可多人
 */
@property (nonatomic, strong) NSArray *notify_account;

/**
 1 未处理 100 已办理 -100 关闭
 */
@property (nonatomic, assign) URGE_RECORD_STATE  state;

/**
 更新时间
 */
@property (nonatomic, strong) NSString *updated_at;

/**
 创建时间
 */
@property (nonatomic, strong) NSString *created_at;

/**
 创建人信息
 */
@property (nonatomic, strong) AccountModel *creator_info;

/**
 OA审批单信息
 */
@property (nonatomic, strong) ExamineOrderModel *application_order_info;

/**
 OA审批单流转明细记录
 */
@property (nonatomic, strong) ExamineFlowRecordModel *flow_record_info;


@end
