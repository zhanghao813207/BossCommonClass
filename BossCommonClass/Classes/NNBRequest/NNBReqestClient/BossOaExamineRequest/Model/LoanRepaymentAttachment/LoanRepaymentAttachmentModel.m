//
//  LoanRepaymentAttachmentModel.m
//  AFNetworking
//
//  Created by 张浩 on 2019/6/18.
//

#import "LoanRepaymentAttachmentModel.h"

@implementation LoanRepaymentAttachmentModel

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
