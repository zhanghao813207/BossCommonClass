#import <UIKit/UIKit.h>
#import "ProxyAccountInfo.h"
#import "AccountNotice.h"
#import "BossBasicDefine.h"

@interface Message : NSObject
//本地使用 是否是新数据
@property (nonatomic) BOOL isNewData;
@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * accountId;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString * headimgurl;
@property (nonatomic, strong) NSString * DarkModeHeadimgUrl;
@property (nonatomic, strong) ProxyAccountInfo * proxyAccountInfo;

//  个户注册 or 团队助手
@property (nonatomic, assign) MessageTargetType messageTargetType;

// 公众号 or 公告
@property (nonatomic, assign) MessageListType messageType;

#pragma mark - private

@property (nonatomic, strong) AccountNotice *accountNotice;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
