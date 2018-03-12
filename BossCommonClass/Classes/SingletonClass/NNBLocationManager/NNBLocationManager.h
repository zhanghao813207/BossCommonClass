//
//  NNBLocationManager.h
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/10/19.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>

@interface NNBLocationManager : NSObject

@property (nonatomic, assign, readonly) CLLocationCoordinate2D currentLocation;

/**
 单例方法

 @return 唯一实例对象
 */
+ (__kindof NNBLocationManager *)shareLocationManager;

// 开启定位
- (void)startUserLocationService;

@end
