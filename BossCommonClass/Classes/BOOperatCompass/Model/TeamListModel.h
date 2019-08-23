#import <UIKit/UIKit.h>
#import "BossEnumDefin.h"

@interface TeamListModel : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * bizDistrictName;
@property (nonatomic, strong) NSString * staffId;
@property (nonatomic, strong) NSString * supplierName;
@property (nonatomic, strong) NSString * teamId;
@property (nonatomic, strong) NSString * teamName;
@property (nonatomic, strong) NSString * qrcode;
@property (nonatomic, strong) NSArray * workbenchLabel;
@property (nonatomic, strong) NSString * merchantId;
@property (nonatomic, strong) NSString * biz_district_id;

@property (nonatomic, assign) LineDustryType industryCode; //业务线

@property (nonatomic, strong) NSString * merchantName;


-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
