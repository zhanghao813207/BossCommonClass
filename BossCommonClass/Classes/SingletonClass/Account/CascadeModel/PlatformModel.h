//
//  PlatformModel.h
//  Pods-BossKnight
//
//  Created by 贾远潮 on 2018/5/23.
//

#import <Foundation/Foundation.h>

@interface PlatformModel : NSObject

/**
 平台名称
 */
@property (nonatomic, strong) NSString *platform_name;

/**
 平台code
 */
@property (nonatomic, strong) NSString *platform_code;

- (NSDictionary *)decodeToDic;
@end
