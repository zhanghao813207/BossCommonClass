//
//  StaffTagModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StaffTagModel : NSObject

@property (nonatomic, strong) NSString *_id;

@property (nonatomic, strong) NSString *biz_district_id;

@property (nonatomic, strong) NSString *city_code;

@property (nonatomic, strong) NSString *created_at;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *operator_id;

@property (nonatomic, strong) NSString *platform_code;

@property (nonatomic, assign) NSInteger staff_counter;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, strong) NSString *supplier_id;

@property (nonatomic, assign) NSInteger tag_type;

@property (nonatomic, strong) NSString *updated_at;

@end

NS_ASSUME_NONNULL_END
