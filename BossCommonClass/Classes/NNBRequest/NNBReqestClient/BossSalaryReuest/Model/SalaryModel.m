//
//  SalaryModel.m
//  BossCommonClass
//
//  Created by 贾远潮 on 2018/8/12.
//

#import "SalaryModel.h"

@implementation SalaryModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"specification_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            Specification *model = [[Specification alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.specification_list = [array copy];
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)posSting
{
    switch (self.position_id) {
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

- (NSString *)workStateString
{
    switch (self.work_state) {
        case StaffStateOnTheJob:
            return @"在职";
            break;
        case StaffStateLeaveToReview:
            return @"离职待审核";
            break;
        case StaffStateLeave:
            return @"离职";
            break;
        default:
            return @"未知";
            break;
    }
}

- (NSString *)recruitment_channel_name
{
    switch (self.recruitment_channel_id) {
        case 1:
            return @"";
            break;
            
        default:
            return @"";
            break;
    }
}

@end
