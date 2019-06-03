//
//  IndividualRegisterStateModel.m
//  BossCommonClass
//
//  Created by 张浩 on 2019/5/22.
//

#import "IndividualRegisterStateModel.h"

NSString *const kIndividualRegisterStateModelReason = @"reason";
NSString *const kIndividualRegisterStateModelSocialCreditCode = @"social_credit_code";
NSString *const kIndividualRegisterStateModelState = @"state";

@interface IndividualRegisterStateModel ()
@end

@implementation IndividualRegisterStateModel

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */
-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kIndividualRegisterStateModelReason] isKindOfClass:[NSNull class]]){
        self.reason = [NSString stringWithFormat:@"%@",dictionary[kIndividualRegisterStateModelReason]];
        
    }
    if(![dictionary[kIndividualRegisterStateModelSocialCreditCode] isKindOfClass:[NSNull class]]){
        self.socialCreditCode = dictionary[kIndividualRegisterStateModelSocialCreditCode];
    }
    if(![dictionary[kIndividualRegisterStateModelState] isKindOfClass:[NSNull class]]){
        self.state = [dictionary[kIndividualRegisterStateModelState] integerValue];
    }
    
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.reason != nil){
        dictionary[kIndividualRegisterStateModelReason] = self.reason;
    }
    if(self.socialCreditCode != nil){
        dictionary[kIndividualRegisterStateModelSocialCreditCode] = self.socialCreditCode;
    }
    dictionary[kIndividualRegisterStateModelState] = @(self.state);
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
    if(self.reason != nil){
        [aCoder encodeObject:self.reason forKey:kIndividualRegisterStateModelReason];
    }
    if(self.socialCreditCode != nil){
        [aCoder encodeObject:self.socialCreditCode forKey:kIndividualRegisterStateModelSocialCreditCode];
    }
    [aCoder encodeObject:@(self.state) forKey:kIndividualRegisterStateModelState];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.reason = [aDecoder decodeObjectForKey:kIndividualRegisterStateModelReason];
    self.socialCreditCode = [aDecoder decodeObjectForKey:kIndividualRegisterStateModelSocialCreditCode];
    self.state = [[aDecoder decodeObjectForKey:kIndividualRegisterStateModelState] integerValue];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    IndividualRegisterStateModel *copy = [IndividualRegisterStateModel new];
    
    copy.reason = [self.reason copy];
    copy.socialCreditCode = [self.socialCreditCode copy];
    copy.state = self.state;
    
    return copy;
}
@end
