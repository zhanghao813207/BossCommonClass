#import <UIKit/UIKit.h>

@interface BusinessExtraField : NSObject

@property (nonatomic, strong) NSString * cityCode;
@property (nonatomic, strong) NSString * cityName;
@property (nonatomic, strong) NSString * platformCode;
@property (nonatomic, strong) NSString * platformName;
@property (nonatomic, strong) NSString * supplierId;
@property (nonatomic, strong) NSString * supplierName;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end