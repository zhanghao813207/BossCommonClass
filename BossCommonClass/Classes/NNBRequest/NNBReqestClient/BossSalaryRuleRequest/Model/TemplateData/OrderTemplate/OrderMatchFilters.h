//
//  OrderMatchFilters.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderMatchFilters : NSObject

/**
 订单类型 100:全部, 其他枚举值调接口
 */
@property (nonatomic, strong) NSArray *order_type;

/**
 骑士分类 100:全部, 1:新骑士, 2:老骑士
 */
@property (nonatomic, strong) NSArray *knight_type;

/**
 骑士标签（分组）100:全部, 其他枚举值调接口
 */
@property (nonatomic, strong) NSArray *knight_tags;

/**
 当月在离职 100:全部, 1:当月在职, 2:当月离职
 */
@property (nonatomic, strong) NSArray *state;

/**
 站点星级 100: 全部, 1:一星（级），2:二星（级），3:三星（级），4:四星（级），5:星（级）  美团叫星，饿了吗叫级
 */
@property (nonatomic, strong) NSArray *station_level;

@end

NS_ASSUME_NONNULL_END
