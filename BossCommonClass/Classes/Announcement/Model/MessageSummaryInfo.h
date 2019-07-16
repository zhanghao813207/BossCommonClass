#import <UIKit/UIKit.h>

//#import "WebExtraDataModel.h"

@interface MessageSummaryInfo : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, assign) NSInteger extraType;
@property (nonatomic, assign) NSInteger messageType;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) NSInteger messagemimekind;
@property (nonatomic, strong) NSString *showAt_time;
@property (nonatomic, strong) NSString *showAt;

@property (nonatomic, strong) NSDictionary * extra_data;

//@property (nonatomic, strong) WebExtraDataModel * extra_data;



-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end
