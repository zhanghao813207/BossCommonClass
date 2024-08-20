//
//  ConfigSalaryLoan.m
//  AFNetworking
//
//  Created by yjs on 2019/11/10.
//

#import "ConfigSalaryLoan.h"


NSString *const kconfigSalaryLoanUrl = @"url";

@implementation ConfigSalaryLoan

/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if ([dictionary isKindOfClass:[NSNull class]]) {
        return self;
    }
    if(![dictionary[kconfigSalaryLoanUrl] isKindOfClass:[NSNull class]]){
        self.url = dictionary[kconfigSalaryLoanUrl];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.url != nil){
        dictionary[kconfigSalaryLoanUrl] = self.url;
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
    if(self.url != nil){
        [aCoder encodeObject:self.url forKey:kconfigSalaryLoanUrl];
    }

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.url = [aDecoder decodeObjectForKey:kconfigSalaryLoanUrl];
    return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    ConfigSalaryLoan *copy = [ConfigSalaryLoan new];

    copy.url = [self.url copy];

    return copy;
}
@end
