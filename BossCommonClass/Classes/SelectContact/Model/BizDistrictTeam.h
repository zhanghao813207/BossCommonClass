#import <UIKit/UIKit.h>
#import "BusinessExtraField.h"
// 联系人Model
@interface BizDistrictTeam: NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) BusinessExtraField * businessExtraField;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSObject * parentId;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString * vendorId;
@property (nonatomic, strong) NSString * vendorTargetId;
@property (nonatomic, assign) BOOL isSelect;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
