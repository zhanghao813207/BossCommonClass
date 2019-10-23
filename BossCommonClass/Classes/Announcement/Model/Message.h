#import <UIKit/UIKit.h>
#import "ProxyAccountInfo.h"
#import "AccountNotice.h"
#import "BossBasicDefine.h"

@interface Message : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * accountId;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) ProxyAccountInfo * proxyAccountInfo;
// 公众号 or 公告
@property (nonatomic, assign) MessageListType messageType;

#pragma mark - private
@property (nonatomic, strong) AccountNotice *accountNotice;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
