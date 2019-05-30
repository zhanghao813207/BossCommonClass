#import <UIKit/UIKit.h>

@interface UmsAccessTokenModel : NSObject

@property (nonatomic, strong) NSString * accessToken;
@property (nonatomic, strong) NSString * accountId;
@property (nonatomic, strong) NSString * appId;
@property (nonatomic, strong) NSString * expiredAt;
@property (nonatomic, strong) NSString * refreshToken;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end