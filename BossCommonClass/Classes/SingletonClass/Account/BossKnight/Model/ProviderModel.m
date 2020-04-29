//
//  ProviderModel.m
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/27
//

#import "ProviderModel.h"

@implementation ProviderModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = [NSString stringWithFormat:@"%@",value];
    } else {
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(nonnull NSString *)key
{
    
}

@end
