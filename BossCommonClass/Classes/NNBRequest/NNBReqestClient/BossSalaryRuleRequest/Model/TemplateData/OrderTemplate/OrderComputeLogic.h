//
//  OrderComputeLogic.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import <Foundation/Foundation.h>
#import "OrderParamsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderComputeLogic : NSObject

/**
 order_logic_range # 阶梯分段|阶梯变动
 */
@property (nonatomic, strong) NSString *biz_logic;

@property (nonatomic, strong) OrderParamsModel *params;

@end

NS_ASSUME_NONNULL_END
