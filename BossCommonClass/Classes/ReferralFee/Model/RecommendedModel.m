//
//  RecommendedModel.m
//  AFNetworking
//
//  Created by admin on 2019/3/26.
//

#import "RecommendedModel.h"

@implementation RecommendedModel
- (NSString *)positionStr {
    if (self.position_id == 1010) {
        return @"骑士";
    }
    return @"";
}


@end
