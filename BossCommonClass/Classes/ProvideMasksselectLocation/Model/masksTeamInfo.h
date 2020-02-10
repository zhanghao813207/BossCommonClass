#import <UIKit/UIKit.h>

@interface masksTeamInfo : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * bizDistrictId;
@property (nonatomic, strong) NSString * bizDistrictName;
@property (nonatomic, strong) NSString * cityCode;
@property (nonatomic, strong) NSString * cityName;
@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, assign) NSInteger industryCode;
@property (nonatomic, strong) NSString * merchantId;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic, strong) NSString * platformCode;
@property (nonatomic, strong) NSString * platformName;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString * supplierId;
@property (nonatomic, strong) NSString * supplierName;
@property (nonatomic, strong) NSString * updatedAt;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end