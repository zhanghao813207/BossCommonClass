//
//  BizDistrictModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/7/17.
//

#import <Foundation/Foundation.h>

@interface BizDistrictModel : NSObject

@property (nonatomic, strong) NSString *biz_district_id;

@property (nonatomic, strong) NSString *biz_district_name;

- (NSDictionary *)decodeToDic;

@end
