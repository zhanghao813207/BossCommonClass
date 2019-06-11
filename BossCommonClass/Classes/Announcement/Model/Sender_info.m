
//
//  Sender_info.m
//  AFNetworking
//
//  Created by admin on 2019/4/24.
//

#import "Sender_info.h"
#import "BossBasicDefine.h"
#import "BossCache.h"
#import "UmsAccessTokenModel.h"

@implementation Sender_info
- (BOOL)isMe {
    NSString *ids = kCache.umsAccessTokenModel ? kCache.umsAccessTokenModel.accountId : @"";
    NSLog(@"%@",ids);
    if ([ids isEqualToString:self._id]) {
        return true;
    }
    return false;
}
@end
