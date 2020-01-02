#import <UIKit/UIKit.h>
#import "LeaveApplicationOrderInfo.h"
#import "LeaveAccountInfoList.h"
#import "LeaveAccountInfoList.h"

@interface LeaveRootClass : NSObject
@property (nonatomic, strong) NSString * titleString;
@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * actualApplyName;
@property (nonatomic, strong) NSString * applicationOrderId;
@property (nonatomic, strong) LeaveApplicationOrderInfo * applicationOrderInfo;
@property (nonatomic, strong) NSString * applyAccountId;
@property (nonatomic, strong) LeaveAccountInfoList * applyAccountInfo;
@property (nonatomic, strong) NSArray * assetIds;
@property (nonatomic, strong) NSString * bizDistrictId;
@property (nonatomic, strong) NSString * bizDistrictName;
@property (nonatomic, strong) NSString * cityCode;
@property (nonatomic, strong) NSString * cityName;
@property (nonatomic, strong) NSString * citySpelling;
@property (nonatomic, strong) NSObject * closedAt;
@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, strong) NSObject * doneAt;
@property (nonatomic, assign) float duration;
@property (nonatomic, strong) NSString * endAt;
@property (nonatomic, strong) NSArray * fileUrlList;
@property (nonatomic, assign) NSInteger leaveType;
@property (nonatomic, strong) NSObject * note;
@property (nonatomic, strong) NSString * operatorId;
@property (nonatomic, strong) LeaveAccountInfoList * operatorInfo;
@property (nonatomic, strong) NSString * phone;
@property (nonatomic, strong) NSString * platformCode;
@property (nonatomic, strong) NSString * platformName;
@property (nonatomic, strong) NSString * reason;
@property (nonatomic, strong) NSString * startAt;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString * submitAt;
@property (nonatomic, strong) NSObject * supplierId;
@property (nonatomic, strong) NSString * updatedAt;
@property (nonatomic, strong) NSString * workPlacement;
/**
 归属字符串
 */
@property (nonatomic, strong, readonly) NSString *belongStr;

@property (nonatomic, strong, readonly) NSString *leaveTypeString;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
