//
//  OaHouseContractModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/24.
//

#import "OaHouseContractModel.h"

@implementation OaHouseContractModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
//    if ([key isEqualToString:@"sku_lines"]) {
//        PosInfoModel *model = [[PosInfoModel alloc] init];
//        [model setValuesForKeysWithDictionary:value];
//        self.sku_lines = model;
//        return;
//    }
//
//    if ([key isEqualToString:@"sku_lines"]) {
//        NSMutableArray *array = [NSMutableArray array];
//        for (NSDictionary *dic in value) {
//            PosInfoModel *model = [[PosInfoModel alloc] init];
//            [model setValuesForKeysWithDictionary:dic];
//            [array addObject:model];
//        }
//        self.sku_lines = [array copy];
//        return;
//    }
    
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
