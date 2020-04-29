//
//  ExamineOrderModel.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/8.
//

#import "ExamineOrderModel.h"
#import "NSDate+Helper.h"
#import "BossManagerAccount.h"
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
        
        self.submit_at_int = [date stringWithFormat:@"yyyyMM"];
        
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
        ExamineFlowNodeBriefModel *model = [[ExamineFlowNodeBriefModel alloc] init];
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
    
    if ([key isEqualToString:@"loan_order_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            LoanOrderModel *model = [[LoanOrderModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.loan_order_list = [array copy];
        return;
    }
    
    if ([key isEqualToString:@"repayment_order_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            RepaymentOrderModel *model = [[RepaymentOrderModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.repayment_order_list = [array copy];
        return;
    }
    
    if ([key isEqualToString:@"loan_or_repayment_file_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            LoanRepaymentAttachmentModel *model = [[LoanRepaymentAttachmentModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.loan_or_repayment_file_list = [array copy];
        return;
    }
    
    if ([key isEqualToString:@"business_travel_order_info"]) {
        BusinessTravelOrderModel *model = [[BusinessTravelOrderModel alloc] init];
        self.business_travel_order_info = [model initWithDictionary:value];
        return;
    }
    
    
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

#pragma mark - setter/getter

- (NSString *)totalMoneyStr {
    if(self.application_order_type == ApplicationOrderTypeBusinessTrave){
        return @"";
    }
    return [NSString stringWithFormat:@"￥%.2f",self.total_money / 100.0];
}

- (NSString *)applicationOrderTypeStr {
    NSString *typeStr = @"未知";
    switch (self.application_order_type) {
        case ApplicationOrderTypeCost:
            typeStr = @"费用申请";
            break;
        case ApplicationOrderTypeSalaryRule:
            typeStr = @"服务费规则";
            break;
        case ApplicationOrderTypeSalaryPayment:
            typeStr = @"服务费发放";
            break;
        case ApplicationOrderTypeMaterial:
            typeStr = @"物资采购";
            break;
        case ApplicationOrderTypeHouseContract:
            typeStr = @"房屋管理";
            break;
        case ApplicationOrderTypeLoan:
            typeStr = @"借款申请";
            break;
        case ApplicationOrderTypeRepayment:
            typeStr = @"还款";
            break;
        case ApplicationOrderTypeBusinessTrave:
            typeStr = @"出差申请";
            break;
        case ApplicationOrderTypeTravelExpense:
            typeStr = @"差旅报销";
            break;
        case ApplicationOrderTypeOverTime:
            typeStr = @"加班申请";
            break;
        case ApplicationOrderTypeLeaveOrder:
            typeStr = @"请假申请";
            break;
        case ApplicationOrderTypePersonnelChanges:
            typeStr = @"人员异动";
            break;
        case ApplicationOrderTypeCustomPlugInApproval:
            typeStr = @"外部审批管理";
            break;
        default:
            break;
    }
    
    return typeStr;
}

- (NSString *)applicationOrderStateStr {
    NSString *stateStr= @"待提交";
    switch (self.state) {
        case OA_EXAMINE_STATE_UNDERWAY:
            stateStr = @"进行中";
            break;
        case OA_EXAMINE_STATE_DONE:
            stateStr = @"已完成";
            break;
        case OA_EXAMINE_STATE_SHUTDOWN:
            stateStr = @"已关闭";
            break;
        default:
            break;
    }
    
    return stateStr;
}

- (NSString *)themeLabelStr {
    if(self.theme_label_list && self.theme_label_list.count > 0){
        return [self.theme_label_list componentsJoinedByString:@"、"];
    }
    return @"";
}

- (NSInteger)orderCount {
    NSInteger orderCount = 0;
    switch (self.application_order_type) {
        case ApplicationOrderTypeCost:
        case ApplicationOrderTypeHouseContract:
        case ApplicationOrderTypeMaterial:
        case ApplicationOrderTypeTravelExpense:
        case ApplicationOrderTypeOverTime:
            orderCount = self.cost_order_list.count;
            break;
        case ApplicationOrderTypeSalaryRule:
            orderCount = 1;
            break;
        case ApplicationOrderTypeSalaryPayment:
            orderCount = 1;
            break;
        case ApplicationOrderTypeLoan:
            orderCount = self.loan_order_list.count;
            break;
        case ApplicationOrderTypeRepayment:
            orderCount = self.repayment_order_list.count;
            break;
        case ApplicationOrderTypeBusinessTrave:
            orderCount = 1;
            break;
        default:
            break;
    }
    return orderCount;
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
        if(self.current_flow_node_info){
            _current_node = [self createExamineFlowNodeModel:self.current_flow_node_info];
            _current_node.record_list = self.current_record_list;
            
            ExamineFlowRecordModel *recordModel = self.current_record_list[0];
            
            _current_node.index_num = recordModel.index_num;
            _current_node.state = recordModel.state;
            
            switch (recordModel.state) {
                case OA_EXAMINE_NODE_STATE_INIT:
                {
                    if (_current_node.is_payment_node && self.paid_state == PAY_STATE_ERROR) {
                        recordModel.state = OA_EXAMINE_NODE_STATE_PAY;
                        recordModel.pay_state = PAY_STATE_ERROR;
                        recordModel.note = self.paid_note;
                    }
                }
                    break;
                case OA_EXAMINE_NODE_STATE_AGREE:
                {
                    if (_current_node.is_payment_node) {
                        recordModel.state = OA_EXAMINE_NODE_STATE_PAY;
                        recordModel.pay_state = PAY_STATE_DONE;
                    }
                }
                default:
                    break;
            }
            
            _current_node.urge_state = recordModel.state == OA_EXAMINE_NODE_STATE_INIT && recordModel.urge_state == YES;
        }else{
            if(self.current_record_list){
                _current_node = [self nodeByRecordList:self.current_record_list];
            }
        }
    }
    return _current_node;
}

- (NSDictionary *)file_url_dic
{
    if (!_file_url_dic) {
        NSMutableDictionary *dic = @{}.mutableCopy;
        for (NSDictionary *fileDic in self.file_url_list) {
            if (fileDic[@"file_url"]) {
                [dic setObject:fileDic[@"file_url"] forKey:fileDic[@"file_name"]];
            }
        }
        _file_url_dic = dic.copy;
    }
    return _file_url_dic;
    
}

- (ExamineFlowNodeModel *)createExamineFlowNodeModel:(ExamineFlowNodeBriefModel *)flowNodeBriefModel {
    ExamineFlowNodeModel *flowNodeModel = [[ExamineFlowNodeModel alloc] init];
    flowNodeModel._id = flowNodeBriefModel._id;
    flowNodeModel.name = flowNodeBriefModel.name;
    flowNodeModel.account_list = flowNodeBriefModel.account_list;
    flowNodeModel.post_list = flowNodeBriefModel.post_list;
    flowNodeModel.index_num = flowNodeBriefModel.index_num;
    flowNodeModel.is_payment_node = flowNodeModel.is_payment_node;
    flowNodeModel.can_update_cost_record = flowNodeBriefModel.can_update_cost_record;
    return flowNodeModel;
}

- (ExamineFlowNodeModel *)nodeByRecordList:(NSArray <ExamineFlowRecordModel *>*)recordList
{
    ExamineFlowNodeModel *model = nil;
    if(recordList && recordList.count > 0){
        ExamineFlowRecordModel *recordModel = recordList[0];
        if(recordModel.flow_node_info){
            model = [self createExamineFlowNodeModel:recordModel.flow_node_info];
        }else{
            model = [[ExamineFlowNodeModel alloc] init];
            model._id = recordModel.node_id;
            model.index_num = recordModel.index_num;
        }
        
        model.state = recordModel.state;
        
        switch (recordModel.state) {
            case OA_EXAMINE_NODE_STATE_INIT:
            {
                if (model.is_payment_node && self.paid_state == PAY_STATE_ERROR) {
                    recordModel.state = OA_EXAMINE_NODE_STATE_PAY;
                    recordModel.pay_state = PAY_STATE_ERROR;
                    recordModel.note = self.paid_note;
                }
            }
                break;
            case OA_EXAMINE_NODE_STATE_AGREE:
            {
                if (model.is_payment_node) {
                    recordModel.state = OA_EXAMINE_NODE_STATE_PAY;
                    recordModel.pay_state = PAY_STATE_DONE;
                }
            }
            default:
                break;
        }
        
        model.urge_state = recordModel.state == OA_EXAMINE_NODE_STATE_INIT && recordModel.urge_state == YES;
        
        model.record_list = recordList;
    }
    
    return model;
}

#pragma mark -- 非服务器返回字段，统一校验的本地添加字段
/// 是否显示金额
- (BOOL)isHideAmount {
    
    if (self.application_order_type == ApplicationOrderTypeBusinessTrave || self.application_order_type == ApplicationOrderTypeOverTime || self.application_order_type == ApplicationOrderTypeLeaveOrder || self.application_order_type == ApplicationOrderTypeCustomPlugInApproval){
        return true;
    }
    return false;
}

///提报人是否是自己
- (BOOL)isApplyAccount {
    if ([self.apply_account_info.name isEqualToString:kCurrentBossManagerAccount.accountModel.name]) {
        return true;
    }
    return false;
}

@end
