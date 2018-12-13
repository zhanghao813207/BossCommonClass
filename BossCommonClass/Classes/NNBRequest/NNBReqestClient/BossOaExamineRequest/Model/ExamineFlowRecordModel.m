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
    
    if ([key isEqualToString:@"extra_info_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            SupplementOpinionModel *model = [[SupplementOpinionModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.extra_info_list = [array copy];
        return;
    }

    
    if ([key isEqualToString:@"reject_to_node_info"]) {
        ExamineFlowNodeBriefModel *model = [[ExamineFlowNodeBriefModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.reject_to_node_info = model;
        return;
    }
    
    if ([key isEqualToString:@"operated_at"]) {
//        yyyy-MM-dd HH:mm:ss
        NSString *normalTimeString = [JYCSimpleToolClass fastChangeToNormalTimeWithString:value];
        self.operated_at = normalTimeString;

        NSDate *date = [NSDate dateFromString:normalTimeString];
        
        NSString *mainString = [JYCSimpleToolClass standardTimeFormatterToWChatTimeFormatterByDate:date nowDate:[NSDate date] showToday:YES showFullYear:NO showChineYear:NO];
        
        NSString *lastString = [JYCSimpleToolClass segementOneDayByDate:date segement:NO];
        
        NSString *timeString = [NSString stringWithFormat:@"%@ %@",lastString,mainString];

        self.wchat_operated_at = timeString;
        return;
    }
    
    if ([key isEqualToString:@"flow_node_info"]) {
        ExamineFlowNodeBriefModel *model = [[ExamineFlowNodeBriefModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.flow_node_info = model;
        return;
    }
    
    if ([key isEqualToString:@"account_info"]) {
        AccountModel *model = [[AccountModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.account_info = model;
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
