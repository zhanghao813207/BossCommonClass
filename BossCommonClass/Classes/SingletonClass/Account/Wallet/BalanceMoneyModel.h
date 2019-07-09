#import <UIKit/UIKit.h>

@interface BalanceMoneyModel : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * balanceMoney;
@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, assign) CGFloat freeMoney;
@property (nonatomic, assign) CGFloat frozenMoney;
@property (nonatomic, assign) NSInteger ownerType;
@property (nonatomic, strong) NSString * updatedAt;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
