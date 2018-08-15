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
    
    if ([key isEqualToString:@"created_at"]) {
        self.created_at = [JYCSimpleToolClass quickChangeTimeWithTimeString:value];
        return;
    }
    
    if ([key isEqualToString:@"examine"]) {
        if (![value isKindOfClass:[NSDictionary class]]) {
            return;
        }
        ExamineNodeMdoel *model = [[ExamineNodeMdoel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.examine = model;
        return;
    }
    if ([key isEqualToString:@"examine_list"]) {
        if (![value isKindOfClass:[NSArray class]]) {
            return;
        }
        NSMutableArray *array = [NSMutableArray array];
        NSMutableArray *auditArray = [NSMutableArray array];
        NSMutableArray *nameArray = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            ExamineNodeMdoel *model = [[ExamineNodeMdoel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            if (model.state == OA_EXAMEINEFLOW_INIT) {
                [auditArray addObject:model];
                [nameArray addObject:model.name];
            } else {
                [array addObject:model];
            }
        }
        if (auditArray.count > 1) {
            ExamineNodeMdoel *model = auditArray.firstObject;
            model.name = [nameArray componentsJoinedByString:@"、"];
            [array insertObject:model atIndex:0];
        } else if (auditArray.count == 1){
            [array insertObject:auditArray.firstObject atIndex:0];
        }
        self.examine_list = [array copy];
        return;
    }
    
    if ([key isEqualToString:@"examineflow_detail_list"]) {
        self.examineflow_detail_list = [self unitSameStateWithState:OA_EXAMEINEFLOW_INIT jsonList:value];
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

- (NSArray *)unitSameStateWithState:(OA_EXAMINE_NODE_STATE)state jsonList:(NSArray *)value
{
    if (![value isKindOfClass:[NSArray class]]) {
        return nil;
    }
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *auditArray = [NSMutableArray array];
    NSMutableArray *nameArray = [NSMutableArray array];
    for (NSInteger i = [value count] - 1; i >= 0; i--) {
        NSArray *nodeArray = (NSArray *)value[i];
        for (NSInteger j = nodeArray.count - 1; j >= 0; j--) {
            NSDictionary *dic = nodeArray[j];
            ExamineNodeMdoel *model = [[ExamineNodeMdoel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            if (model.state == state) {
                [auditArray addObject:model];
                [nameArray addObject:model.name];
            } else {
                [array addObject:model];
            }
        }
    }
    
    if (auditArray.count > 1) {
        ExamineNodeMdoel *model = auditArray.firstObject;
        model.name = [nameArray componentsJoinedByString:@"、"];
        [array insertObject:model atIndex:0];
    } else if (auditArray.count == 1){
        [array insertObject:auditArray.firstObject atIndex:0];
    }
    return [array copy];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)gidString
{
    switch (self.gid) {
        case PositionIDAdministrator:
            return @"超级管理员";
            break;
        case PositionIDCOO:
            return @"COO";
            break;
        case PositionIDOperationManager:
            return @"运营管理";
            break;
        case PositionIDDirector:
            return @"总监";
            break;
        case PositionIDCityManger:
            return @"城市经理";
            break;
        case PositionIDCityAssistant:
            return @"城市助理";
            break;
        case PositionIDDispatcher:
            return @"调度";
            break;
        case PositionIDStationAgent:
            return @"站长";
            break;
        case PositionIDBuyer:
            return @"采购员";
            break;
        case PositionIDKnightCommander:
            return @"骑士长";
            break;
        case PositionIDKnight:
            return @"骑士";
            break;
        case PositionIDProjectDirector:
            return @"项目总监";
            break;
        case PositionIDPersonnel:
            return @"人事或人事总监";
            break;
        case PositionIDA1013:
            return @"张仕洋";
            break;
        case PositionIDA1014:
            return @"巴朕巴总";
            break;
        case PositionIDA1015:
            return @"总裁特别助理";
            break;
        case PositionIDA1016:
            return @"财务负责人";
            break;
        case PositionIDA1017:
            return @"财务经理";
            break;
        case PositionIDA1018:
            return @"出纳";
            break;
        case PositionIDA1019:
            return @"人事专员";
            break;
        case PositionIDCEO:
            return @"CEO";
            break;
        case PositionIDA1021:
            return @"行政经理";
        case PositionIDA1022:
            return @"行政专员";
        case PositionIDA1023:
            return @"行政主管";
        case PositionIDA1024:
            return @"主体总监";
        default:
            return @"未知";
            break;
    }
}


@end
