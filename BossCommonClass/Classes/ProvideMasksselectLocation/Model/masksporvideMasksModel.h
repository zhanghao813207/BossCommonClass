#import <UIKit/UIKit.h>
#import "masksMeta.h"
#import "masksData.h"

@interface masksporvideMasksModel : NSObject

@property (nonatomic, strong) masksMeta * meta;
@property (nonatomic, strong) NSArray * data;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end