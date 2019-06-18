#import <UIKit/UIKit.h>
#import "BusinessExtraField.h"
// 平台Model
@interface BizDistrictTeam_Platform : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) BusinessExtraField * businessExtraField;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSObject * parentId;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString * vendorId;
@property (nonatomic, strong) NSString * vendorTargetId;
@property (nonatomic, strong) NSMutableArray * PlatformArr;
//@property (nonatomic, strong) NSMutableArray * parentIdArr;
@property (nonatomic, assign) BOOL isSelect;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
