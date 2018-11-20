//
//  ManageParamModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/7.
//

#import <Foundation/Foundation.h>
#import "OrderRangeTableModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ManageParamModel : NSObject

/**
 累加最大值
 */
@property (nonatomic, assign) NSInteger total_max_num;

/**
 阶梯类型      1: 阶梯分段 2:阶梯变动
 */
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) NSArray <OrderRangeTableModel *>*range_table;

#pragma mark -- 保险扣款

/**
 attendance_days : 出勤天数
 */
@property (nonatomic, strong) NSString *unit_day;

/**
 金额
 */
@property (nonatomic, assign) NSInteger unit_money;

@property (nonatomic, strong) NSString *logicString;


@end

NS_ASSUME_NONNULL_END
