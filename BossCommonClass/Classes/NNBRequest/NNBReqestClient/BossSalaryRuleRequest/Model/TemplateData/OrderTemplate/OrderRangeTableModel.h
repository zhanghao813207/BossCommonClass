//
//  OrderRangeTableModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderRangeTableModel : NSObject

@property (nonatomic, assign) NSInteger min;

/**
 运算符 小
 */
@property (nonatomic, strong) NSString *symbol_min;

/**
 指标
 */
@property (nonatomic, strong) NSString *index;

/**
 运算符 大
 */
@property (nonatomic, strong) NSString *symbol_max;

@property (nonatomic, strong) NSString *max;

@property (nonatomic, assign) NSInteger money;

@end

NS_ASSUME_NONNULL_END
