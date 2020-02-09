#import <UIKit/UIKit.h>
#import "masksRoleInfo.h"
#import "masksTeamInfo.h"

@interface masksData : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * accountId;
@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, assign) BOOL isOwner;
@property (nonatomic, strong) NSString * note;
@property (nonatomic, strong) NSArray * permissionList;
@property (nonatomic, strong) NSString * qrcode;
@property (nonatomic, strong) NSString * quitReason;
@property (nonatomic, assign) NSInteger role;
@property (nonatomic, strong) masksRoleInfo * roleInfo;
@property (nonatomic, assign) BOOL salaryOpen;
@property (nonatomic, strong) NSString * staffId;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString * teamId;
@property (nonatomic, strong) masksTeamInfo * teamInfo;
@property (nonatomic, strong) NSString * updatedAt;
@property (nonatomic, strong) NSString * statusStr;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
