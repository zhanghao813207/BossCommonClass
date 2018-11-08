//
//  OrderVarModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import <Foundation/Foundation.h>
#import "RuleModel.h"
#import "OrderRangeTableModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderVarModel : NSObject

@property (nonatomic, strong) NSString *type;

/**
 条件类型 1: 满足全部条件, 2: 满足任一条件
 */
@property (nonatomic, assign) NSInteger match_type;

/**
 条件规则
 */
@property (nonatomic, strong) NSArray <RuleModel *>*rules;

#pragma mark --  满足单条件

/**
 综合指标
 */
@property (nonatomic, strong) NSString *unit_index;

/**
 入选人数
 */
@property (nonatomic, assign) NSInteger unit_peple;

/**
 设定值
 */
@property (nonatomic, assign) NSInteger unit_val;

@end

NS_ASSUME_NONNULL_END
