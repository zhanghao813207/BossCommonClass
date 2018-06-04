//
//  CityModel.h
//  Pods-BossKnight
//
//  Created by 贾远潮 on 2018/5/23.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject

/**
 城市名称
 */
@property (nonatomic, strong) NSArray *city_name;

/**
 城市全拼
 */
@property (nonatomic, strong) NSString *city;

/**
 城市全拼_平台code
 */
@property (nonatomic, strong) NSString *city_spelling;

/**
 城市名称_平台名称
 */
@property (nonatomic, strong) NSString *city_name_joint;

- (NSDictionary *)decodeToDic;

@end
