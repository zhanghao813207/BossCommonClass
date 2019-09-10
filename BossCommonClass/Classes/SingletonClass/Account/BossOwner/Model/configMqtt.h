#import <UIKit/UIKit.h>

@interface configMqtt : NSObject

@property (nonatomic, strong) NSString * clientid;
@property (nonatomic, strong) NSString * password;
@property (nonatomic, assign) NSInteger port;
@property (nonatomic, strong) NSString * secretKey;
@property (nonatomic, strong) NSString * server;
@property (nonatomic, strong) NSString * userName;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end