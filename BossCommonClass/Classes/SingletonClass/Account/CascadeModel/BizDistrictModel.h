//
//  BizDistrictModel.h
//  Pods-BossKnight
//
//  Created by 贾远潮 on 2018/5/23.
//

#import <Foundation/Foundation.h>

@interface BizDistrictModel : NSObject

/**
 商圈id
 */
@property (nonatomic, strong) NSString *biz_district_id;

/**
 商圈名称
 */
@property (nonatomic, strong) NSString *biz_district_name;

- (NSDictionary *)decodeToDic;

/// 城市全拼_平台code
@property (nonatomic, strong) NSString *city_spelling;

@end
