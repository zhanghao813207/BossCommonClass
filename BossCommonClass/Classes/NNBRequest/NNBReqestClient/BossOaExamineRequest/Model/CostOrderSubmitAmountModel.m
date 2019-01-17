//
//  CostOrderSubmitAmountModel.m
//  AFNetworking
//
//  Created by 张浩 on 2019/1/14.
//

#import "CostOrderSubmitAmountModel.h"
#import "BossBasicDefine.h"

@implementation CostOrderSubmitAmountModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    DLog(@"undefineKey %@ %@", key, value);
}

@end
