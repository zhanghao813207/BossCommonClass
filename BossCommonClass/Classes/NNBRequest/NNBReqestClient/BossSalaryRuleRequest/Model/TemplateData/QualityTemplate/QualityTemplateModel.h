//
//  QualityTemplateModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import "TemplateDataBasicModel.h"
#import "QuaComputeLogic.h"
#import "QualityMatchFilter.h"

NS_ASSUME_NONNULL_BEGIN

@interface QualityTemplateModel : TemplateDataBasicModel

@property (nonatomic, strong) QualityMatchFilter *match_filters;

@property (nonatomic, strong) QuaComputeLogic *compute_logic;

@end

NS_ASSUME_NONNULL_END
