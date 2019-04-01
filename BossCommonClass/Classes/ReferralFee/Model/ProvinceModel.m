
//
//  ProvinceModel.m
//  AFNetworking
//
//  Created by admin on 2019/3/29.
//

#import "ProvinceModel.h"
#import "MJExtension.h"
@implementation ProvinceModel
- (instancetype)init
{
    self = [super init];
    if (self) {
//        [ProvinceModel mj_setupObjectClassInArray:^NSDictionary *{
//            return @{
//                     @"children":@"QH_CityModel"
//                     };
//        }];
    }
    return self;
}
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"children" : @"QH_CityModel"};//前边，是属性数组的名字，后边就是类名
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"children" : [QH_CityModel class]
             };
}
@end
