#import <UIKit/UIKit.h>

@interface masksMerchantInfo : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * apiGateway;
@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, strong) NSString * merchantCode;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString * updatedAt;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end