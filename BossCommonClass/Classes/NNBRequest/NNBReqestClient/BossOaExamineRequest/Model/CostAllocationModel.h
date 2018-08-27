//
//  CostAllocationModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/24.
//

#import <Foundation/Foundation.h>

@interface CostAllocationModel : NSObject

/**
 城市名称列表
 */
@property (nonatomic, strong) NSArray *city_names;

/**
 供应商名称列表
 */
@property (nonatomic, strong) NSArray *supplier_names;

/**
 平台名称列表
 */
@property (nonatomic, strong) NSArray *platform_names;

/**
 商圈名称列表
 */
@property (nonatomic, strong) NSArray *biz_district_names;

/**
 分摊金额(分)
 */
@property (nonatomic, assign) NSInteger money;

@end
