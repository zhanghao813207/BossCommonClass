
//
//  RecommendDetailModel.m
//  AFNetworking
//
//  Created by admin on 2019/4/1.
//

#import "RecommendDetailModel.h"

@implementation RecommendDetailModel
- (NSString *)work_experienceStr {
    if (self.work_experience == 50) {
        return @"有";
    }else if (self.work_experience == -50) {
      return @"无";
    }
    return @"未填写";
}
- (NSString *)ageStr {
    if (self.age == 0) {
        return @"未填写";
    }
    return [NSString stringWithFormat:@"%d岁",self.age];
}
/**
 目前工作状态(100 在职 -100 离职)
 */
- (NSString *)working_stateStr {
    if (self.working_state == 100) {
        return @"在职";
    }else if (self.working_state == -100) {
      return @"离职";
    }
    return @"未填写";
}
@end
