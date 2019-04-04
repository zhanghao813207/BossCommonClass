//
//  GetCityView.h
//  AFNetworking
//
//  Created by admin on 2019/3/29.
//

#import <UIKit/UIKit.h>
#import "ProvinceModel.h"
#import "QH_CityModel.h"
#import "QH_ArearModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol GetCityViewDelegate <NSObject>

- (void)provice:(ProvinceModel *)provinceModel city:(QH_CityModel *)cityModel area:(QH_ArearModel *)arearModel;

@end
@interface GetCityView : UIView
@property(nonatomic, weak)id<GetCityViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
