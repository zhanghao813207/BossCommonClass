//
//  ProvinceModel.h
//  AFNetworking
//
//  Created by admin on 2019/3/29.
//

#import <Foundation/Foundation.h>

#import "QH_CityModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProvinceModel : NSObject
@property(nonatomic, copy)NSString *code;
@property(nonatomic, copy)NSString *label;
@property(nonatomic, copy)NSString *value;
///市
@property(nonatomic, strong)NSArray *children;
@end

NS_ASSUME_NONNULL_END
