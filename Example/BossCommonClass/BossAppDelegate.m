//
//  BossAppDelegate.m
//  BossCommonClass
//
//  Created by JiaYuanchao on 03/12/2018.
//  Copyright (c) 2018 JiaYuanchao. All rights reserved.
//

#import "BossAppDelegate.h"
#import "BossBasicDefine.h"
#import "BossManagerAccount.h"
#import "SaasModel.h"
@implementation BossAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
//    [NNBAccount userIsLogin:^(BOOL isLogin) {
//        if (!isLogin) {
//            // 未登录
//            DLog(@"未登录");
//            return;
//        }
//    } Expired:^(BOOL isExpired) {
//        if (!isExpired) {
//            DLog(@"过期")
//            return;
//        }
//        DLog(@"kCurrentBossAccount.account_id = %@",kCurrentBossAccount.account_id);
//        DLog(@"还在有效期");
//    }];
    
    BaseAccount *baseAccount;
    BossManagerAccount *bossManagerAccount = [[BossManagerAccount alloc] init];
    
    TokenModel *tokenModel = [[TokenModel alloc] init];
    tokenModel.account_id = @"123";
    tokenModel.access_token = @"access_token";
    tokenModel.refresh_token = @"refresh_token";
    tokenModel.expired_at = @"expired_at";
    bossManagerAccount.tokenModel = tokenModel;
    
    BossManagerAccountModel *bossManagerAccountModel = [[BossManagerAccountModel alloc] init];
    bossManagerAccountModel._id = @"456";
    
    bossManagerAccount.accountModel = bossManagerAccountModel;
    
    baseAccount = bossManagerAccount;
    
    if([baseAccount isMemberOfClass:[BossManagerAccount class]]){
        BossManagerAccount *accountNew = (BossManagerAccount *) baseAccount;
        DLog(@"\n%@", accountNew.accountModel._id);
    }
    
//    SaasModel *saasModel = [[SaasModel alloc] init];
//    saasModel.access_key = @"access_key";
//    kCache.currentSaasModel = saasModel;
//    NSLog(@"access_key : %@", kCache.currentSaasModel.access_key);
    
    [BossManagerAccount userIsLogin:^(BOOL isLogin) {
        if (!isLogin) {
            // 未登录
            DLog(@"未登录");
            return;
        }
    } Expired:^(BOOL isExpired) {
        if (!isExpired) {
            DLog(@"过期")
            return;
        }
        DLog(@"还在有效期");
    }];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
