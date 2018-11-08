//
//  BattleParamModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/7.
//

#import "BattleParamModel.h"

@implementation BattleParamModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
        
    if ([key isEqualToString:@"ladder"]) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            LadderModel *model = [[LadderModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.ladder = [array copy];
        return;
    }
    
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
