//
//  ExamineOrderModel.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/8.
//

#import "ExamineOrderModel.h"

@implementation ExamineOrderModel


- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"flow_info"]) {
        ExamineFlowTemplateModel *model = [[ExamineFlowTemplateModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.flow_info = model;
        return;
    }
    
    if ([key isEqualToString:@"apply_account_info"]) {
        AccountModel *model = [[AccountModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.apply_account_info = model;
        return;
    }

    if ([key isEqualToString:@"current_operate_account_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            AccountModel *model = [[AccountModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.current_operate_account_list = [array copy];
        return;
    }
    
    if ([key isEqualToString:@"current_record_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            ExamineFlowRecordModel *model = [[ExamineFlowRecordModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.current_record_list = [array copy];

        self.current_node = [self nodeByRecordList:self.current_record_list];
        return;
    }

    if ([key isEqualToString:@"flow_record_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            ExamineFlowRecordModel *model = [[ExamineFlowRecordModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.flow_record_list = [array copy];
        
        NSMutableArray *nodeArray = [NSMutableArray array];
        [self.flow_record_list enumerateObjectsUsingBlock:^(ExamineFlowRecordModel * _Nonnull recordModel, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == 0) {
                NSMutableArray *array = [NSMutableArray array];
                [array addObject:recordModel];
                [nodeArray addObject:array];
            } else {
                ExamineFlowRecordModel *lastRecordModel = self.flow_record_list[idx - 1];
                if (lastRecordModel.node_id == recordModel.node_id) {
                    [nodeArray.lastObject addObject:recordModel];
                } else {
                    NSMutableArray *array = [NSMutableArray array];
                    [array addObject:recordModel];
                    [nodeArray addObject:array];
                }
            }
        }];
        
        NSMutableArray *nodeModleArray = [NSMutableArray array];
        for (NSMutableArray *recordArray in nodeArray) {
            ExamineFlowNodeModel *nodeModel = [self nodeByRecordList:recordArray];
            [nodeModleArray addObject:nodeModel];
        }
        self.flow_node_list = [nodeModleArray copy];
        return;
    }

    if ([key isEqualToString:@"cost_order_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            CostOrderModel *model = [[CostOrderModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.cost_order_list = [array copy];
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (ExamineFlowNodeModel *)nodeByRecordList:(NSArray <ExamineFlowRecordModel *>*)recordList
{
    ExamineFlowNodeModel *model = [[ExamineFlowNodeModel alloc] init];
    for (ExamineFlowRecordModel *recordModel in recordList) {
        model._id = recordModel.node_id;
        model.index_num = recordModel.index_num;
        model.state = recordModel.state;
        BOOL isUrge = NO;
        if (recordModel.state == OA_EXAMINE_NODE_STATE_INIT && recordModel.urge_state == YES) {
            isUrge = YES;
            model.urge_state = YES;
            break;
        }
        model.urge_state = NO;
    }
    model.record_list = recordList;
    return model;
}


@end
