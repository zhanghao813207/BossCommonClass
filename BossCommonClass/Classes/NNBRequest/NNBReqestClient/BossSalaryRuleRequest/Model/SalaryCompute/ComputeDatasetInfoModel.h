//
//  ComputeDatasetInfoModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComputeDatasetInfoModel : NSObject

@property (nonatomic, assign) NSInteger finish_order_quantity;

@property (nonatomic, assign) NSInteger trials_total_money;

@property (nonatomic, assign) NSInteger total_amount;

@property (nonatomic, assign) NSInteger total_subsidy;

@property (nonatomic, assign) NSInteger total_manage;


#pragma mark -- 薪资方案
/**
 完成单量
 */
@property (nonatomic, assign) NSInteger done_order;

/**
 管理总金额
 */
@property (nonatomic, assign) NSInteger management_amount;

/**
 单量总额
 */
@property (nonatomic, assign) NSInteger total_order;

/**
 试算总金额
 */
@property (nonatomic, assign) NSInteger trial_calculation_amount;

/**
 补贴总金额
 */
@property (nonatomic, assign) NSInteger subsidy_amount;


@end

NS_ASSUME_NONNULL_END
