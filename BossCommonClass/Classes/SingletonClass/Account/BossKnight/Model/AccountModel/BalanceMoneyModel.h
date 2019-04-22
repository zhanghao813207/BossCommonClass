#import <UIKit/UIKit.h>

@interface BalanceMoneyModel : NSObject

@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * balanceMoney;
@property (nonatomic, strong) NSString * createdAt;
@property (nonatomic, assign) NSInteger freeMoney;
@property (nonatomic, assign) NSInteger frozenMoney;
@property (nonatomic, assign) NSInteger ownerType;
@property (nonatomic, strong) NSString * updatedAt;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
