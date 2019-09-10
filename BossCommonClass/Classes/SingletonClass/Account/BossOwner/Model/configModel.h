#import <UIKit/UIKit.h>
#import "configH5.h"
#import "configMqtt.h"
#import "configH5.h"

@interface configModel : NSObject

@property (nonatomic, strong) configH5 * h5;
@property (nonatomic, strong) configMqtt * mqtt;
@property (nonatomic, strong) configH5 * ums;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end