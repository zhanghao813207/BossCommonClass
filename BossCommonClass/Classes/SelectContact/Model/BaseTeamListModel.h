#import <UIKit/UIKit.h>
#import "BizDistrictTeam.h"
#import "RoleTeam.h"

@interface BaseTeamListModel : NSObject

@property (nonatomic, strong) NSArray * bizDistrictTeam;
@property (nonatomic, strong) RoleTeam * roleTeam;
@property (nonatomic, strong) NSMutableArray * platformList;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
// 通讯录
