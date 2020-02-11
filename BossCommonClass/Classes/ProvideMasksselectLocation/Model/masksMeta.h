#import <UIKit/UIKit.h>

@interface masksMeta : NSObject

@property (nonatomic, assign) BOOL hasMore;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) NSInteger resultCount;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end