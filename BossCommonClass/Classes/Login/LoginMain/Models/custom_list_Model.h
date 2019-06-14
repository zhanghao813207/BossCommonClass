#import <UIKit/UIKit.h>

@interface custom_list_Model : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * customId;
@property (nonatomic, strong) NSString * endTime;
@property (nonatomic, strong) NSString * staffId;
@property (nonatomic, strong) NSString * startTime;
@property (nonatomic, assign) NSInteger state;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end