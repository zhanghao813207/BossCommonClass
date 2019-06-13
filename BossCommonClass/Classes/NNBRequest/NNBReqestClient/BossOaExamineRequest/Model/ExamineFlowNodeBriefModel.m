//
//  ExamineFlowNodeBriefModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/31.
//

#import "ExamineFlowNodeBriefModel.h"

@implementation ExamineFlowNodeBriefModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
        
    if ([key isEqualToString:@"account_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            AccountModel *model = [[AccountModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.account_list = [array copy];
        return;
    }
    
    if ([key isEqualToString:@"post_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            PostModel *model = [[PostModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.post_list = [array copy];
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
