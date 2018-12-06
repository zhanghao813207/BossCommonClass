//
//  ExamineOrderModel.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/8.
//

#import "ExamineOrderModel.h"
#import "NSDate+Helper.h"

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
    
    if ([key isEqualToString:@"submit_at"]) {
        NSString *normalTime = [JYCSimpleToolClass fastChangeToNormalTimeWithString:value];
        self.submit_at = normalTime;
        
        NSDate *date = [NSDate dateFromString:normalTime withFormat:@"yyyy-MM-dd HH:mm:ss"];

        NSString *mainTitleString = [JYCSimpleToolClass standardTimeFormatterToWChatTimeFormatterByDate:date nowDate:[NSDate date] showToday:NO showFullYear:YES showChineYear:YES];
        
        NSString *lastString = [JYCSimpleToolClass segementOneDayByDate:date segement:YES];
        
        self.wchat_submit_at = [NSString stringWithFormat:@"%@ %@",mainTitleString, lastString];

        return;
    }
    
    if ([key isEqualToString:@"created_at"]) {
        NSString *normalTime = [JYCSimpleToolClass fastChangeToNormalTimeWithString:value];
        self.created_at = [JYCSimpleToolClass quickChangeTimeWithTimeString:normalTime];
        return;
    }

    if ([key isEqualToString:@"current_flow_node_info"]) {
        ExamineFlowNodeModel *model = [[ExamineFlowNodeModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.current_flow_node_info = model;
        return;
    }
    
    if ([key isEqualToString:@"salary_plan_version_info"]) {
        SalaryPlaneModel *model = [[SalaryPlaneModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.salary_plan_version_info = model;
        return;
    }

    if ([key isEqualToString:@"payroll_statement_info"]) {
        PayrollStatementModel *model = [[PayrollStatementModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.payroll_statement_info = model;
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
        model._id = recordModel.flow_node_info._id;
        model.index_num = recordModel.index_num;
        model.state = recordModel.state;
        model.name = recordModel.flow_node_info.name;
        model.is_payment_node = recordModel.flow_node_info.is_payment_node;
        if (model.is_payment_node) {
            if (recordModel.state == OA_EXAMINE_NODE_STATE_INIT) {
                recordModel.state = OA_EXAMINE_NODE_STATE_PAY;
                if (self.paid_state == PAY_STATE_ERROR) {
                    recordModel.pay_state = PAY_STATE_ERROR;
                    recordModel.note = self.paid_note;
                } else {
                    recordModel.pay_state = PAY_STATE_INIT;
                }
            } else {
                recordModel.state = OA_EXAMINE_NODE_STATE_PAY;
                recordModel.pay_state = PAY_STATE_DONE;
            }
        }
        BOOL isUrge = NO;
        if ((recordModel.state == OA_EXAMINE_NODE_STATE_INIT) && recordModel.urge_state == YES) {
            isUrge = YES;
            model.urge_state = YES;
            break;
        }
        model.urge_state = NO;
    }
    model.record_list = recordList;
    return model;
}

- (NSArray<ExamineFlowNodeModel *> *)flow_node_list
{
    if (!_flow_node_list) {
        if (!self.flow_record_list) {
            return nil;
        }
        NSMutableArray *nodeArray = [NSMutableArray array];
        [self.flow_record_list enumerateObjectsUsingBlock:^(ExamineFlowRecordModel * _Nonnull recordModel, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == 0) {
                NSMutableArray *array = [NSMutableArray array];
                [array addObject:recordModel];
                [nodeArray addObject:array];
            } else {
                ExamineFlowRecordModel *lastRecordModel = self.flow_record_list[idx - 1];
                if ([lastRecordModel.node_id isEqualToString:recordModel.node_id]) {
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
            if (nodeModel) {
                [nodeModleArray addObject:nodeModel];
            }
        }
        _flow_node_list = [nodeModleArray copy];
    }
    return _flow_node_list;
}

- (ExamineFlowNodeModel *)current_node
{
    if (!_current_node) {
        if (!self.current_record_list) {
            return nil;
        }
        _current_node = [self nodeByRecordList:self.current_record_list];
    }
    return _current_node;

}

@end