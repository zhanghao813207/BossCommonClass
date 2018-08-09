//
//  ExamineFlowModel.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/8.
//

#import "ExamineFlowModel.h"

@implementation ExamineFlowModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"examine"]) {
        ExamineNodeMdoel *model = [[ExamineNodeMdoel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.examine = model;
        return;
    }
    
    if ([key isEqualToString:@"examineflow_detail_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            ExamineNodeMdoel *model = [[ExamineNodeMdoel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.examineflow_detail_list = [array copy];
        return;
    }
    
    if ([key isEqualToString:@"data"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            ApplyOrderModel *model = [[ApplyOrderModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.data = [array copy];
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
