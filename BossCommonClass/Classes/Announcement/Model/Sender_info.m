
//
//  Sender_info.m
//  AFNetworking
//
//  Created by admin on 2019/4/24.
//

#import "Sender_info.h"

@implementation Sender_info
- (BOOL)isMe {
    NSString *ids = [[NSUserDefaults standardUserDefaults] objectForKey:@"account_id"];
    NSLog(@"%@",ids);
    if ([ids isEqualToString:self._id]) {
        return true;
    }
    return false;
}
@end
