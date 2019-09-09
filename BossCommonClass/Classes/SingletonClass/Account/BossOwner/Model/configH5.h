#import <UIKit/UIKit.h>

@interface configH5 : NSObject

@property (nonatomic, strong) NSString * url;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end