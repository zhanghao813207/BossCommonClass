//
//  AttendanceTemplateModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import "TemplateDataBasicModel.h"
#import "AttendanceMatchFilter.h"
#import "AttendanceComputeLogic.h"
NS_ASSUME_NONNULL_BEGIN

@interface AttendanceTemplateModel : TemplateDataBasicModel

@property (nonatomic, strong) AttendanceMatchFilter *match_filters;

@property (nonatomic, strong) AttendanceComputeLogic *compute_logic;

@end

NS_ASSUME_NONNULL_END
