//
//  OrderParamsModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import <Foundation/Foundation.h>
#import "OrderRangeTableModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderParamsModel : NSObject

/**
 累加最大值
 */
@property (nonatomic, strong) NSString *total_max_num;

/**
 阶梯类型      1: 阶梯分段 2:阶梯变动
 */
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSArray <OrderRangeTableModel *>*range_table;

@end

NS_ASSUME_NONNULL_END
