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
#import "MJExtension.h"

@implementation ExtraDataModel

- (NSString *)showReviewTime{
    NSString *normalTime = [JYCSimpleToolClass fastChangeToNormalTimeWithString:self.checkTime];
    NSDate *normalDate = [NSDate dateFromString:normalTime];
    NSString *tempDate = [NSDate stringFromDate:normalDate withFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [tempDate getTimeStr:@""];
}

- (NSString *)showSubmitTime{
    NSString *normalTime = [JYCSimpleToolClass fastChangeToNormalTimeWithString:self.submitAt];
    NSDate *normalDate = [NSDate dateFromString:normalTime];
    NSString *tempDate = [NSDate stringFromDate:normalDate withFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [tempDate getTimeStr:@""];
}

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
             @"gainPermission":@"permission_list"
             };
}
@end
