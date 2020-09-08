//
//  Extra_data.m
//  AFNetworking
//
//  Created by qingping yi on 2020/9/8.
//

#import "Extra_data.h"

NSString *const kExtraDataModelBizDistrictId = @"biz_district_id";
NSString *const kExtraDataModelCheckTime = @"check_time";
NSString *const kExtraDataModelDarkModeHeadImg = @"dark_mode_head_img";
NSString *const kExtraDataModelGainPermission = @"gain_permission";
NSString *const kExtraDataModelIsOwner = @"is_owner";
NSString *const kExtraDataModelMerchantName = @"merchant_name";
NSString *const kExtraDataModelOtherChannel = @"other_channel";
NSString *const kExtraDataModelPushMessageType = @"push_message_type";
NSString *const kExtraDataModelQrcode = @"qrcode";
NSString *const kExtraDataModelReason = @"reason";
NSString *const kExtraDataModelStaffId = @"staff_id";
NSString *const kExtraDataModelState = @"state";
NSString *const kExtraDataModelSubmitAt = @"submit_at";
NSString *const kExtraDataModelTeamAccountMapId = @"team_account_map_id";
NSString *const kExtraDataModelTeamId = @"team_id";
NSString *const kExtraDataModelTeamName = @"team_name";

@interface Extra_data ()
@end
@implementation Extra_data




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kExtraDataModelBizDistrictId] isKindOfClass:[NSNull class]]){
        self.bizDistrictId = dictionary[kExtraDataModelBizDistrictId];
    }
    if(![dictionary[kExtraDataModelCheckTime] isKindOfClass:[NSNull class]]){
        self.checkTime = dictionary[kExtraDataModelCheckTime];
    }
    if(![dictionary[kExtraDataModelDarkModeHeadImg] isKindOfClass:[NSNull class]]){
        self.darkModeHeadImg = dictionary[kExtraDataModelDarkModeHeadImg];
    }
    if(![dictionary[kExtraDataModelGainPermission] isKindOfClass:[NSNull class]]){
        self.gainPermission = [dictionary[kExtraDataModelGainPermission] integerValue];
    }

    if(![dictionary[kExtraDataModelIsOwner] isKindOfClass:[NSNull class]]){
        self.isOwner = [dictionary[kExtraDataModelIsOwner] boolValue];
    }

    if(![dictionary[kExtraDataModelMerchantName] isKindOfClass:[NSNull class]]){
        self.merchantName = dictionary[kExtraDataModelMerchantName];
    }
    if(![dictionary[kExtraDataModelOtherChannel] isKindOfClass:[NSNull class]]){
        self.otherChannel = [dictionary[kExtraDataModelOtherChannel] boolValue];
    }

    if(![dictionary[kExtraDataModelPushMessageType] isKindOfClass:[NSNull class]]){
        self.pushMessageType = dictionary[kExtraDataModelPushMessageType];
    }
    if(![dictionary[kExtraDataModelQrcode] isKindOfClass:[NSNull class]]){
        self.qrcode = dictionary[kExtraDataModelQrcode];
    }
    if(![dictionary[kExtraDataModelReason] isKindOfClass:[NSNull class]]){
        self.reason = dictionary[kExtraDataModelReason];
    }
    if(![dictionary[kExtraDataModelStaffId] isKindOfClass:[NSNull class]]){
        self.staffId = dictionary[kExtraDataModelStaffId];
    }
    if(![dictionary[kExtraDataModelState] isKindOfClass:[NSNull class]]){
        self.state = [dictionary[kExtraDataModelState] integerValue];
    }

    if(![dictionary[kExtraDataModelSubmitAt] isKindOfClass:[NSNull class]]){
        self.submitAt = dictionary[kExtraDataModelSubmitAt];
    }
    if(![dictionary[kExtraDataModelTeamAccountMapId] isKindOfClass:[NSNull class]]){
        self.teamAccountMapId = dictionary[kExtraDataModelTeamAccountMapId];
    }
    if(![dictionary[kExtraDataModelTeamId] isKindOfClass:[NSNull class]]){
        self.teamId = dictionary[kExtraDataModelTeamId];
    }
    if(![dictionary[kExtraDataModelTeamName] isKindOfClass:[NSNull class]]){
        self.teamName = dictionary[kExtraDataModelTeamName];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.bizDistrictId != nil){
        dictionary[kExtraDataModelBizDistrictId] = self.bizDistrictId;
    }
    if(self.checkTime != nil){
        dictionary[kExtraDataModelCheckTime] = self.checkTime;
    }
    if(self.darkModeHeadImg != nil){
        dictionary[kExtraDataModelDarkModeHeadImg] = self.darkModeHeadImg;
    }
    dictionary[kExtraDataModelGainPermission] = @(self.gainPermission);
    dictionary[kExtraDataModelIsOwner] = @(self.isOwner);
    if(self.merchantName != nil){
        dictionary[kExtraDataModelMerchantName] = self.merchantName;
    }
    dictionary[kExtraDataModelOtherChannel] = @(self.otherChannel);
    if(self.pushMessageType != nil){
        dictionary[kExtraDataModelPushMessageType] = self.pushMessageType;
    }
    if(self.qrcode != nil){
        dictionary[kExtraDataModelQrcode] = self.qrcode;
    }
    if(self.reason != nil){
        dictionary[kExtraDataModelReason] = self.reason;
    }
    if(self.staffId != nil){
        dictionary[kExtraDataModelStaffId] = self.staffId;
    }
    dictionary[kExtraDataModelState] = @(self.state);
    if(self.submitAt != nil){
        dictionary[kExtraDataModelSubmitAt] = self.submitAt;
    }
    if(self.teamAccountMapId != nil){
        dictionary[kExtraDataModelTeamAccountMapId] = self.teamAccountMapId;
    }
    if(self.teamId != nil){
        dictionary[kExtraDataModelTeamId] = self.teamId;
    }
    if(self.teamName != nil){
        dictionary[kExtraDataModelTeamName] = self.teamName;
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
    if(self.bizDistrictId != nil){
        [aCoder encodeObject:self.bizDistrictId forKey:kExtraDataModelBizDistrictId];
    }
    if(self.checkTime != nil){
        [aCoder encodeObject:self.checkTime forKey:kExtraDataModelCheckTime];
    }
    if(self.darkModeHeadImg != nil){
        [aCoder encodeObject:self.darkModeHeadImg forKey:kExtraDataModelDarkModeHeadImg];
    }
    [aCoder encodeObject:@(self.gainPermission) forKey:kExtraDataModelGainPermission];    [aCoder encodeObject:@(self.isOwner) forKey:kExtraDataModelIsOwner];    if(self.merchantName != nil){
        [aCoder encodeObject:self.merchantName forKey:kExtraDataModelMerchantName];
    }
    [aCoder encodeObject:@(self.otherChannel) forKey:kExtraDataModelOtherChannel];    if(self.pushMessageType != nil){
        [aCoder encodeObject:self.pushMessageType forKey:kExtraDataModelPushMessageType];
    }
    if(self.qrcode != nil){
        [aCoder encodeObject:self.qrcode forKey:kExtraDataModelQrcode];
    }
    if(self.reason != nil){
        [aCoder encodeObject:self.reason forKey:kExtraDataModelReason];
    }
    if(self.staffId != nil){
        [aCoder encodeObject:self.staffId forKey:kExtraDataModelStaffId];
    }
    [aCoder encodeObject:@(self.state) forKey:kExtraDataModelState];    if(self.submitAt != nil){
        [aCoder encodeObject:self.submitAt forKey:kExtraDataModelSubmitAt];
    }
    if(self.teamAccountMapId != nil){
        [aCoder encodeObject:self.teamAccountMapId forKey:kExtraDataModelTeamAccountMapId];
    }
    if(self.teamId != nil){
        [aCoder encodeObject:self.teamId forKey:kExtraDataModelTeamId];
    }
    if(self.teamName != nil){
        [aCoder encodeObject:self.teamName forKey:kExtraDataModelTeamName];
    }

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.bizDistrictId = [aDecoder decodeObjectForKey:kExtraDataModelBizDistrictId];
    self.checkTime = [aDecoder decodeObjectForKey:kExtraDataModelCheckTime];
    self.darkModeHeadImg = [aDecoder decodeObjectForKey:kExtraDataModelDarkModeHeadImg];
    self.gainPermission = [[aDecoder decodeObjectForKey:kExtraDataModelGainPermission] integerValue];
    self.isOwner = [[aDecoder decodeObjectForKey:kExtraDataModelIsOwner] boolValue];
    self.merchantName = [aDecoder decodeObjectForKey:kExtraDataModelMerchantName];
    self.otherChannel = [[aDecoder decodeObjectForKey:kExtraDataModelOtherChannel] boolValue];
    self.pushMessageType = [aDecoder decodeObjectForKey:kExtraDataModelPushMessageType];
    self.qrcode = [aDecoder decodeObjectForKey:kExtraDataModelQrcode];
    self.reason = [aDecoder decodeObjectForKey:kExtraDataModelReason];
    self.staffId = [aDecoder decodeObjectForKey:kExtraDataModelStaffId];
    self.state = [[aDecoder decodeObjectForKey:kExtraDataModelState] integerValue];
    self.submitAt = [aDecoder decodeObjectForKey:kExtraDataModelSubmitAt];
    self.teamAccountMapId = [aDecoder decodeObjectForKey:kExtraDataModelTeamAccountMapId];
    self.teamId = [aDecoder decodeObjectForKey:kExtraDataModelTeamId];
    self.teamName = [aDecoder decodeObjectForKey:kExtraDataModelTeamName];
    return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    Extra_data *copy = [Extra_data new];

    copy.bizDistrictId = [self.bizDistrictId copy];
    copy.checkTime = [self.checkTime copy];
    copy.darkModeHeadImg = [self.darkModeHeadImg copy];
    copy.gainPermission = self.gainPermission;
    copy.isOwner = self.isOwner;
    copy.merchantName = [self.merchantName copy];
    copy.otherChannel = self.otherChannel;
    copy.pushMessageType = [self.pushMessageType copy];
    copy.qrcode = [self.qrcode copy];
    copy.reason = [self.reason copy];
    copy.staffId = [self.staffId copy];
    copy.state = self.state;
    copy.submitAt = [self.submitAt copy];
    copy.teamAccountMapId = [self.teamAccountMapId copy];
    copy.teamId = [self.teamId copy];
    copy.teamName = [self.teamName copy];

    return copy;
}
@end
