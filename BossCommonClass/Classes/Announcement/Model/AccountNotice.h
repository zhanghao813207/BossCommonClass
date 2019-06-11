#import <UIKit/UIKit.h>
#import "MessageSummaryInfo.h"
#import "ProxyInfo.h"
#import "SenderInfo.h"

@interface AccountNotice : NSObject

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) MessageSummaryInfo * messageSummaryInfo;
@property (nonatomic, strong) ProxyInfo * proxyInfo;
@property (nonatomic, strong) SenderInfo * senderInfo;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
