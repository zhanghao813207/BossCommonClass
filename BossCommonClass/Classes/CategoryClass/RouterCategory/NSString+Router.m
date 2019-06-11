//
//  NSString+Router.m
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/6/3.
//

#import "NSString+Router.h"
#import "MGJRouter.h"
#import "BossConstDataDefine.h"

@implementation NSString (Router)


- (NSString *)generateURL{
    return [NSString stringWithFormat:@"%@://%@", SCHEME, self];
}
- (void)openURL{
    [MGJRouter openURL: [NSString stringWithFormat:@"%@://%@", SCHEME, self]];
}
-(void)openURLwithUserInfo:(NSDictionary *)userInfo completion:(void (^)(id result))completion{
    [MGJRouter openURL:[NSString stringWithFormat:@"%@://%@", SCHEME, self] withUserInfo:userInfo completion:completion];
}
- (void)openURLwithcompletion:(void (^)(id _Nonnull))completion{
    [MGJRouter openURL:[NSString stringWithFormat:@"%@://%@", SCHEME, self] completion:completion];
}
@end
