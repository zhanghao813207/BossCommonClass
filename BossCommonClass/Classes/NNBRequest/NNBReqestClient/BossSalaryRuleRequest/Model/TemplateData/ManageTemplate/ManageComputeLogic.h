//
//  ManageComputeLogic.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/7.
//

#import <Foundation/Foundation.h>
#import "OrderVarModel.h"
#import "ManageParamModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ManageComputeLogic : NSObject

/**
 'dec_logic_by_range', # 阶梯分段| 阶梯变动
 */
@property (nonatomic, strong) NSString *biz_logic;


@property (nonatomic, strong) ManageParamModel *params;


@end

NS_ASSUME_NONNULL_END
