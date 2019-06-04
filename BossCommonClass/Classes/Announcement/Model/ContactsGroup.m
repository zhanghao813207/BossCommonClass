
//
//  ContactsGroup.m
//  AFNetworking
//
//  Created by admin on 2019/4/22.
//

#import "ContactsGroup.h"
#import "MJExtension.h"

@implementation ContactsGroup
- (instancetype)init
{
    self = [super init];
    if (self) {
        [ContactsGroup mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"children":@"ContactsChild"};
        }];
    }
    return self;
}
@end
