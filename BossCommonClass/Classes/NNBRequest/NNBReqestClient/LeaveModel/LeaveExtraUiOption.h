#import <UIKit/UIKit.h>

@interface LeaveExtraUiOption : NSObject

@property (nonatomic, strong) NSString * formTemplate;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end