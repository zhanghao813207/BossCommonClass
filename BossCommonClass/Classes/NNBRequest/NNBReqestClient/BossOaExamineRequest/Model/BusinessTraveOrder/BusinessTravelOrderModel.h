#import <UIKit/UIKit.h>
#import "BossBasicDefine.h"
#import "Address.h"

/**
 出差申请单
 */
@interface BusinessTravelOrderModel : NSObject

/**
 出差申请单ID
 */
@property (nonatomic, strong) NSString *idField;

/**
 出差人姓名
 */
@property (nonatomic, strong) NSString *applyUserName;

/**
 出差人手机号
 */
@property (nonatomic, strong) NSString *applyUserPhone;


/**
 出差同行人姓名
 */
@property (nonatomic, strong) NSArray *togetherUserNames;

/**
 单据状态
 */
@property (nonatomic, assign) OrderState bizState;

/**
 出差单类别
 */
@property (nonatomic, assign) TravelApplyType bizType;

/**
 出差单方式
 */
@property (nonatomic, strong) NSArray *transportKind;

/**
 出发地
 */
@property (nonatomic, strong) Address *departure;

/**
 目的地
 */
@property (nonatomic, strong) Address *destination;

/**
 预计出差开始时间 YYYY-MM-DD HH:mm:ss
 */
@property (nonatomic, strong) NSString *expectStartAt;

/**
 预计出差结束时间 YYYY-MM-DD HH:mm:ss
 */
@property (nonatomic, strong) NSString *expectDoneAt;

/**
 预计出差天数
 */
@property (nonatomic, assign) NSInteger expectApplyDays;

/**
 出差原由
 */
@property (nonatomic, strong) NSString *note;

/**
 工作安排
 */
@property (nonatomic, strong) NSString *workingPlan;

@property (nonatomic, strong) NSObject *actualStartAt;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

#pragma mark - Additional attribute

@property (nonatomic, strong, readonly) NSString *bizTypeStr;

@property (nonatomic, strong, readonly) NSString *transportKindStr;

@property (nonatomic, strong, readonly) NSString *togetherUserNameStr;

@property (nonatomic, strong, readonly) NSString *expectStartAtStr;

@property (nonatomic, strong, readonly) NSString *expectDoneAtStr;

@property (nonatomic, strong, readonly) NSString *noteStr;

@property (nonatomic, strong, readonly) NSString *workingPlanStr;

@end
