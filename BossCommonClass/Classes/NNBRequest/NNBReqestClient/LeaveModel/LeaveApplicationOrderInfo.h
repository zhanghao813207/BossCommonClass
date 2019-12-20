#import <UIKit/UIKit.h>
#import "LeaveCurrentFlowNodeInfo.h"
#import "LeaveFlowInfo.h"

@interface LeaveApplicationOrderInfo : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, assign) NSInteger applicationOrderType;
@property (nonatomic, assign) NSInteger bizState;
@property (nonatomic, strong) LeaveCurrentFlowNodeInfo * currentFlowNodeInfo;
@property (nonatomic, strong) LeaveFlowInfo * flowInfo;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString * submitAt;
@property (nonatomic, assign) NSInteger totalMoney;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end