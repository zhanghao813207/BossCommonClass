#import <UIKit/UIKit.h>
#import "LeaveAccountInfoList.h"
#import "LeaveAccountInfoList.h"
#import "LeaveAccountInfoList.h"

@interface LeavePostList : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSArray * accountIds;
@property (nonatomic, strong) NSArray * accountInfoList;
@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, strong) NSString * creatorId;
@property (nonatomic, strong) LeaveAccountInfoList * creatorInfo;
@property (nonatomic, strong) NSString * operatorId;
@property (nonatomic, strong) LeaveAccountInfoList * operatorInfo;
@property (nonatomic, strong) NSString * postName;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSObject * type;
@property (nonatomic, strong) NSString * updatedAt;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end