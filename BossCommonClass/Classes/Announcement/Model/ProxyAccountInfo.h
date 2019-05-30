#import <UIKit/UIKit.h>

@interface ProxyAccountInfo : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * headImgUrl;
@property (nonatomic, strong) NSString * nickName;
@property (nonatomic, strong) NSObject * vendorAccountId;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end