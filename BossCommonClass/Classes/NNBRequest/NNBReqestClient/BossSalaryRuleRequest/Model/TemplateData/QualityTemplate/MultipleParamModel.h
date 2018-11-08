//
//  MultipleParamModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import <Foundation/Foundation.h>
#import "RuleModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MultipleParamModel : NSObject

/**
 条件类型 1: 满足全部条件, 2: 满足任一条件
 */
@property (nonatomic, assign) NSInteger match_type;

/**
 条件规则
 */
@property (nonatomic, strong) NSArray <RuleModel *>*rules;

/**
 按？指标
 */
@property (nonatomic, strong) NSString *unit_index;

/**
 每？单
 */
@property (nonatomic, assign) NSInteger unit_amount;

/**
 奖励/扣罚？元
 */
@property (nonatomic, assign) NSInteger unit_money;

@end

NS_ASSUME_NONNULL_END
