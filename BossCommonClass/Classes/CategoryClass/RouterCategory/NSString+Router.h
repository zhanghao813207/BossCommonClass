//
//  NSString+Router.h
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/6/3.
//

#import <Foundation/Foundation.h>
#import "MGJRouter.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Router)
// 打开Url
// 无参数路由跳转
- (void)openURL;

// 无参数路由跳转
-(void)openURLwithcompletion:(void (^)(id result))completion;

// 有参数路由跳转 且有回调
-(void)openURLwithUserInfo:(NSDictionary *)userInfo completion:(void (^)(id result))completion;

//生成URL
-(NSString *)generateURL;
@end

NS_ASSUME_NONNULL_END
