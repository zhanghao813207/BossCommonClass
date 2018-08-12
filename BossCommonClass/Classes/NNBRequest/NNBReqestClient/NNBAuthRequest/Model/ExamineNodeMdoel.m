//
//  ExamineNodeMdoel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/8/8.
//

#import "ExamineNodeMdoel.h"
#import "NSDate+Helper.h"
@implementation ExamineNodeMdoel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    if ([key isEqualToString:@"is_apply"]) {
        self.is_apply = [value boolValue];
        if (self.is_apply) {
            self.state = OA_EXAMINEFLOW_SUBMIT;
        }
        return;
    }
    
    if ([key isEqualToString:@"state"]) {
        if (self.is_apply) {
            self.state = OA_EXAMINEFLOW_SUBMIT;
        } else {
            self.state = [value integerValue];
        }
        return;
    }
    
    if ([key isEqualToString:@"created_at"]) {
        NSString *string = [NSString stringWithFormat:@"%@",value];
        NSDate *date = [NSDate dateFromString:string withFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *valueString = [NSDate stringFromDate:date withFormat:@"HH:mm\nMM/dd"];
        self.created_at = valueString;
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
