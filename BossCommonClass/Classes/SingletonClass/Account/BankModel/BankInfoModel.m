//
//	BankInfoModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "BankInfoModel.h"

NSString *const kBankInfoModelIdField = @"_id";
NSString *const kBankInfoModelBankBranch = @"bank_branch";
NSString *const kBankInfoModelBankBranchName = @"bank_branch_name";
NSString *const kBankInfoModelBankLocation = @"bank_location";
NSString *const kBankInfoModelCardHolderBankCardNo = @"card_holder_bank_card_no";
NSString *const kBankInfoModelCardHolderName = @"card_holder_name";
NSString *const kBankInfoModelCollectIdCardNo = @"collect_id_card_no";
NSString *const kBankInfoModelCollectPhone = @"collect_phone";
NSString *const kBankInfoModelCollectSex = @"collect_sex";
NSString *const kBankInfoModelPaymentType = @"payment_type";

@interface BankInfoModel ()
@end
@implementation BankInfoModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    
    if ([dictionary isKindOfClass:[NSNull class]]) {
        return self;
    }
	if(![dictionary[kBankInfoModelIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kBankInfoModelIdField];
	}	
	if(![dictionary[kBankInfoModelBankBranch] isKindOfClass:[NSNull class]]){
		self.bankBranch = dictionary[kBankInfoModelBankBranch];
	}	
	if(![dictionary[kBankInfoModelBankBranchName] isKindOfClass:[NSNull class]]){
		self.bankBranchName = dictionary[kBankInfoModelBankBranchName];
	}	
	if(![dictionary[kBankInfoModelBankLocation] isKindOfClass:[NSNull class]]){
		self.bankLocation = dictionary[kBankInfoModelBankLocation];
	}	
	if(![dictionary[kBankInfoModelCardHolderBankCardNo] isKindOfClass:[NSNull class]]){
		self.cardHolderBankCardNo = dictionary[kBankInfoModelCardHolderBankCardNo];
	}	
	if(![dictionary[kBankInfoModelCardHolderName] isKindOfClass:[NSNull class]]){
		self.cardHolderName = dictionary[kBankInfoModelCardHolderName];
	}	
	if(![dictionary[kBankInfoModelCollectIdCardNo] isKindOfClass:[NSNull class]]){
		self.collectIdCardNo = dictionary[kBankInfoModelCollectIdCardNo];
	}	
	if(![dictionary[kBankInfoModelCollectPhone] isKindOfClass:[NSNull class]]){
		self.collectPhone = dictionary[kBankInfoModelCollectPhone];
	}	
	if(![dictionary[kBankInfoModelCollectSex] isKindOfClass:[NSNull class]]){
		self.collectSex = dictionary[kBankInfoModelCollectSex];
	}	
	if(![dictionary[kBankInfoModelPaymentType] isKindOfClass:[NSNull class]]){
		self.paymentType = [dictionary[kBankInfoModelPaymentType] integerValue];
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
		dictionary[kBankInfoModelIdField] = self.idField;
	}
	if(self.bankBranch != nil){
		dictionary[kBankInfoModelBankBranch] = self.bankBranch;
	}
	if(self.bankBranchName != nil){
		dictionary[kBankInfoModelBankBranchName] = self.bankBranchName;
	}
	if(self.bankLocation != nil){
		NSMutableArray *arr = [NSMutableArray array];
		for (NSString *bankLocation in self.bankLocation) {
			if (!bankLocation) {
				[arr addObject:bankLocation];
			}
		}
		dictionary[kBankInfoModelBankLocation] = arr;
	}
	if(self.cardHolderBankCardNo != nil){
		dictionary[kBankInfoModelCardHolderBankCardNo] = self.cardHolderBankCardNo;
	}
	if(self.cardHolderName != nil){
		dictionary[kBankInfoModelCardHolderName] = self.cardHolderName;
	}
	if(self.collectIdCardNo != nil){
		dictionary[kBankInfoModelCollectIdCardNo] = self.collectIdCardNo;
	}
	if(self.collectPhone != nil){
		dictionary[kBankInfoModelCollectPhone] = self.collectPhone;
	}
	if(self.collectSex != nil){
		dictionary[kBankInfoModelCollectSex] = self.collectSex;
	}
	dictionary[kBankInfoModelPaymentType] = @(self.paymentType);
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
		[aCoder encodeObject:self.idField forKey:kBankInfoModelIdField];
	}
	if(self.bankBranch != nil){
		[aCoder encodeObject:self.bankBranch forKey:kBankInfoModelBankBranch];
	}
	if(self.bankBranchName != nil){
		[aCoder encodeObject:self.bankBranchName forKey:kBankInfoModelBankBranchName];
	}
	if(self.bankLocation != nil){
		[aCoder encodeObject:self.bankLocation forKey:kBankInfoModelBankLocation];
	}
	if(self.cardHolderBankCardNo != nil){
		[aCoder encodeObject:self.cardHolderBankCardNo forKey:kBankInfoModelCardHolderBankCardNo];
	}
	if(self.cardHolderName != nil){
		[aCoder encodeObject:self.cardHolderName forKey:kBankInfoModelCardHolderName];
	}
	if(self.collectIdCardNo != nil){
		[aCoder encodeObject:self.collectIdCardNo forKey:kBankInfoModelCollectIdCardNo];
	}
	if(self.collectPhone != nil){
		[aCoder encodeObject:self.collectPhone forKey:kBankInfoModelCollectPhone];
	}
	if(self.collectSex != nil){
		[aCoder encodeObject:self.collectSex forKey:kBankInfoModelCollectSex];
	}
	[aCoder encodeObject:@(self.paymentType) forKey:kBankInfoModelPaymentType];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kBankInfoModelIdField];
	self.bankBranch = [aDecoder decodeObjectForKey:kBankInfoModelBankBranch];
	self.bankBranchName = [aDecoder decodeObjectForKey:kBankInfoModelBankBranchName];
	self.bankLocation = [aDecoder decodeObjectForKey:kBankInfoModelBankLocation];
	self.cardHolderBankCardNo = [aDecoder decodeObjectForKey:kBankInfoModelCardHolderBankCardNo];
	self.cardHolderName = [aDecoder decodeObjectForKey:kBankInfoModelCardHolderName];
	self.collectIdCardNo = [aDecoder decodeObjectForKey:kBankInfoModelCollectIdCardNo];
	self.collectPhone = [aDecoder decodeObjectForKey:kBankInfoModelCollectPhone];
	self.collectSex = [aDecoder decodeObjectForKey:kBankInfoModelCollectSex];
	self.paymentType = [[aDecoder decodeObjectForKey:kBankInfoModelPaymentType] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	BankInfoModel *copy = [BankInfoModel new];

	copy.idField = [self.idField copy];
	copy.bankBranch = [self.bankBranch copy];
	copy.bankBranchName = [self.bankBranchName copy];
	copy.bankLocation = [self.bankLocation copy];
	copy.cardHolderBankCardNo = [self.cardHolderBankCardNo copy];
	copy.cardHolderName = [self.cardHolderName copy];
	copy.collectIdCardNo = [self.collectIdCardNo copy];
	copy.collectPhone = [self.collectPhone copy];
	copy.collectSex = [self.collectSex copy];
	copy.paymentType = self.paymentType;

	return copy;
}
@end
