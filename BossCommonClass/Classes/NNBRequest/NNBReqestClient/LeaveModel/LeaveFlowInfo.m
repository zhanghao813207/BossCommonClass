//
//	LeaveFlowInfo.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "LeaveFlowInfo.h"

NSString *const kLeaveFlowInfoIdField = @"_id";
NSString *const kLeaveFlowInfoBizType = @"biz_type";
NSString *const kLeaveFlowInfoCostCatalogScopeList = @"cost_catalog_scope_list";
NSString *const kLeaveFlowInfoExtraUiOptions = @"extra_ui_options";
NSString *const kLeaveFlowInfoIsPrivate = @"is_private";
NSString *const kLeaveFlowInfoName = @"name";
NSString *const kLeaveFlowInfoNodeList = @"node_list";
NSString *const kLeaveFlowInfoState = @"state";

@interface LeaveFlowInfo ()
@end
@implementation LeaveFlowInfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kLeaveFlowInfoIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kLeaveFlowInfoIdField];
	}	
	if(![dictionary[kLeaveFlowInfoBizType] isKindOfClass:[NSNull class]]){
		self.bizType = [dictionary[kLeaveFlowInfoBizType] integerValue];
	}

	if(![dictionary[kLeaveFlowInfoCostCatalogScopeList] isKindOfClass:[NSNull class]]){
		self.costCatalogScopeList = dictionary[kLeaveFlowInfoCostCatalogScopeList];
	}	
	if(![dictionary[kLeaveFlowInfoExtraUiOptions] isKindOfClass:[NSNull class]]){
		self.extraUiOptions = [[LeaveExtraUiOption alloc] initWithDictionary:dictionary[kLeaveFlowInfoExtraUiOptions]];
	}

	if(![dictionary[kLeaveFlowInfoIsPrivate] isKindOfClass:[NSNull class]]){
		self.isPrivate = [dictionary[kLeaveFlowInfoIsPrivate] boolValue];
	}

	if(![dictionary[kLeaveFlowInfoName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kLeaveFlowInfoName];
	}	
	if(dictionary[kLeaveFlowInfoNodeList] != nil && [dictionary[kLeaveFlowInfoNodeList] isKindOfClass:[NSArray class]]){
		NSArray * nodeListDictionaries = dictionary[kLeaveFlowInfoNodeList];
		NSMutableArray * nodeListItems = [NSMutableArray array];
		for(NSDictionary * nodeListDictionary in nodeListDictionaries){
			LeaveCurrentFlowNodeInfo * nodeListItem = [[LeaveCurrentFlowNodeInfo alloc] initWithDictionary:nodeListDictionary];
			[nodeListItems addObject:nodeListItem];
		}
		self.nodeList = nodeListItems;
	}
	if(![dictionary[kLeaveFlowInfoState] isKindOfClass:[NSNull class]]){
		self.state = [dictionary[kLeaveFlowInfoState] integerValue];
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
		dictionary[kLeaveFlowInfoIdField] = self.idField;
	}
	dictionary[kLeaveFlowInfoBizType] = @(self.bizType);
	if(self.costCatalogScopeList != nil){
		dictionary[kLeaveFlowInfoCostCatalogScopeList] = self.costCatalogScopeList;
	}
	if(self.extraUiOptions != nil){
		dictionary[kLeaveFlowInfoExtraUiOptions] = [self.extraUiOptions toDictionary];
	}
	dictionary[kLeaveFlowInfoIsPrivate] = @(self.isPrivate);
	if(self.name != nil){
		dictionary[kLeaveFlowInfoName] = self.name;
	}
	if(self.nodeList != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(LeaveCurrentFlowNodeInfo * nodeListElement in self.nodeList){
			[dictionaryElements addObject:[nodeListElement toDictionary]];
		}
		dictionary[kLeaveFlowInfoNodeList] = dictionaryElements;
	}
	dictionary[kLeaveFlowInfoState] = @(self.state);
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
		[aCoder encodeObject:self.idField forKey:kLeaveFlowInfoIdField];
	}
	[aCoder encodeObject:@(self.bizType) forKey:kLeaveFlowInfoBizType];	if(self.costCatalogScopeList != nil){
		[aCoder encodeObject:self.costCatalogScopeList forKey:kLeaveFlowInfoCostCatalogScopeList];
	}
	if(self.extraUiOptions != nil){
		[aCoder encodeObject:self.extraUiOptions forKey:kLeaveFlowInfoExtraUiOptions];
	}
	[aCoder encodeObject:@(self.isPrivate) forKey:kLeaveFlowInfoIsPrivate];	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kLeaveFlowInfoName];
	}
	if(self.nodeList != nil){
		[aCoder encodeObject:self.nodeList forKey:kLeaveFlowInfoNodeList];
	}
	[aCoder encodeObject:@(self.state) forKey:kLeaveFlowInfoState];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kLeaveFlowInfoIdField];
	self.bizType = [[aDecoder decodeObjectForKey:kLeaveFlowInfoBizType] integerValue];
	self.costCatalogScopeList = [aDecoder decodeObjectForKey:kLeaveFlowInfoCostCatalogScopeList];
	self.extraUiOptions = [aDecoder decodeObjectForKey:kLeaveFlowInfoExtraUiOptions];
	self.isPrivate = [[aDecoder decodeObjectForKey:kLeaveFlowInfoIsPrivate] boolValue];
	self.name = [aDecoder decodeObjectForKey:kLeaveFlowInfoName];
	self.nodeList = [aDecoder decodeObjectForKey:kLeaveFlowInfoNodeList];
	self.state = [[aDecoder decodeObjectForKey:kLeaveFlowInfoState] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	LeaveFlowInfo *copy = [LeaveFlowInfo new];

	copy.idField = [self.idField copy];
	copy.bizType = self.bizType;
	copy.costCatalogScopeList = [self.costCatalogScopeList copy];
	copy.extraUiOptions = [self.extraUiOptions copy];
	copy.isPrivate = self.isPrivate;
	copy.name = [self.name copy];
	copy.nodeList = [self.nodeList copy];
	copy.state = self.state;

	return copy;
}
@end