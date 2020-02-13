#import <UIKit/UIKit.h>
#import "masksAccountInfo.h"
#import "masksTeamInfo.h"

@interface masksData : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * accountId;
@property (nonatomic, strong) masksAccountInfo * accountInfo;
@property (nonatomic, strong) NSObject * approvalAccountId;
@property (nonatomic, strong) NSObject * approvalAt;
@property (nonatomic, assign) NSInteger belongDate;
@property (nonatomic, strong) NSString * bizDistrictId;
@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, strong) NSString * customId;
@property (nonatomic, strong) NSObject * distributeAccountId;
@property (nonatomic, strong) NSObject * rejectNote;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString * takeAt;
@property (nonatomic, strong) NSString * teamId;
@property (nonatomic, strong) masksTeamInfo * teamInfo;
@property (nonatomic, strong) NSString * updatedAt;
@property (nonatomic, strong) NSString * statusStr;
@property (nonatomic, strong) NSString * dayStr;
@property (nonatomic, strong) NSString * monthStr;
@property (nonatomic, strong) NSString * yearStr;
@property (nonatomic, strong) NSString * qty;
@property (nonatomic, assign) BOOL customIdDifferent;


-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
