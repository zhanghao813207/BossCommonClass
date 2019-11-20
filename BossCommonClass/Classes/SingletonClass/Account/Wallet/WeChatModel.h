#import <UIKit/UIKit.h>

@interface WeChatModel : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * bindAt;
@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, strong) NSString * iconurl;
@property (nonatomic, strong) NSString * nickName;
@property (nonatomic, strong) NSString * openId;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString * unionId;
@property (nonatomic, strong) NSString * updatedAt;

/// 是否绑定微信
@property (nonatomic, assign, readonly) BOOL isBindWeChat;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
