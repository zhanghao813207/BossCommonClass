//
//  ManageTemplateModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import "TemplateDataBasicModel.h"
#import "ManageMatchFilter.h"
#import "ManageComputeLogic.h"

NS_ASSUME_NONNULL_BEGIN

@interface ManageTemplateModel : TemplateDataBasicModel

@property (nonatomic, strong) ManageMatchFilter *match_filters;

@property (nonatomic, strong) ManageComputeLogic *compute_logic;

@end

NS_ASSUME_NONNULL_END
