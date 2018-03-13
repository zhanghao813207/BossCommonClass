//
//  BossMethodDefine.h
//  Pods
//
//  Created by 贾远潮 on 2018/3/12.
//

#ifndef BossMethodDefine_h
#define BossMethodDefine_h

#import "JYCMethodDefine.h"

/** 获取当前的登录的用户*/
#define kCurrentAccount ([NNBAccount defaultAccount])

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
#define kAppMainColor (kHexRGB(0xFF7700))

// 背景颜色
#define kBossBGColor (kHexRGB(0xf5f5f5))


#endif /* BossMethodDefine_h */
