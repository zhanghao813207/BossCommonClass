//
//  ExamineFlowRecordModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/24.
//

#import "ExamineFlowRecordModel.h"
#import "NSDate+Helper.h"
#import "ExamineFlowNodeModel.h"

@implementation ExamineFlowRecordModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"operate_account_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            AccountModel *model = [[AccountModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.operate_account_list = [array copy];
        return;
    }
    
    if ([key isEqualToString:@"reject_to_node_info"]) {
        ExamineFlowNodeModel *model = [[ExamineFlowNodeModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.reject_to_node_info = model;
        return;
    }
    
    if ([key isEqualToString:@"operated_at"]) {
//        yyyy-MM-dd HH:mm:ss
        NSString *normalTimeString = [JYCSimpleToolClass fastChangeToNormalTimeWithString:value];
        NSDate *date = [NSDate dateFromString:normalTimeString];
        NSString *timeString = [NSDate stringFromDate:date withFormat:@"HH:mm MM-dd"];
        self.operated_at = timeString;
        DLog(@"operated_at = %@",self.operated_at);
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
