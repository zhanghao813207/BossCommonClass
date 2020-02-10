#import <UIKit/UIKit.h>

@interface masksAccountInfo : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, strong) NSString * name;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end