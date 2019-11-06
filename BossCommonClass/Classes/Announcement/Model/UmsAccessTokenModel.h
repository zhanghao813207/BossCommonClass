#import <UIKit/UIKit.h>

#define kTokenAvailibleBaseDays  15  // 比对服务端过期时间在当前时间的15天之外是可用,15天之内需要重新获取token

@interface UmsAccessTokenModel : NSObject

@property (nonatomic, strong) NSString * accessToken;
@property (nonatomic, strong) NSString * accountId;
@property (nonatomic, strong) NSString * appId;
@property (nonatomic, strong) NSString * expiredAt;
@property (nonatomic, strong) NSString * refreshToken;
@property (nonatomic, strong) NSString * accessKey;
@property (nonatomic, strong) NSString * secretKey;

@property (nonatomic, assign, readonly) BOOL tokenAvailable; // token是否有效

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
