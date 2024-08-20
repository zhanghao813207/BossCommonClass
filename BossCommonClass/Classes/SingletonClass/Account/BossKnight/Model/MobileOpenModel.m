//
//	MobileOpenModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "MobileOpenModel.h"

NSString *const kMobileOpenModelBoduRegister = @"bodu_register";
NSString *const kMobileOpenModelMessage = @"message";
NSString *const kMobileOpenModelSalaryLoan = @"salary_loan";
NSString *const kMobileOpenModelSchoolStudy = @"school_study";
NSString *const kMobileOpenModelWallet = @"wallet";

@interface MobileOpenModel ()
@end
@implementation MobileOpenModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
    
    if ([dictionary isKindOfClass:[NSNull class]]) {
        return self;
    }
	if(![dictionary[kMobileOpenModelBoduRegister] isKindOfClass:[NSNull class]]){
		self.boduRegister = [dictionary[kMobileOpenModelBoduRegister] boolValue];
	}

	if(![dictionary[kMobileOpenModelMessage] isKindOfClass:[NSNull class]]){
		self.message = [dictionary[kMobileOpenModelMessage] boolValue];
	}

	if(![dictionary[kMobileOpenModelSalaryLoan] isKindOfClass:[NSNull class]]){
		self.salaryLoan = [dictionary[kMobileOpenModelSalaryLoan] boolValue];
	}

	if(![dictionary[kMobileOpenModelSchoolStudy] isKindOfClass:[NSNull class]]){
		self.schoolStudy = [dictionary[kMobileOpenModelSchoolStudy] boolValue];
	}

	if(![dictionary[kMobileOpenModelWallet] isKindOfClass:[NSNull class]]){
		self.wallet = [dictionary[kMobileOpenModelWallet] boolValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kMobileOpenModelBoduRegister] = @(self.boduRegister);
	dictionary[kMobileOpenModelMessage] = @(self.message);
	dictionary[kMobileOpenModelSalaryLoan] = @(self.salaryLoan);
	dictionary[kMobileOpenModelSchoolStudy] = @(self.schoolStudy);
	dictionary[kMobileOpenModelWallet] = @(self.wallet);
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
	[aCoder encodeObject:@(self.boduRegister) forKey:kMobileOpenModelBoduRegister];	[aCoder encodeObject:@(self.message) forKey:kMobileOpenModelMessage];	[aCoder encodeObject:@(self.salaryLoan) forKey:kMobileOpenModelSalaryLoan];	[aCoder encodeObject:@(self.schoolStudy) forKey:kMobileOpenModelSchoolStudy];	[aCoder encodeObject:@(self.wallet) forKey:kMobileOpenModelWallet];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.boduRegister = [[aDecoder decodeObjectForKey:kMobileOpenModelBoduRegister] boolValue];
	self.message = [[aDecoder decodeObjectForKey:kMobileOpenModelMessage] boolValue];
	self.salaryLoan = [[aDecoder decodeObjectForKey:kMobileOpenModelSalaryLoan] boolValue];
	self.schoolStudy = [[aDecoder decodeObjectForKey:kMobileOpenModelSchoolStudy] boolValue];
	self.wallet = [[aDecoder decodeObjectForKey:kMobileOpenModelWallet] boolValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	MobileOpenModel *copy = [MobileOpenModel new];

	copy.boduRegister = self.boduRegister;
	copy.message = self.message;
	copy.salaryLoan = self.salaryLoan;
	copy.schoolStudy = self.schoolStudy;
	copy.wallet = self.wallet;

	return copy;
}
@end
