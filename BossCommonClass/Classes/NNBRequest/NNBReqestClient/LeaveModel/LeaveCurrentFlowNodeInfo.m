//
//	LeaveCurrentFlowNodeInfo.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "LeaveCurrentFlowNodeInfo.h"

NSString *const kLeaveCurrentFlowNodeInfoIdField = @"_id";
NSString *const kLeaveCurrentFlowNodeInfoAccountList = @"account_list";
NSString *const kLeaveCurrentFlowNodeInfoApproveMode = @"approve_mode";
NSString *const kLeaveCurrentFlowNodeInfoCanUpdateCostRecord = @"can_update_cost_record";
NSString *const kLeaveCurrentFlowNodeInfoCostUpdateRule = @"cost_update_rule";
NSString *const kLeaveCurrentFlowNodeInfoIndexNum = @"index_num";
NSString *const kLeaveCurrentFlowNodeInfoIsPaymentNode = @"is_payment_node";
NSString *const kLeaveCurrentFlowNodeInfoName = @"name";
NSString *const kLeaveCurrentFlowNodeInfoPickMode = @"pick_mode";
NSString *const kLeaveCurrentFlowNodeInfoPostList = @"post_list";

@interface LeaveCurrentFlowNodeInfo ()
@end
@implementation LeaveCurrentFlowNodeInfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kLeaveCurrentFlowNodeInfoIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kLeaveCurrentFlowNodeInfoIdField];
	}	
	if(![dictionary[kLeaveCurrentFlowNodeInfoAccountList] isKindOfClass:[NSNull class]]){
		self.accountList = dictionary[kLeaveCurrentFlowNodeInfoAccountList];
	}	
	if(![dictionary[kLeaveCurrentFlowNodeInfoApproveMode] isKindOfClass:[NSNull class]]){
		self.approveMode = [dictionary[kLeaveCurrentFlowNodeInfoApproveMode] integerValue];
	}

	if(![dictionary[kLeaveCurrentFlowNodeInfoCanUpdateCostRecord] isKindOfClass:[NSNull class]]){
		self.canUpdateCostRecord = [dictionary[kLeaveCurrentFlowNodeInfoCanUpdateCostRecord] boolValue];
	}

	if(![dictionary[kLeaveCurrentFlowNodeInfoCostUpdateRule] isKindOfClass:[NSNull class]]){
		self.costUpdateRule = [dictionary[kLeaveCurrentFlowNodeInfoCostUpdateRule] integerValue];
	}

	if(![dictionary[kLeaveCurrentFlowNodeInfoIndexNum] isKindOfClass:[NSNull class]]){
		self.indexNum = [dictionary[kLeaveCurrentFlowNodeInfoIndexNum] integerValue];
	}

	if(![dictionary[kLeaveCurrentFlowNodeInfoIsPaymentNode] isKindOfClass:[NSNull class]]){
		self.isPaymentNode = [dictionary[kLeaveCurrentFlowNodeInfoIsPaymentNode] boolValue];
	}

	if(![dictionary[kLeaveCurrentFlowNodeInfoName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kLeaveCurrentFlowNodeInfoName];
	}	
	if(![dictionary[kLeaveCurrentFlowNodeInfoPickMode] isKindOfClass:[NSNull class]]){
		self.pickMode = [dictionary[kLeaveCurrentFlowNodeInfoPickMode] integerValue];
	}

	if(dictionary[kLeaveCurrentFlowNodeInfoPostList] != nil && [dictionary[kLeaveCurrentFlowNodeInfoPostList] isKindOfClass:[NSArray class]]){
		NSArray * postListDictionaries = dictionary[kLeaveCurrentFlowNodeInfoPostList];
		NSMutableArray * postListItems = [NSMutableArray array];
		for(NSDictionary * postListDictionary in postListDictionaries){
			LeavePostList * postListItem = [[LeavePostList alloc] initWithDictionary:postListDictionary];
			[postListItems addObject:postListItem];
		}
		self.postList = postListItems;
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
		dictionary[kLeaveCurrentFlowNodeInfoIdField] = self.idField;
	}
	if(self.accountList != nil){
		dictionary[kLeaveCurrentFlowNodeInfoAccountList] = self.accountList;
	}
	dictionary[kLeaveCurrentFlowNodeInfoApproveMode] = @(self.approveMode);
	dictionary[kLeaveCurrentFlowNodeInfoCanUpdateCostRecord] = @(self.canUpdateCostRecord);
	dictionary[kLeaveCurrentFlowNodeInfoCostUpdateRule] = @(self.costUpdateRule);
	dictionary[kLeaveCurrentFlowNodeInfoIndexNum] = @(self.indexNum);
	dictionary[kLeaveCurrentFlowNodeInfoIsPaymentNode] = @(self.isPaymentNode);
	if(self.name != nil){
		dictionary[kLeaveCurrentFlowNodeInfoName] = self.name;
	}
	dictionary[kLeaveCurrentFlowNodeInfoPickMode] = @(self.pickMode);
	if(self.postList != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(LeavePostList * postListElement in self.postList){
			[dictionaryElements addObject:[postListElement toDictionary]];
		}
		dictionary[kLeaveCurrentFlowNodeInfoPostList] = dictionaryElements;
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
		[aCoder encodeObject:self.idField forKey:kLeaveCurrentFlowNodeInfoIdField];
	}
	if(self.accountList != nil){
		[aCoder encodeObject:self.accountList forKey:kLeaveCurrentFlowNodeInfoAccountList];
	}
	[aCoder encodeObject:@(self.approveMode) forKey:kLeaveCurrentFlowNodeInfoApproveMode];	[aCoder encodeObject:@(self.canUpdateCostRecord) forKey:kLeaveCurrentFlowNodeInfoCanUpdateCostRecord];	[aCoder encodeObject:@(self.costUpdateRule) forKey:kLeaveCurrentFlowNodeInfoCostUpdateRule];	[aCoder encodeObject:@(self.indexNum) forKey:kLeaveCurrentFlowNodeInfoIndexNum];	[aCoder encodeObject:@(self.isPaymentNode) forKey:kLeaveCurrentFlowNodeInfoIsPaymentNode];	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kLeaveCurrentFlowNodeInfoName];
	}
	[aCoder encodeObject:@(self.pickMode) forKey:kLeaveCurrentFlowNodeInfoPickMode];	if(self.postList != nil){
		[aCoder encodeObject:self.postList forKey:kLeaveCurrentFlowNodeInfoPostList];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kLeaveCurrentFlowNodeInfoIdField];
	self.accountList = [aDecoder decodeObjectForKey:kLeaveCurrentFlowNodeInfoAccountList];
	self.approveMode = [[aDecoder decodeObjectForKey:kLeaveCurrentFlowNodeInfoApproveMode] integerValue];
	self.canUpdateCostRecord = [[aDecoder decodeObjectForKey:kLeaveCurrentFlowNodeInfoCanUpdateCostRecord] boolValue];
	self.costUpdateRule = [[aDecoder decodeObjectForKey:kLeaveCurrentFlowNodeInfoCostUpdateRule] integerValue];
	self.indexNum = [[aDecoder decodeObjectForKey:kLeaveCurrentFlowNodeInfoIndexNum] integerValue];
	self.isPaymentNode = [[aDecoder decodeObjectForKey:kLeaveCurrentFlowNodeInfoIsPaymentNode] boolValue];
	self.name = [aDecoder decodeObjectForKey:kLeaveCurrentFlowNodeInfoName];
	self.pickMode = [[aDecoder decodeObjectForKey:kLeaveCurrentFlowNodeInfoPickMode] integerValue];
	self.postList = [aDecoder decodeObjectForKey:kLeaveCurrentFlowNodeInfoPostList];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	LeaveCurrentFlowNodeInfo *copy = [LeaveCurrentFlowNodeInfo new];

	copy.idField = [self.idField copy];
	copy.accountList = [self.accountList copy];
	copy.approveMode = self.approveMode;
	copy.canUpdateCostRecord = self.canUpdateCostRecord;
	copy.costUpdateRule = self.costUpdateRule;
	copy.indexNum = self.indexNum;
	copy.isPaymentNode = self.isPaymentNode;
	copy.name = [self.name copy];
	copy.pickMode = self.pickMode;
	copy.postList = [self.postList copy];

	return copy;
}
@end