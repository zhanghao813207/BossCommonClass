//
//  ApplicationUrgeRecordModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/9/2.
//

#import "ApplicationUrgeRecordModel.h"
#import "NSDate+Helper.h"
@implementation ApplicationUrgeRecordModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"creator_info"]) {
        AccountModel *model = [[AccountModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.creator_info = model;
        return;
    }
    
    if ([key isEqualToString:@"created_at"]) {
        NSString *normalTime = [JYCSimpleToolClass fastChangeToNormalTimeWithString:value];
        NSDate *normalDate = [NSDate dateFromString:normalTime];
        self.created_at = [NSDate stringFromDate:normalDate withFormat:@"yyyy年M月d日"];
        return;
    }
    
    if ([key isEqualToString:@"application_order_info"]) {
        ExamineOrderModel *model = [[ExamineOrderModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.application_order_info = model;
        return;
    }

    if ([key isEqualToString:@"flow_record_info"]) {
        ExamineFlowRecordModel *model = [[ExamineFlowRecordModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.flow_record_info = model;
        return;
    }

    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
