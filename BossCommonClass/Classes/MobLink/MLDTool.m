//
//  MLDTool.m
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/11/4.
//

#import "MLDTool.h"




@implementation MLDTool


+ (MLDTool *)shareInstance
{
    static MLDTool *_instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _instance = [[MLDTool alloc] init];
    });
    
    return _instance;
}
/**
 获取Mobid
 
 @param path 恢复路径
 @param params 参数
 @param result 结果回调
 */
- (void)getMobidWithPath:(NSString *)path
                  params:(NSDictionary *)params
                  result:(void (^)(NSString *mobid, NSString *domain, NSError *error))result
{
    
    MLSDKScene *scene = [MLSDKScene sceneForPath:path params:params];
    
    [MobLink getMobId:scene result:^(NSString *mobid, NSString *domain, NSError *error) {
        if (result)
        {
            result(mobid, domain, error);
        }
    }];
}


/**
 从缓存读取mobid
 
 @param keyPath 对应key
 @return mobid
 */
- (NSString *)mobidForKeyPath:(NSString *)keyPath
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:keyPath];
}

/**
 使用用户偏好缓存mobid
 
 @param mobid mobid
 @param keyPath 对应key
 */
- (void)cacheMobid:(NSString *)mobid forKeyPath:(NSString *)keyPath
{
    [[NSUserDefaults standardUserDefaults] setObject:mobid forKey:keyPath];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
