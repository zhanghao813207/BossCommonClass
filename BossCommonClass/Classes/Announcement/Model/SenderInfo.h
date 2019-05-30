#import <UIKit/UIKit.h>

@interface SenderInfo : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * headImgUrl;
@property (nonatomic, strong) NSString * nickName;
@property (nonatomic, strong) NSString * vendorAccountId;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end