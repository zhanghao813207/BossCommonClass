//
//  ExamineFlowNodeModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/24.
//

#import "ExamineFlowNodeModel.h"

@implementation ExamineFlowNodeModel

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


@end
