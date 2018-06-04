//
//  NNBAuthRequest.h
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/27.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
@interface NNBAuthRequest : NSObject

/**
 登录接口

 @param phoneNumber 手机号
 @param authCode 验证码
 @param successBlock 成功的回调（返回当前登录用户的信息，是单例类 也可以从别的地方获取）
 */
+ (void)authRequestLoginWithPhoneNumber:(NSString *)phoneNumber authCode:(NSString *)authCode success:(void (^)(NNBAccount *accountInfo))successBlock fail:(void(^)(id error))fail;

@end
