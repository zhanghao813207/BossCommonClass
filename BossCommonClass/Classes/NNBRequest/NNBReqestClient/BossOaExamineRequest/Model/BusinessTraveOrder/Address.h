#import <UIKit/UIKit.h>

/**
 地址
 */
@interface Address : NSObject

@property (nonatomic, assign) NSInteger area;
@property (nonatomic, strong) NSString * areaName;
@property (nonatomic, assign) NSInteger city;
@property (nonatomic, strong) NSString * cityName;
@property (nonatomic, strong) NSString * detailedAddress;
@property (nonatomic, assign) NSInteger province;
@property (nonatomic, strong) NSString * provinceName;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

#pragma mark - Additional attribute

/**
 省市区
 */
@property (nonatomic, strong, readonly) NSString *addressToAreaStr;

/**
 省市区详细地址
 */
@property (nonatomic, strong, readonly) NSString *addressStr;
@end
