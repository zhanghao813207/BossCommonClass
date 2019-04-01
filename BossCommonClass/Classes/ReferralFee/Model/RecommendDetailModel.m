
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
    }
    return @"无";
}
@end
