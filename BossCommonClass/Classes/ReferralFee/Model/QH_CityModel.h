//
//  QH_CityModel.h
//  AFNetworking
//
//  Created by admin on 2019/3/29.
//

#import <Foundation/Foundation.h>
#import "QH_ArearModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface QH_CityModel : NSObject
@property(nonatomic, copy)NSString *code;
@property(nonatomic, copy)NSString *label;
@property(nonatomic, copy)NSString *value;
@property(nonatomic, strong)NSArray *children;
@end

NS_ASSUME_NONNULL_END
