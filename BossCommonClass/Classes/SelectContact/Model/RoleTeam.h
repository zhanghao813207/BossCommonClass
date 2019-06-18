#import <UIKit/UIKit.h>
#import "BizDistrictTeam.h"

@interface RoleTeam : NSObject

@property (nonatomic, strong) NSArray * data;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end