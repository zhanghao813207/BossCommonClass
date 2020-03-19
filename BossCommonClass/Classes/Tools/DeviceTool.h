//
//  DeviceDefine.h
//  BossKnight
//
//  Created by yjs on 2019/10/23.
//  Copyright © 2019 欧客云. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceTool : NSObject

+ (NSString *)deviceVersion;

+ (NSString *)phoneName;

+(NSString *)phoneVersion;

+(NSString *)phoneModel;

//+ (NSString *)getIPAddress;

+ (NSString *)deviceWANIPAddress;


@end

NS_ASSUME_NONNULL_END
