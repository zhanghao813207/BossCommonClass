#import <UIKit/UIKit.h>
#import "ProxyAccountInfo.h"
#import "AccountNotice.h"

@interface Message : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * accountId;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) ProxyAccountInfo * proxyAccountInfo;

#pragma mark - private
@property (nonatomic, strong) AccountNotice *accountNotice;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
