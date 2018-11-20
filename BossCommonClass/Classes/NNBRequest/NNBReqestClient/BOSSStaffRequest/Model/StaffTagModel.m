//
//  StaffTagModel.m
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/9.
//

#import "StaffTagModel.h"
#import "BossBasicDefine.h"

@interface StaffTagModel ()<NSCoding>

@end

@implementation StaffTagModel

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
    [aCoder encodeObject:self.biz_district_id forKey:@"biz_district_id"];
    [aCoder encodeObject:self.city_code forKey:@"city_code"];
    [aCoder encodeObject:self.created_at forKey:@"created_at"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.operator_id forKey:@"operator_id"];
    [aCoder encodeObject:self.platform_code forKey:@"platform_code"];
    [aCoder encodeObject:self.supplier_id forKey:@"supplier_id"];
    [aCoder encodeObject:self.updated_at forKey:@"updated_at"];
    [aCoder encodeInteger:self.staff_counter forKey:@"staff_counter"];
    [aCoder encodeInteger:self.state forKey:@"state"];
    [aCoder encodeInteger:self.tag_type forKey:@"tag_type"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self._id = [aDecoder decodeObjectForKey:@"_id"];
        self.biz_district_id = [aDecoder decodeObjectForKey:@"biz_district_id"];
        self.city_code = [aDecoder decodeObjectForKey:@"city_code"];
        self.created_at = [aDecoder decodeObjectForKey:@"created_at"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.operator_id = [aDecoder decodeObjectForKey:@"operator_id"];
        self.platform_code = [aDecoder decodeObjectForKey:@"platform_code"];
        self.supplier_id = [aDecoder decodeObjectForKey:@"supplier_id"];
        self.updated_at = [aDecoder decodeObjectForKey:@"updated_at"];
        self.staff_counter = [aDecoder decodeIntegerForKey:@"staff_counter"];
        self.state = [aDecoder decodeIntegerForKey:@"state"];
        self.tag_type = [aDecoder decodeIntegerForKey:@"tag_type"];

    }
    return self;
}


@end
