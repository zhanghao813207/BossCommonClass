//
//  QuaComputeLogic.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import <Foundation/Foundation.h>
#import "RangeParamModel.h"
#import "MultipleParamModel.h"
#import "BattleParamModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QuaComputeLogic : NSObject

/**
 数据聚合维度 1：按天，2：按月
 */
@property (nonatomic, assign) NSInteger data_group_by;

/**
 ['qc_logic_by_range|qc_logic_by_multiple']
 */
@property (nonatomic, strong) NSArray *biz_logic;

@property (nonatomic, strong) RangeParamModel *range_params;

@property (nonatomic, strong) NSArray <MultipleParamModel *>*multiple_params;

#pragma mark -- 竞赛评比

/**
 [1,2], # 1 奖励法 2 竞赛评比
 */
@property (nonatomic, strong) NSArray *set_flag;

#pragma mark -- 按多组条件设置

/**
 奖罚方式 1：按阶梯，2：按多组条件
 */
@property (nonatomic, assign) NSInteger condtions_type;


/**
 # 竞赛
 */
@property (nonatomic, strong) BattleParamModel *battle_params;

@end

NS_ASSUME_NONNULL_END
