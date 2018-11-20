//
//  AttendanceMatchFilter.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import <Foundation/Foundation.h>
#import "OrderVarModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AttendanceMatchFilter : NSObject

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
 订单指标
 */
@property (nonatomic, strong) OrderVarModel *order_vars;

@end

NS_ASSUME_NONNULL_END
