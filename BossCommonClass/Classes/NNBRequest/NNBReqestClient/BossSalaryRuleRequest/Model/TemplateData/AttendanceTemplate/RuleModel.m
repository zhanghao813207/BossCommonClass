//
//  RuleModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import "RuleModel.h"

@implementation RuleModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)indexString
{
    return @"好评单";
}

- (NSString *)numberString
{
    if (!_numberString) {
        _numberString = [NSString stringWithFormat:@"%@    %@",self.symbol,self.num];
    }
    return _numberString;
}

@end
