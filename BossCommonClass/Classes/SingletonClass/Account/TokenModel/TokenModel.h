//
//  TokenModel.h
//  AFNetworking
//
//  Created by 张浩 on 2019/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TokenModel : NSObject

/**
 account_id
 */
@property (nonatomic, strong) NSString *account_id;

/**
 access_token
 */
@property (nonatomic, strong) NSString *access_token;

/**
 refresh_token
 */
@property (nonatomic, strong) NSString *refresh_token;

/**
 过期时间
 */
@property (nonatomic, strong) NSString *expired_at;

/**
 检查是否过期
 */
@property (nonatomic, readonly, assign) BOOL checkExpired;

- (NSDictionary *)decodeToDic;

@end

NS_ASSUME_NONNULL_END
