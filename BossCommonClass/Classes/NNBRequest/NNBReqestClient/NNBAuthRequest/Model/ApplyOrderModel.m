//
//  ApplyOrderModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/9.
//

#import "ApplyOrderModel.h"

@implementation ApplyOrderModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"payee_info"]) {
        PayeeInfoModel *model = [[PayeeInfoModel alloc] init];
        [model setValuesForKeysWithDictionary:value];
        self.payee_info = model;
        return;
    }
    
    if ([key isEqualToString:@"history_id_list"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            ApplyOrderModel *model = [[ApplyOrderModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.history_id_list = [array copy];
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)thingStateString
{
    switch (self.thing_state) {
        case OA_HOUSE_STATE_DEL:
            return @"删除";
            break;
        case OA_HOUSE_STATE_STOP:
            return @"断租";
            break;
        case OA_HOUSE_STATE_EXP:
            return @"退租";
            break;
        case OA_HOUSE_STATE_NEW:
            return @"新租";
            break;
        case OA_HOUSE_STATE_KEEP:
            return @"续租";
            break;
        case OA_HOUSE_STATE_DOUKEEP:
            return @"续签";
            break;
        case OA_HOUSE_STATE_NEW_LOCK:
            return @"已续租";
            break;
        default:
            return @"未知";
            break;
    }
}

- (NSString *)costBelongString
{
    switch (self.cost_belong) {
        case 6:
            return @"平均分摊";
            break;
        case 7:
            return @"单量比例分摊";
            break;
        case 8:
            return @"自定义分摊";
            break;
        default:
            return @"未知";
            break;
    }
}

- (NSString *)costCenterString
{
    switch (self.cost_center) {
        case 1:
           return @"项目";
            break;
        case 2:
            return @"项目主体";
            break;
        case 3:
            return @"城市";
            break;
        case 4:
            return @"商圈";
            break;
        case 5:
            return @"骑士";
            break;
        default:
            return @"未知";
            break;
    }
}


@end
