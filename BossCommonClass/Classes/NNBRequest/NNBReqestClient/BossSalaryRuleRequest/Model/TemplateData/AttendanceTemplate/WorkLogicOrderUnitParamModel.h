//
//  WorkLogicOrderUnitParamModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorkLogicOrderUnitParamModel : NSObject

/**
 订单类型: 准时完成单
 */
@property (nonatomic, strong) NSString *order_unit_type;

/**
 准时完成单满足？单
 */
@property (nonatomic, assign) NSInteger min_order_amount;

/**
 每 X 单
 */
@property (nonatomic, assign) NSInteger inc_unit_order;

/**
 补 Y 元
 */
@property (nonatomic, assign) NSInteger inc_unit_money;

@end

NS_ASSUME_NONNULL_END
