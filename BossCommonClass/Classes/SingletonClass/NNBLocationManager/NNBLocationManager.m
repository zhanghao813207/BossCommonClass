//
//  NNBLocationManager.m
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/10/19.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import "NNBLocationManager.h"

@interface NNBLocationManager()

@property (nonatomic, assign) CLLocationCoordinate2D currentLocation;

@property (nonatomic, strong) BMKLocationService *locService;

@end

@implementation NNBLocationManager

/**
 单例方法
 
 @return 唯一实例对象
 */
+ (__kindof NNBLocationManager *)shareLocationManager
{
    static NNBLocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NNBLocationManager alloc] init];
    });
    return manager;
}

// 开启定位
- (void)startUserLocationService
{
    [self.locService startUserLocationService];
}

- (CLLocationCoordinate2D)currentLocation
{
    CGFloat latitude = self.locService.userLocation.location.coordinate.latitude;
    CGFloat longitude = self.locService.userLocation.location.coordinate.longitude;
    return CLLocationCoordinate2DMake(latitude, longitude);
}

#pragma mark -- lazy

- (BMKLocationService *)locService
{
    if (!_locService) {
        _locService = [[BMKLocationService alloc] init];
//        _locService.delegate = self;
    }
    return _locService;
}

@end
