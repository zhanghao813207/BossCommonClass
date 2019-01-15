//
//  CostOrderSubmitAmountModel.h
//  AFNetworking
//
//  Created by 张浩 on 2019/1/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 提报费用金额统计model
 */
@interface CostOrderSubmitAmountModel : NSObject

@property (nonatomic, strong) NSString *_id;

@property (nonatomic, strong) NSString *accounting_id;

@property (nonatomic, strong) NSString *platform_code;

@property (nonatomic, strong) NSString *supplier_id;

@property (nonatomic, strong) NSString *city_code;

@property (nonatomic, strong) NSString *biz_district_id;

@property (nonatomic, strong) NSString *submit_at;

@property (nonatomic, assign) NSInteger amount_money;

@property (nonatomic, strong) NSString *submitAmountStr;

@end

NS_ASSUME_NONNULL_END
