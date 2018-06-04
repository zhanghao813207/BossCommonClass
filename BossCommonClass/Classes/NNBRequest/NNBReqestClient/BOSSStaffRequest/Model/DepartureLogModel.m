//
//  DepartureLogModel.m
//  Pods-BossKnight
//
//  Created by 贾远潮 on 2018/5/23.
//

#import "DepartureLogModel.h"

@implementation DepartureLogModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"operator"]) {
        self.operatorName = [NSString stringWithFormat:@"%@",value];
        return;
    }

    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    if ([key isEqualToString:@"operator"]) {
        self.operatorName = [NSString stringWithFormat:@"%@",value];
        return;
    }
}

- (NSDictionary *)decodeToDic
{
    NSDictionary *localDic = @{
                               @"state":@(self.state),
                               @"timestamp":@(self.timestamp),

                               @"time":self.time ? : @"",
                               @"operatorName":self.operatorName ? : @"",
                               @"action_note":self.action_note ? : @"",
                               };
    return localDic;
}


@end
