#import <UIKit/UIKit.h>

@interface EnumIndustryCode : NSObject

@property (nonatomic, strong) NSString * blackIcon;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSString * icon;
@property (nonatomic, strong) NSString * name;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end