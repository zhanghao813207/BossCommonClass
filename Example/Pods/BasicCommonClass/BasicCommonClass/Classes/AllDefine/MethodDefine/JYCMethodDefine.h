//
//  JYCMethodDefine.h
//  Pods
//
//  Created by 贾远潮 on 2018/3/12.
//

#ifndef JYCMethodDefine_h
#define JYCMethodDefine_h

/** 设备信息*/
// 当前app版本
#define kCurrentAppVersion ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
// 当前设备系统版本
#define kCurrentDeviceVersion ([UIDevice currentDevice].systemVersion)
// 沙盒下document路径
#define kDocumentPath (NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject)
// 获取appDelegate
#define kAppDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])
/** 获取UserDefault*/
#define kUserDefault ([NSUserDefaults standardUserDefaults])

// 状态栏(statusbar)
#define kStatusBarHeight  ([[UIApplication sharedApplication] statusBarFrame].size.height)

/** 屏幕尺寸适配*/
#define kScreenWidth    ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight   ([[UIScreen mainScreen] bounds].size.height)

#define kIphone6Width(w) (((w) * kScreenWidth) / 375.0f)
#define kIphone6Height(h) (((h) * kScreenHeight) / 667.0f)
// 是否是手机
#define IS_ON_IPHONE ([[UIDevice currentDevice].model isEqualToString:@"iPhone"])

//是否是4寸以下设备宽度
#define IsPhone_Size_4 ([UIScreen mainScreen].bounds.size.width < 321.0?YES:NO)

/** 颜色*/
// 设置RGB
#define kHexRGB(rgbValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0])

// 设置RGB 透明度
#define kHexRGBA(rgbValue,alphaValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue])

// 随机颜色
#define kRandomColor  ([UIColor colorWithRed:(CGFloat)arc4random_uniform(256) / 256 green:(CGFloat)arc4random_uniform(256) / 256 blue:(CGFloat)arc4random_uniform(256) / 256 alpha:1.f])

/** weakSelf*/
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self

/** 打印log日志*/
#ifdef DEBUG
#ifndef DLog
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#endif
#ifndef ELog
#   define ELog(err) {if(err) DLog(@"%@", err)}
#endif
#else
#ifndef DLog
#   define DLog(...)
#endif
#ifndef ELog
#   define ELog(err)
#endif
#endif

#endif /* JYCMethodDefine_h */
