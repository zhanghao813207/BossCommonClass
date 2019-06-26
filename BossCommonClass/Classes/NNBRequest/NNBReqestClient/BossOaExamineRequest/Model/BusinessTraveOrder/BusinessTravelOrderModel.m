//
//	BusinessTravelOrderModel.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "BusinessTravelOrderModel.h"
#import "JYCSimpleToolClass.h"
#import "NSDate+Helper.h"

NSString *const kBusinessTravelOrderModelIdField = @"_id";
NSString *const kBusinessTravelOrderModelActualStartAt = @"actual_start_at";
NSString *const kBusinessTravelOrderModelApplyUserName = @"apply_user_name";
NSString *const kBusinessTravelOrderModelApplyUserPhone = @"apply_user_phone";
NSString *const kBusinessTravelOrderModelBizState = @"biz_state";
NSString *const kBusinessTravelOrderModelBizType = @"biz_type";
NSString *const kBusinessTravelOrderModelDeparture = @"departure";
NSString *const kBusinessTravelOrderModelDestination = @"destination";
NSString *const kBusinessTravelOrderModelExpectApplyDays = @"expect_apply_days";
NSString *const kBusinessTravelOrderModelExpectDoneAt = @"expect_done_at";
NSString *const kBusinessTravelOrderModelExpectStartAt = @"expect_start_at";
NSString *const kBusinessTravelOrderModelNote = @"note";
NSString *const kBusinessTravelOrderModelTogetherUserNames = @"together_user_names";
NSString *const kBusinessTravelOrderModelTransportKind = @"transport_kind";
NSString *const kBusinessTravelOrderModelWorkingPlan = @"working_plan";

@interface BusinessTravelOrderModel ()
@end
@implementation BusinessTravelOrderModel

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kBusinessTravelOrderModelIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kBusinessTravelOrderModelIdField];
	}	
	if(![dictionary[kBusinessTravelOrderModelActualStartAt] isKindOfClass:[NSNull class]]){
		self.actualStartAt = dictionary[kBusinessTravelOrderModelActualStartAt];
	}	
	if(![dictionary[kBusinessTravelOrderModelApplyUserName] isKindOfClass:[NSNull class]]){
		self.applyUserName = dictionary[kBusinessTravelOrderModelApplyUserName];
	}	
	if(![dictionary[kBusinessTravelOrderModelApplyUserPhone] isKindOfClass:[NSNull class]]){
		self.applyUserPhone = dictionary[kBusinessTravelOrderModelApplyUserPhone];
	}	
	if(![dictionary[kBusinessTravelOrderModelBizState] isKindOfClass:[NSNull class]]){
		self.bizState = [dictionary[kBusinessTravelOrderModelBizState] integerValue];
	}

	if(![dictionary[kBusinessTravelOrderModelBizType] isKindOfClass:[NSNull class]]){
		self.bizType = [dictionary[kBusinessTravelOrderModelBizType] integerValue];
	}

	if(![dictionary[kBusinessTravelOrderModelDeparture] isKindOfClass:[NSNull class]]){
		self.departure = [[Address alloc] initWithDictionary:dictionary[kBusinessTravelOrderModelDeparture]];
	}

	if(![dictionary[kBusinessTravelOrderModelDestination] isKindOfClass:[NSNull class]]){
		self.destination = [[Address alloc] initWithDictionary:dictionary[kBusinessTravelOrderModelDestination]];
	}

	if(![dictionary[kBusinessTravelOrderModelExpectApplyDays] isKindOfClass:[NSNull class]]){
		self.expectApplyDays = [dictionary[kBusinessTravelOrderModelExpectApplyDays] integerValue];
	}

	if(![dictionary[kBusinessTravelOrderModelExpectDoneAt] isKindOfClass:[NSNull class]]){
		self.expectDoneAt = dictionary[kBusinessTravelOrderModelExpectDoneAt];
	}	
	if(![dictionary[kBusinessTravelOrderModelExpectStartAt] isKindOfClass:[NSNull class]]){
		self.expectStartAt = dictionary[kBusinessTravelOrderModelExpectStartAt];
	}	
	if(![dictionary[kBusinessTravelOrderModelNote] isKindOfClass:[NSNull class]]){
		self.note = dictionary[kBusinessTravelOrderModelNote];
	}	
	if(![dictionary[kBusinessTravelOrderModelTogetherUserNames] isKindOfClass:[NSNull class]]){
		self.togetherUserNames = dictionary[kBusinessTravelOrderModelTogetherUserNames];
	}	
	if(![dictionary[kBusinessTravelOrderModelTransportKind] isKindOfClass:[NSNull class]]){
		self.transportKind = dictionary[kBusinessTravelOrderModelTransportKind];
	}	
	if(![dictionary[kBusinessTravelOrderModelWorkingPlan] isKindOfClass:[NSNull class]]){
		self.workingPlan = dictionary[kBusinessTravelOrderModelWorkingPlan];
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
		dictionary[kBusinessTravelOrderModelIdField] = self.idField;
	}
	if(self.actualStartAt != nil){
		dictionary[kBusinessTravelOrderModelActualStartAt] = self.actualStartAt;
	}
	if(self.applyUserName != nil){
		dictionary[kBusinessTravelOrderModelApplyUserName] = self.applyUserName;
	}
	if(self.applyUserPhone != nil){
		dictionary[kBusinessTravelOrderModelApplyUserPhone] = self.applyUserPhone;
	}
	dictionary[kBusinessTravelOrderModelBizState] = @(self.bizState);
	dictionary[kBusinessTravelOrderModelBizType] = @(self.bizType);
	if(self.departure != nil){
		dictionary[kBusinessTravelOrderModelDeparture] = [self.departure toDictionary];
	}
	if(self.destination != nil){
		dictionary[kBusinessTravelOrderModelDestination] = [self.destination toDictionary];
	}
	dictionary[kBusinessTravelOrderModelExpectApplyDays] = @(self.expectApplyDays);
	if(self.expectDoneAt != nil){
		dictionary[kBusinessTravelOrderModelExpectDoneAt] = self.expectDoneAt;
	}
	if(self.expectStartAt != nil){
		dictionary[kBusinessTravelOrderModelExpectStartAt] = self.expectStartAt;
	}
	if(self.note != nil){
		dictionary[kBusinessTravelOrderModelNote] = self.note;
	}
	if(self.togetherUserNames != nil){
		dictionary[kBusinessTravelOrderModelTogetherUserNames] = self.togetherUserNames;
	}
	if(self.transportKind != nil){
		dictionary[kBusinessTravelOrderModelTransportKind] = self.transportKind;
	}
	if(self.workingPlan != nil){
		dictionary[kBusinessTravelOrderModelWorkingPlan] = self.workingPlan;
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
		[aCoder encodeObject:self.idField forKey:kBusinessTravelOrderModelIdField];
	}
	if(self.actualStartAt != nil){
		[aCoder encodeObject:self.actualStartAt forKey:kBusinessTravelOrderModelActualStartAt];
	}
	if(self.applyUserName != nil){
		[aCoder encodeObject:self.applyUserName forKey:kBusinessTravelOrderModelApplyUserName];
	}
	if(self.applyUserPhone != nil){
		[aCoder encodeObject:self.applyUserPhone forKey:kBusinessTravelOrderModelApplyUserPhone];
	}
	[aCoder encodeObject:@(self.bizState) forKey:kBusinessTravelOrderModelBizState];	[aCoder encodeObject:@(self.bizType) forKey:kBusinessTravelOrderModelBizType];	if(self.departure != nil){
		[aCoder encodeObject:self.departure forKey:kBusinessTravelOrderModelDeparture];
	}
	if(self.destination != nil){
		[aCoder encodeObject:self.destination forKey:kBusinessTravelOrderModelDestination];
	}
	[aCoder encodeObject:@(self.expectApplyDays) forKey:kBusinessTravelOrderModelExpectApplyDays];	if(self.expectDoneAt != nil){
		[aCoder encodeObject:self.expectDoneAt forKey:kBusinessTravelOrderModelExpectDoneAt];
	}
	if(self.expectStartAt != nil){
		[aCoder encodeObject:self.expectStartAt forKey:kBusinessTravelOrderModelExpectStartAt];
	}
	if(self.note != nil){
		[aCoder encodeObject:self.note forKey:kBusinessTravelOrderModelNote];
	}
	if(self.togetherUserNames != nil){
		[aCoder encodeObject:self.togetherUserNames forKey:kBusinessTravelOrderModelTogetherUserNames];
	}
	if(self.transportKind != nil){
		[aCoder encodeObject:self.transportKind forKey:kBusinessTravelOrderModelTransportKind];
	}
	if(self.workingPlan != nil){
		[aCoder encodeObject:self.workingPlan forKey:kBusinessTravelOrderModelWorkingPlan];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:kBusinessTravelOrderModelIdField];
	self.actualStartAt = [aDecoder decodeObjectForKey:kBusinessTravelOrderModelActualStartAt];
	self.applyUserName = [aDecoder decodeObjectForKey:kBusinessTravelOrderModelApplyUserName];
	self.applyUserPhone = [aDecoder decodeObjectForKey:kBusinessTravelOrderModelApplyUserPhone];
	self.bizState = [[aDecoder decodeObjectForKey:kBusinessTravelOrderModelBizState] integerValue];
	self.bizType = [[aDecoder decodeObjectForKey:kBusinessTravelOrderModelBizType] integerValue];
	self.departure = [aDecoder decodeObjectForKey:kBusinessTravelOrderModelDeparture];
	self.destination = [aDecoder decodeObjectForKey:kBusinessTravelOrderModelDestination];
	self.expectApplyDays = [[aDecoder decodeObjectForKey:kBusinessTravelOrderModelExpectApplyDays] integerValue];
	self.expectDoneAt = [aDecoder decodeObjectForKey:kBusinessTravelOrderModelExpectDoneAt];
	self.expectStartAt = [aDecoder decodeObjectForKey:kBusinessTravelOrderModelExpectStartAt];
	self.note = [aDecoder decodeObjectForKey:kBusinessTravelOrderModelNote];
	self.togetherUserNames = [aDecoder decodeObjectForKey:kBusinessTravelOrderModelTogetherUserNames];
	self.transportKind = [aDecoder decodeObjectForKey:kBusinessTravelOrderModelTransportKind];
	self.workingPlan = [aDecoder decodeObjectForKey:kBusinessTravelOrderModelWorkingPlan];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	BusinessTravelOrderModel *copy = [BusinessTravelOrderModel new];

	copy.idField = [self.idField copy];
	copy.actualStartAt = [self.actualStartAt copy];
	copy.applyUserName = [self.applyUserName copy];
	copy.applyUserPhone = [self.applyUserPhone copy];
	copy.bizState = self.bizState;
	copy.bizType = self.bizType;
	copy.departure = [self.departure copy];
	copy.destination = [self.destination copy];
	copy.expectApplyDays = self.expectApplyDays;
	copy.expectDoneAt = [self.expectDoneAt copy];
	copy.expectStartAt = [self.expectStartAt copy];
	copy.note = [self.note copy];
	copy.togetherUserNames = [self.togetherUserNames copy];
	copy.transportKind = [self.transportKind copy];
	copy.workingPlan = [self.workingPlan copy];

	return copy;
}

#pragma mark - setter/getter

- (NSString *)bizTypeStr {
    NSString *typeStr = @"未知";
    switch (self.bizType) {
        case TravelApplyTypeOneway:
            typeStr = @"单程";
            break;
        case TravelApplyTypeRoundtrip:
            typeStr = @"往返";
            break;
        default:
            break;
    }
    return typeStr;
}

- (NSString *)transportKindStr {
    
    if(!self.transportKind){
        return @"无";
    }
    
    __block NSString *transportKindStr = @"";
    [self.transportKind enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *methodStr = [self getTravelApplyMethodStr:[obj integerValue]];
        if(idx == 0){
            transportKindStr = methodStr;
        }else{
            transportKindStr = [NSString stringWithFormat:@"%@、%@", transportKindStr, methodStr];
        }
    }];
    
    if(transportKindStr.length == 0){
        return @"无";
    }
    
    return transportKindStr;
}

- (NSString *)togetherUserNameStr {
    NSString *nameStr = @"无";
    if(self.togetherUserNames && self.togetherUserNames.count > 0){
        nameStr = [self.togetherUserNames componentsJoinedByString:@"、"];
    }
    return nameStr;
}

- (NSString *)expectStartAtStr {
    return [self getTimeStrToMinute:[JYCSimpleToolClass fastChangeToNormalTimeWithString:self.expectStartAt]];
}

- (NSString *)expectDoneAtStr {
    return [self getTimeStrToMinute:[JYCSimpleToolClass fastChangeToNormalTimeWithString:self.expectDoneAt]];
}

- (NSString *)noteStr {
    if(!self.note || self.note.length == 0){
        return @"无";
    }
    return self.note;
}

- (NSString *)workingPlanStr {
    if(!self.workingPlan || self.workingPlan.length == 0) {
        return @"无";
    }
    return self.workingPlan;
}

#pragma mark - private

- (NSString *) getTimeStrToMinute:(NSString *)timeStr {
    if(!timeStr){
        return @"";
    }
    NSDate *date = [NSDate dateFromString:timeStr withFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [date stringWithFormat:@"yyyy:MM:dd HH:mm"];
}

- (NSString *) getTravelApplyMethodStr:(TravelApplyMethod)travelApplyMethod {
    NSString *methodStr = @"未知";
    switch (travelApplyMethod) {
        case TravelApplyMethodTrain:
            methodStr = @"火车-普通列车";
            break;
        case TravelApplyMethodMotorTrainFirst:
            methodStr = @"火车-动车-一等座";
            break;
        case TravelApplyMethodMotorTrainSecond:
            methodStr = @"火车-动车-二等座";
            break;
        case TravelApplyMethodHignSpeedRailFirst:
            methodStr = @"火车-高铁-一等座";
            break;
        case TravelApplyMethodHignSpeedRailSecond:
            methodStr = @"火车-高铁-二等座";
            break;
        case TravelApplyMethodAircraftFirst:
            methodStr = @"飞机-头等舱";
            break;
        case TravelApplyMethodAircraftEconomy:
            methodStr = @"飞机-经济舱";
            break;
        case TravelApplyMethodBus:
            methodStr = @"客车";
            break;
        case TravelApplyMethodSelfDriving:
            methodStr = @"自驾";
            break;
        default:
            break;
    }
    return methodStr;
}
@end
