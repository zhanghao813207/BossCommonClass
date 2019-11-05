//
//  MLDTool.h
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/11/4.
//

#import <Foundation/Foundation.h>
#import <MobLinkPro/MobLink.h>
#import <MobLinkPro/MLSDKScene.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLDTool : NSObject

/**
获取单例对象

@return 单例对象
*/
+ (MLDTool *)shareInstance;

/**
获取Mobid

@param path 恢复路径
@param params 参数
@param result 结果回调
*/

- (void)getMobidWithPath:(NSString *)path
                  params:(NSDictionary *)params
                  result:(void (^)(NSString *mobid, NSString *domain, NSError *error))result;
/**
从缓存读取mobid

@param keyPath 对应key
@return mobid
*/
- (NSString *)mobidForKeyPath:(NSString *)keyPath;

/**
使用用户偏好缓存mobid

@param mobid mobid
@param keyPath 对应key
*/
- (void)cacheMobid:(NSString *)mobid forKeyPath:(NSString *)keyPath;

@end

NS_ASSUME_NONNULL_END
