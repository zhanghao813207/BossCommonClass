//
//  LocalAuthorityManage.h
//  AFNetworking
//
//  Created by admin on 2019/10/16.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocalAuthorityManage : NSObject<CLLocationManagerDelegate>

#pragma mark - 检查授权状态
+ (void)checkLocalAuthorizationStatus;

+ (instancetype)sharedLocalAuthorityManage;

// 是否展示三方授权页面
+(void)showThreePartyConfigWithShow:(BOOL)show;

@end

NS_ASSUME_NONNULL_END
