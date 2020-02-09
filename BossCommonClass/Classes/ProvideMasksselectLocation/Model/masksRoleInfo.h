#import <UIKit/UIKit.h>

@interface masksRoleInfo : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSArray * permissionIds;
@property (nonatomic, assign) NSInteger role;
@property (nonatomic, assign) NSInteger state;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end