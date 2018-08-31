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

@end
