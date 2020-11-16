//
//  ExtraDataModel.m
//  AFNetworking
//
//  Created by qingping yi on 2020/9/10.
//

#import "ExtraDataModel.h"
#import "Extra_data.h"
#import "JYCSimpleToolClass.h"
#import "NSDate+Helper.h"
#import "NSDate+Extension.h"
#import "NSString+Time.h"
#import "NSString+base.h"
#import "MJExtension.h"

@implementation ExtraDataModel


+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"bizDistrictId":@"biz_district_id",
             @"checkTime":@"check_time",
             @"isOwner":@"is_owner",
             @"staffId":@"staff_id",
             @"otherChannel":@"other_channel",
             @"submitAt":@"submit_at",
             @"teamAccountMapId":@"team_account_map_id",
             @"teamId":@"team_id",
             @"teamName":@"team_name",
             @"gainPermission":@"permission_list",
             @"individualState":@"individual_state",
             @"merchantName":@"merchant_name",
             @"source":@"source"
             };
}
@end
