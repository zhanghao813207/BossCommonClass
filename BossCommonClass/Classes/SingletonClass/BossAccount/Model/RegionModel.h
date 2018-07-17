//
//  RegionModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/7/17.
//

#import <Foundation/Foundation.h>
#import "CityModel.h"
@interface RegionModel : NSObject

@property (nonatomic, strong) NSArray <CityModel *>*city_list;

@property (nonatomic, strong) NSString *platform_code;

@property (nonatomic, strong) NSString *platform_name;

- (NSDictionary *)decodeToDic;

@end
