//
//  BossMethodDefine.h
//  Pods
//
//  Created by 贾远潮 on 2018/3/12.
//

#ifndef BossMethodDefine_h
#define BossMethodDefine_h
// 缓存
#define kCache ([BossCache defaultCache])

//// 当前Boss骑士登录帐号 - BossKnightAccount
//#define kCurrentBossKnightAccount kCache.currentKnightAccount

// 当前Boss之家登录帐号 - BossMangerAccount
#define kCurrentBossManagerAccount kCache.currentManagerAccount

// 当前Boss老板登录帐号 - BossOwnerAccount （骑士和当家共用一个 kCurrentBossOwnerAccount）
#define kCurrentBossOwnerAccount kCache.currentBossOwnerAccount

// 是否启用本地配置
#define kLocalConfig kCache.localConfig

#define kUrlApiVersion(apiVersion) ([kCache getUrlByApiVersion:apiVersion])

#define kUrl kCache.url

/**
 字体
 app 统一使用PingFangSC字体
 f_size 字体大小
 */
// 轻浅字体
#define BossFont(f_size) IsPhone_Size_4?[UIFont fontWithName:@"PingFangSC-Light" size:(f_size-2)]:[UIFont fontWithName:@"PingFangSC-Light" size:f_size]
// 普通字体
#define BossRegularFont(f_size)  IsPhone_Size_4? [UIFont fontWithName:@"PingFangSC-Regular" size:f_size-2]:[UIFont fontWithName:@"PingFangSC-Regular" size:f_size]
// 加粗字体
#define BossBlodFont(f_size) IsPhone_Size_4?[UIFont fontWithName:@"PingFangSC-Medium" size:(f_size-2)]:[UIFont fontWithName:@"PingFangSC-Medium" size:f_size]

// 系统主颜色
#ifdef kBossKnight

#define kAppMainColor (kHexRGB(0x3589DE))

#elif defined kBossManager

#define kAppMainColor (kHexRGB(0x479CFF))

#else

#define kAppMainColor (kHexRGB(0x3589DE))

#endif


// 背景颜色
#define kBossBGColor (kHexRGB(0xf5f5f5))

// 线的颜色
#define kLineColor (kHexRGBA(0x000000,0.1))
#define kBossManagerLineColor [UIColor colorNamed:@"boss_000000-10_2B2B2B"]

// BossCommonClass.bundle
#define bundlePath  [[NSBundle bundleForClass:[self class]].resourcePath stringByAppendingPathComponent:@"/BossCommonClass.bundle"]
#define QH_Bundle [NSBundle bundleWithPath:bundlePath]

#define iPhoneX ({\
BOOL isBangsScreen = NO; \
if (@available(iOS 11.0, *)) { \
UIWindow *window = [[UIApplication sharedApplication].windows firstObject]; \
isBangsScreen = window.safeAreaInsets.bottom > 0; \
} \
isBangsScreen; \
})

#endif /* BossMethodDefine_h */
