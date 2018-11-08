//
//  ManageComputeLogic.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/7.
//

#import <Foundation/Foundation.h>
#import "OrderVarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ManageComputeLogic : NSObject

/**
 'dec_logic_by_range', # 阶梯分段| 阶梯变动
 */
@property (nonatomic, strong) NSString *biz_logic;

/**
 [1], # 物资|保险 管理类型1：物资扣款，2：保险扣款
 */
@property (nonatomic, strong) NSArray *biz_cate;

/**
  明细项
 */
@property (nonatomic, assign) NSInteger biz_cate_item;


@end

NS_ASSUME_NONNULL_END
