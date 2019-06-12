#import <UIKit/UIKit.h>
#import "AccountNotice.h"

@interface AccountNoticeListDicModel : NSObject

@property (nonatomic, strong) NSArray * data;
@property (nonatomic, assign) BOOL ok;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
