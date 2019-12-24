#import <UIKit/UIKit.h>
#import "LeaveExtraUiOption.h"
#import "LeaveCurrentFlowNodeInfo.h"

@interface LeaveFlowInfo : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, assign) NSInteger bizType;
@property (nonatomic, strong) NSArray * costCatalogScopeList;
@property (nonatomic, strong) LeaveExtraUiOption * extraUiOptions;
@property (nonatomic, assign) BOOL isPrivate;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSArray * nodeList;
@property (nonatomic, assign) NSInteger state;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end