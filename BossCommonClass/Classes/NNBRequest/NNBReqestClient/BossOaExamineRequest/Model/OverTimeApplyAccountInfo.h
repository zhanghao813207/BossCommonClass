#import <UIKit/UIKit.h>

@interface OverTimeApplyAccountInfo : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, assign) NSInteger gid;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * phone;
@property (nonatomic, strong) NSString * positionName;
@property (nonatomic, strong) NSObject * staffId;
@property (nonatomic, assign) NSInteger state;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end