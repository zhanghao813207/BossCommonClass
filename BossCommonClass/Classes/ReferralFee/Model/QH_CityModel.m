
//
//  QH_CityModel.m
//  AFNetworking
//
//  Created by admin on 2019/3/29.
//

#import "QH_CityModel.h"
#import "MJExtension.h"
@implementation QH_CityModel
- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"children" : [QH_ArearModel class]
             };
}
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"children" : @"QH_ArearModel"};//前边，是属性数组的名字，后边就是类名
}
//- (NSDictionary *)objectClassInArray {
//    return @{@"children" : [QH_ArearModel class],
//             };
//
//}
@end
