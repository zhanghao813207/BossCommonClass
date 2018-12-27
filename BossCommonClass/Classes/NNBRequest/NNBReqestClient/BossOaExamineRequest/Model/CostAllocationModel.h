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
@property (nonatomic, strong) NSString *city_name;

@property (nonatomic, strong) NSString *city_code;


/**
 供应商名称列表
 */
@property (nonatomic, strong) NSString *supplier_name;

@property (nonatomic, strong) NSString *supplier_id;


/**
 平台名称列表
 */
@property (nonatomic, strong) NSString *platform_name;

@property (nonatomic, strong) NSString *platform_code;


/**
 商圈名称列表
 */
@property (nonatomic, strong) NSString *biz_district_name;

@property (nonatomic, strong) NSString *biz_district_id;


/**
 分摊金额(分)
 */
@property (nonatomic, assign) NSInteger money;

/**
 分摊明细字符串
 */
@property (nonatomic, strong) NSString *allocationString;

@end
