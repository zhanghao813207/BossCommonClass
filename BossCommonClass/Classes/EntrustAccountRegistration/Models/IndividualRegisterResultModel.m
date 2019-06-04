//
//  IndividualRegisterResultModel.m
//  BossCommonClass
//
//  Created by 张浩 on 2019/5/22.
//

#import "IndividualRegisterResultModel.h"

NSString *const kIndividualRegisterResultModelOk = @"ok";
NSString *const kIndividualRegisterResultModelUrl = @"register_url";

@interface IndividualRegisterResultModel ()
@end

@implementation IndividualRegisterResultModel

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kIndividualRegisterResultModelOk] isKindOfClass:[NSNull class]]){
        self.ok = [dictionary[kIndividualRegisterResultModelOk] boolValue];
    }
    
    if(![dictionary[kIndividualRegisterResultModelUrl] isKindOfClass:[NSNull class]]){
        self.registerUrl = dictionary[kIndividualRegisterResultModelUrl];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    dictionary[kIndividualRegisterResultModelOk] = @(self.ok);
    if(self.registerUrl != nil){
        dictionary[kIndividualRegisterResultModelUrl] = self.registerUrl;
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
    [aCoder encodeObject:@(self.ok) forKey:kIndividualRegisterResultModelOk];
    if(self.registerUrl != nil){
        [aCoder encodeObject:self.registerUrl forKey:kIndividualRegisterResultModelUrl];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.ok = [[aDecoder decodeObjectForKey:kIndividualRegisterResultModelOk] boolValue];
    self.registerUrl = [aDecoder decodeObjectForKey:kIndividualRegisterResultModelUrl];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    IndividualRegisterResultModel *copy = [IndividualRegisterResultModel new];
    
    copy.ok = self.ok;
    copy.registerUrl = [self.registerUrl copy];
    
    return copy;
}

@end
