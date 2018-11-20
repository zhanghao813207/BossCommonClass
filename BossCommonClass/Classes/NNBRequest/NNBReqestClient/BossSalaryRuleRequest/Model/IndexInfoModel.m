//
//  IndexInfoModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/7.
//

#import "IndexInfoModel.h"

@interface IndexInfoModel ()<NSCoding>

@end

@implementation IndexInfoModel
- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    DLog(@"undefineKey %@ %@", key, value);
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self._id forKey:@"_id"];
    [aCoder encodeObject:self.code forKey:@"code"];
    [aCoder encodeObject:self.created_at forKey:@"created_at"];
    [aCoder encodeObject:self.creator_id forKey:@"creator_id"];
    [aCoder encodeObject:self.definition forKey:@"definition"];
    [aCoder encodeObject:self.factor forKey:@"factor"];
    [aCoder encodeObject:self.fork_version forKey:@"fork_version"];
    [aCoder encodeObject:self.formula forKey:@"formula"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.plan_id forKey:@"plan_id"];
    [aCoder encodeObject:self.platform_code forKey:@"platform_code"];
    [aCoder encodeObject:self.source_domain forKey:@"source_domain"];
    [aCoder encodeObject:self.tags forKey:@"tags"];
    [aCoder encodeObject:self.updated_at forKey:@"updated_at"];
    [aCoder encodeObject:self.version forKey:@"version"];

    
    [aCoder encodeInteger:self.unit forKey:@"unit"];
    [aCoder encodeInteger:self.level forKey:@"level"];
    [aCoder encodeInteger:self.plan forKey:@"plan"];
    [aCoder encodeInteger:self.state forKey:@"state"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self._id =  [aDecoder decodeObjectForKey:@"_id"];
        self.code =  [aDecoder decodeObjectForKey:@"code"];
        self.created_at =  [aDecoder decodeObjectForKey:@"created_at"];
        self.creator_id =  [aDecoder decodeObjectForKey:@"creator_id"];
        self.definition =  [aDecoder decodeObjectForKey:@"definition"];
        self.factor =  [aDecoder decodeObjectForKey:@"factor"];
        self.fork_version =  [aDecoder decodeObjectForKey:@"fork_version"];
        self.formula =  [aDecoder decodeObjectForKey:@"formula"];
        self.name =  [aDecoder decodeObjectForKey:@"name"];
        self.plan_id =  [aDecoder decodeObjectForKey:@"plan_id"];
        self.platform_code =  [aDecoder decodeObjectForKey:@"platform_code"];
        self.source_domain =  [aDecoder decodeObjectForKey:@"source_domain"];
        self.tags =  [aDecoder decodeObjectForKey:@"tags"];
        self.updated_at =  [aDecoder decodeObjectForKey:@"updated_at"];
        self.version =  [aDecoder decodeObjectForKey:@"version"];

        self.unit =  [aDecoder decodeIntegerForKey:@"unit"];
        self.level = [aDecoder decodeIntegerForKey:@"level"];
        self.plan = [aDecoder decodeIntegerForKey:@"plan"];
        self.state = [aDecoder decodeIntegerForKey:@"state"];
    }
    return self;
}

- (NSString *)unitString
{
    if (!_unitString) {
        switch (self.unit) {
            case 1:
            {
                _unitString = @"单";
            }
                break;
            case 2:
            {
                _unitString = @"天";
            }
                break;
            case 3:
            {
                _unitString = @"kg";
            }
                break;
            case 4:
            {
                _unitString = @"km";
            }
                break;
            case 5:
            {
                _unitString = @"%";
            }
                break;
            case 6:
            {
                _unitString = @"星";
            }
                break;
            case 7:
            {
                _unitString = @"分钟";
            }
                break;
            case 8:
            {
                _unitString = @"元";
            }
                break;

            default:
            {
                _unitString = @"无";
            }
                break;
        }
    }
    return _unitString;

}


@end
