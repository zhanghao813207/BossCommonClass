#import <UIKit/UIKit.h>
#import "OverTimeApplyAccountInfo.h"
#import "OverTimeApplyAccountInfo.h"

@interface OverTimeRootClass : NSObject
/**
 请假/加班标题 （实际请假/加班人）
*/
@property (nonatomic, assign) NSString *titleString;
/**
 归属字符串
 */
@property (nonatomic, strong, readonly) NSString *belongStr;

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * actualApplyName;
@property (nonatomic, strong) NSString * applicationOrderId;
@property (nonatomic, strong) NSString * applyAccountId;
@property (nonatomic, strong) OverTimeApplyAccountInfo * applyAccountInfo;
@property (nonatomic, strong) NSArray * assetIds;
@property (nonatomic, strong) NSString * bizDistrictId;
@property (nonatomic, strong) NSString * bizDistrictName;
@property (nonatomic, strong) NSString * cityCode;
@property (nonatomic, strong) NSString * cityName;
@property (nonatomic, strong) NSString * citySpelling;
@property (nonatomic, strong) NSObject * closedAt;
@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, strong) NSObject * doneAt;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, strong) NSString * endAt;
@property (nonatomic, strong) NSArray * fileUrlList;
@property (nonatomic, strong) NSString * infoAddress;
@property (nonatomic, strong) NSObject * note;
@property (nonatomic, strong) NSString * operatorId;
@property (nonatomic, strong) OverTimeApplyAccountInfo * operatorInfo;
@property (nonatomic, strong) NSString * platformCode;
@property (nonatomic, strong) NSString * platformName;
@property (nonatomic, strong) NSString * reason;
@property (nonatomic, strong) NSString * startAt;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString * submitAt;
@property (nonatomic, strong) NSObject * supplierId;
@property (nonatomic, strong) NSArray * tags;
@property (nonatomic, strong) NSString * updatedAt;
@property (nonatomic, assign) NSInteger workingHours;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
