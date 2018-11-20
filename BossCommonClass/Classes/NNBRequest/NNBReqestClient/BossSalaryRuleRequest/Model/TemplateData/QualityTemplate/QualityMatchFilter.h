//
//  QualityMatchFilter.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import <Foundation/Foundation.h>
#import "OrderVarModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QualityMatchFilter : NSObject

/**
 骑士分类 100:全部, 1:新骑士, 2:老骑士
 */
@property (nonatomic, assign) NSInteger knight_type;

/**
 骑士标签（分组）100:全部, 其他枚举值调接口
 */
@property (nonatomic, strong) NSArray *knight_tags;

/**
 当月在离职 100:全部, 1:当月在职, 2:当月离职
 */
@property (nonatomic, assign) NSInteger state;

/**
 质量类型 1： 单人考核 2 竞赛评比
 */
@property (nonatomic, assign) NSInteger quality_type;

/**
 订单指标
 */
@property (nonatomic, strong) OrderVarModel *order_vars;


#pragma mark -- 竞赛评比

/**
 # 数据统计时间 1：按天，2：按月
 */
@property (nonatomic, assign) NSInteger statistics_time_type;

/**
 评比范围 1:商圈, 2:城市
 */
@property (nonatomic, assign) NSInteger sort_scope;

/**
 排序指标
 */
@property (nonatomic, strong) NSString *sort_index;


/**
 排序类型 1:从小到大, 2:从大到小
 */
@property (nonatomic, assign) NSInteger sort_index_type;

/**
  数据统计时间 1：按天，2：按月
 */
@property (nonatomic, strong) NSString *statistics_time_type_string;

/**
 评比范围 1:商圈, 2:城市
 */
@property (nonatomic, strong) NSString *sort_scope_string;

/**
 排序类型 1:从小到大, 2:从大到小
 */
@property (nonatomic, strong) NSString *sort_index_type_string;


@end

NS_ASSUME_NONNULL_END
