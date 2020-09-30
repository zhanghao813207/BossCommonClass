#import <UIKit/UIKit.h>
#import "EnumIndustryCode.h"

@interface EnumModel : NSObject

@property (nonatomic, strong) NSArray * industryCodes;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end