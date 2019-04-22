//
//	BalanceMoneyModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "BalanceMoneyModel.h"
// 钱包id
NSString *const kBalanceMoneyModelIdField = @"_id";
// 余额(分)
NSString *const kBalanceMoneyModelBalanceMoney = @"balance_money";
// 创建时间
NSString *const kBalanceMoneyModelCreatedAt = @"created_at";
// 可用金额(分)
NSString *const kBalanceMoneyModelFreeMoney = @"free_money";
// 冻结金额(分)
NSString *const kBalanceMoneyModelFrozenMoney = @"frozen_money";
// 用户类型(10:个独 20:个户)
NSString *const kBalanceMoneyModelOwnerType = @"owner_type";
// 更新时间
NSString *const kBalanceMoneyModelUpdatedAt = @"updated_at";

@interface BalanceMoneyModel ()
@end
@implementation BalanceMoneyModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kBalanceMoneyModelIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kBalanceMoneyModelIdField];
	}	
	if(![dictionary[kBalanceMoneyModelBalanceMoney] isKindOfClass:[NSNull class]]){
		self.balanceMoney =[NSString stringWithFormat:@"%@", dictionary[kBalanceMoneyModelBalanceMoney]];
	}	
	if(![dictionary[kBalanceMoneyModelCreatedAt] isKindOfClass:[NSNull class]]){
		self.createdAt = dictionary[kBalanceMoneyModelCreatedAt];
	}	
	if(![dictionary[kBalanceMoneyModelFreeMoney] isKindOfClass:[NSNull class]]){
        if ([dictionary[kBalanceMoneyModelFreeMoney] integerValue] == 0) {
            self.freeMoney = 0.00;
        } else {
            self.freeMoney = [dictionary[kBalanceMoneyModelFreeMoney] integerValue];
        }
	}

	if(![dictionary[kBalanceMoneyModelFrozenMoney] isKindOfClass:[NSNull class]]){
        if ([dictionary[kBalanceMoneyModelFrozenMoney] integerValue] == 0) {
            self.frozenMoney = 0.00;
        } else {
            self.frozenMoney = [dictionary[kBalanceMoneyModelFrozenMoney] integerValue];
        }
	}

	if(![dictionary[kBalanceMoneyModelOwnerType] isKindOfClass:[NSNull class]]){
        if ([dictionary[kBalanceMoneyModelOwnerType] integerValue] == 0) {
            self.ownerType = 0.00;
        } else {
            self.ownerType = [dictionary[kBalanceMoneyModelOwnerType] integerValue];
        }
		
	}

	if(![dictionary[kBalanceMoneyModelUpdatedAt] isKindOfClass:[NSNull class]]){
		self.updatedAt = dictionary[kBalanceMoneyModelUpdatedAt];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.idField != nil){
		dictionary[kBalanceMoneyModelIdField] = self.idField;
	}
	if(self.balanceMoney != nil){
		dictionary[kBalanceMoneyModelBalanceMoney] = self.balanceMoney;
	}
	if(self.createdAt != nil){
		dictionary[kBalanceMoneyModelCreatedAt] = self.createdAt;
	}
	dictionary[kBalanceMoneyModelFreeMoney] = @(self.freeMoney);
	dictionary[kBalanceMoneyModelFrozenMoney] = @(self.frozenMoney);
	dictionary[kBalanceMoneyModelOwnerType] = @(self.ownerType);
	if(self.updatedAt != nil){
		dictionary[kBalanceMoneyModelUpdatedAt] = self.updatedAt;
	}
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.idField != nil){
		[aCoder encodeObject:self.idField forKey:kBalanceMoneyModelIdField];
	}
	if(self.balanceMoney != nil){
		[aCoder encodeObject:self.balanceMoney forKey:kBalanceMoneyModelBalanceMoney];
	}
	if(self.createdAt != nil){
		[aCoder encodeObject:self.createdAt forKey:kBalanceMoneyModelCreatedAt];
	}
	[aCoder encodeObject:@(self.freeMoney) forKey:kBalanceMoneyModelFreeMoney];	[aCoder encodeObject:@(self.frozenMoney) forKey:kBalanceMoneyModelFrozenMoney];	[aCoder encodeObject:@(self.ownerType) forKey:kBalanceMoneyModelOwnerType];	if(self.updatedAt != nil){
		[aCoder encodeObject:self.updatedAt forKey:kBalanceMoneyModelUpdatedAt];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kBalanceMoneyModelIdField];
	self.balanceMoney = [aDecoder decodeObjectForKey:kBalanceMoneyModelBalanceMoney];
	self.createdAt = [aDecoder decodeObjectForKey:kBalanceMoneyModelCreatedAt];
	self.freeMoney = [[aDecoder decodeObjectForKey:kBalanceMoneyModelFreeMoney] integerValue];
	self.frozenMoney = [[aDecoder decodeObjectForKey:kBalanceMoneyModelFrozenMoney] integerValue];
	self.ownerType = [[aDecoder decodeObjectForKey:kBalanceMoneyModelOwnerType] integerValue];
	self.updatedAt = [aDecoder decodeObjectForKey:kBalanceMoneyModelUpdatedAt];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	BalanceMoneyModel *copy = [BalanceMoneyModel new];

	copy.idField = [self.idField copy];
	copy.balanceMoney = [self.balanceMoney copy];
	copy.createdAt = [self.createdAt copy];
	copy.freeMoney = self.freeMoney;
	copy.frozenMoney = self.frozenMoney;
	copy.ownerType = self.ownerType;
	copy.updatedAt = [self.updatedAt copy];

	return copy;
}
@end
