//
//  ManageMatchFilter.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/7.
//

#import <Foundation/Foundation.h>
#import "OrderVarModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ManageMatchFilter : NSObject

/**
 [1], # 物资|保险 管理类型1：物资扣款，2：保险扣款
 */
@property (nonatomic, assign) NSInteger biz_cate;

/**
 明细项
 */
@property (nonatomic, assign) NSInteger biz_cate_item;


#pragma mark -- 物资扣款
/**
 订单指标
 */
@property (nonatomic, strong) OrderVarModel *order_vars;

#pragma mark -- 保险扣款
/**
 出勤天数
 */
@property (nonatomic, assign) NSInteger attendance_days;

/**
 在职天数
 */
@property (nonatomic, assign) NSInteger work_days;

/**
 骑士标签
 */
@property (nonatomic, strong) NSArray *knight_tags;

@end

NS_ASSUME_NONNULL_END
