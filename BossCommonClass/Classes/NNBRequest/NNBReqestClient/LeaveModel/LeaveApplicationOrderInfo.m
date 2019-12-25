//
//	LeaveApplicationOrderInfo.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "LeaveApplicationOrderInfo.h"

NSString *const kLeaveApplicationOrderInfoIdField = @"_id";
NSString *const kLeaveApplicationOrderInfoApplicationOrderType = @"application_order_type";
NSString *const kLeaveApplicationOrderInfoBizState = @"biz_state";
NSString *const kLeaveApplicationOrderInfoCurrentFlowNodeInfo = @"current_flow_node_info";
NSString *const kLeaveApplicationOrderInfoFlowInfo = @"flow_info";
NSString *const kLeaveApplicationOrderInfoState = @"state";
NSString *const kLeaveApplicationOrderInfoSubmitAt = @"submit_at";
NSString *const kLeaveApplicationOrderInfoTotalMoney = @"total_money";

@interface LeaveApplicationOrderInfo ()
@end
@implementation LeaveApplicationOrderInfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kLeaveApplicationOrderInfoIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kLeaveApplicationOrderInfoIdField];
	}	
	if(![dictionary[kLeaveApplicationOrderInfoApplicationOrderType] isKindOfClass:[NSNull class]]){
		self.applicationOrderType = [dictionary[kLeaveApplicationOrderInfoApplicationOrderType] integerValue];
	}

	if(![dictionary[kLeaveApplicationOrderInfoBizState] isKindOfClass:[NSNull class]]){
		self.bizState = [dictionary[kLeaveApplicationOrderInfoBizState] integerValue];
	}

	if(![dictionary[kLeaveApplicationOrderInfoCurrentFlowNodeInfo] isKindOfClass:[NSNull class]]){
		self.currentFlowNodeInfo = [[LeaveCurrentFlowNodeInfo alloc] initWithDictionary:dictionary[kLeaveApplicationOrderInfoCurrentFlowNodeInfo]];
	}

	if(![dictionary[kLeaveApplicationOrderInfoFlowInfo] isKindOfClass:[NSNull class]]){
		self.flowInfo = [[LeaveFlowInfo alloc] initWithDictionary:dictionary[kLeaveApplicationOrderInfoFlowInfo]];
	}

	if(![dictionary[kLeaveApplicationOrderInfoState] isKindOfClass:[NSNull class]]){
		self.state = [dictionary[kLeaveApplicationOrderInfoState] integerValue];
	}

	if(![dictionary[kLeaveApplicationOrderInfoSubmitAt] isKindOfClass:[NSNull class]]){
		self.submitAt = dictionary[kLeaveApplicationOrderInfoSubmitAt];
	}	
	if(![dictionary[kLeaveApplicationOrderInfoTotalMoney] isKindOfClass:[NSNull class]]){
		self.totalMoney = [dictionary[kLeaveApplicationOrderInfoTotalMoney] integerValue];
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
		dictionary[kLeaveApplicationOrderInfoIdField] = self.idField;
	}
	dictionary[kLeaveApplicationOrderInfoApplicationOrderType] = @(self.applicationOrderType);
	dictionary[kLeaveApplicationOrderInfoBizState] = @(self.bizState);
	if(self.currentFlowNodeInfo != nil){
		dictionary[kLeaveApplicationOrderInfoCurrentFlowNodeInfo] = [self.currentFlowNodeInfo toDictionary];
	}
	if(self.flowInfo != nil){
		dictionary[kLeaveApplicationOrderInfoFlowInfo] = [self.flowInfo toDictionary];
	}
	dictionary[kLeaveApplicationOrderInfoState] = @(self.state);
	if(self.submitAt != nil){
		dictionary[kLeaveApplicationOrderInfoSubmitAt] = self.submitAt;
	}
	dictionary[kLeaveApplicationOrderInfoTotalMoney] = @(self.totalMoney);
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
		[aCoder encodeObject:self.idField forKey:kLeaveApplicationOrderInfoIdField];
	}
	[aCoder encodeObject:@(self.applicationOrderType) forKey:kLeaveApplicationOrderInfoApplicationOrderType];	[aCoder encodeObject:@(self.bizState) forKey:kLeaveApplicationOrderInfoBizState];	if(self.currentFlowNodeInfo != nil){
		[aCoder encodeObject:self.currentFlowNodeInfo forKey:kLeaveApplicationOrderInfoCurrentFlowNodeInfo];
	}
	if(self.flowInfo != nil){
		[aCoder encodeObject:self.flowInfo forKey:kLeaveApplicationOrderInfoFlowInfo];
	}
	[aCoder encodeObject:@(self.state) forKey:kLeaveApplicationOrderInfoState];	if(self.submitAt != nil){
		[aCoder encodeObject:self.submitAt forKey:kLeaveApplicationOrderInfoSubmitAt];
	}
	[aCoder encodeObject:@(self.totalMoney) forKey:kLeaveApplicationOrderInfoTotalMoney];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kLeaveApplicationOrderInfoIdField];
	self.applicationOrderType = [[aDecoder decodeObjectForKey:kLeaveApplicationOrderInfoApplicationOrderType] integerValue];
	self.bizState = [[aDecoder decodeObjectForKey:kLeaveApplicationOrderInfoBizState] integerValue];
	self.currentFlowNodeInfo = [aDecoder decodeObjectForKey:kLeaveApplicationOrderInfoCurrentFlowNodeInfo];
	self.flowInfo = [aDecoder decodeObjectForKey:kLeaveApplicationOrderInfoFlowInfo];
	self.state = [[aDecoder decodeObjectForKey:kLeaveApplicationOrderInfoState] integerValue];
	self.submitAt = [aDecoder decodeObjectForKey:kLeaveApplicationOrderInfoSubmitAt];
	self.totalMoney = [[aDecoder decodeObjectForKey:kLeaveApplicationOrderInfoTotalMoney] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	LeaveApplicationOrderInfo *copy = [LeaveApplicationOrderInfo new];

	copy.idField = [self.idField copy];
	copy.applicationOrderType = self.applicationOrderType;
	copy.bizState = self.bizState;
	copy.currentFlowNodeInfo = [self.currentFlowNodeInfo copy];
	copy.flowInfo = [self.flowInfo copy];
	copy.state = self.state;
	copy.submitAt = [self.submitAt copy];
	copy.totalMoney = self.totalMoney;

	return copy;
}
@end