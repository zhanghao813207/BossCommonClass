#import <UIKit/UIKit.h>
#import "Meta.h"
#import "Message.h"

@interface MessageListDicModel : NSObject

@property (nonatomic, strong) Meta * meta;
@property (nonatomic, strong) NSArray * data;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
