//
//  ExamineFlowTemplateModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/24.
//

#import "ExamineFlowTemplateModel.h"

@implementation ExamineFlowTemplateModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
        
    if ([key isEqualToString:@"node_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            ExamineFlowNodeModel *model = [[ExamineFlowNodeModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.node_list = [array copy];
        return;
    }
    
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    DLog(@"undefineKey %@ %@", key, value);
}


@end
