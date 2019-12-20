#import <UIKit/UIKit.h>
#import "LeavePostList.h"

@interface LeaveCurrentFlowNodeInfo : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSArray * accountList;
@property (nonatomic, assign) NSInteger approveMode;
@property (nonatomic, assign) BOOL canUpdateCostRecord;
@property (nonatomic, assign) NSInteger costUpdateRule;
@property (nonatomic, assign) NSInteger indexNum;
@property (nonatomic, assign) BOOL isPaymentNode;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger pickMode;
@property (nonatomic, strong) NSArray * postList;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end