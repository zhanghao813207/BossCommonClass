#import <UIKit/UIKit.h>
#import "BizDistrictTeamPlatformModel.h"

@interface RoleTeam : NSObject
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSArray * data;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
