//
//  NNBResponseModel.m
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/20.
//

#import "NNBResponseModel.h"

@implementation NNBResponseModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"code"]) {
        self.code = value;
    } else {
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (void)setCode:(NSString *)code
{
    _code = code;
    NSInteger codeInteger = [code integerValue];
    switch (codeInteger) {
        case 200:
            
            break;
            
        default:
            break;
    }
}

@end
