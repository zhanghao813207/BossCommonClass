//
//  RecommendedModel.m
//  AFNetworking
//
//  Created by admin on 2019/3/26.
//

#import "RecommendedModel.h"
#import "JYCMethodDefine.h"

@implementation RecommendedModel
- (NSString *)positionStr {
    if (self.position_id == 1010) {
        return @"骑士";
    }
    return @"";
}

- (NSString *)hintStr {
    if (self.is_complete) {
        return @"信息已完整,可提交";
    }
    return @"信息待完善";
}

- (UIColor *)hintColor {
    if (!self.is_complete) {
        return kHexRGB(0xFF9F00);
    }
    return kHexRGB(0x00BD9A);
}

@end
