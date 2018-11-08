//
//  AttendanceTemplateModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import "AttendanceTemplateModel.h"

@implementation AttendanceTemplateModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"match_filters"]) {
        AttendanceMatchFilter *model = [[AttendanceMatchFilter alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.match_filters = model;
        return;
    }
    
    if ([key isEqualToString:@"compute_logic"]) {
        AttendanceComputeLogic *model = [[AttendanceComputeLogic alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.compute_logic = model;
        return;
    }

        
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
