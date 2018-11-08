//
//  OrderTemplateModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import "TemplateDataBasicModel.h"
#import "OrderMatchFilters.h"
#import "OrderComputeLogic.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderTemplateModel : TemplateDataBasicModel

@property (nonatomic, strong) OrderMatchFilters *match_filters;

@property (nonatomic, strong) OrderComputeLogic *compute_logic;


@end

NS_ASSUME_NONNULL_END
