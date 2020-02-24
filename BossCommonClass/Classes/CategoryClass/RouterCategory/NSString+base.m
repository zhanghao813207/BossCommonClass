//
//  NSString+base.m
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/8/22.
//

#import "NSString+base.h"
#import "BossBasicDefine.h"

@implementation NSString (base)

+ (NSString *)isEmptyString:(NSString *)str{
    NSLog(@"%@", self);
    if (str.length > 0 && str != nil) {
        return str;
    } else {
        return @"";
    }
}

+ (BOOL)isEmptyStringWithString:(NSString *)str{
    
    if (str == nil || str == NULL || [str isEqualToString:@""] || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@"(null)"] || str.length == 0){
        return YES;
    }
    return NO;
}

// 配置列表状态图片
+(NSString *)configListImageWithState:(NSInteger)state withStateLeavingType:(NSInteger)stateLeavingType{
    switch (state) {
        case LeaveStatusWaitApproval:
        { //审批中
            return @"approvalingList";
        }
          break;
        case LeaveStatusApprovalDone:
         { //审批完成  -- 已同意 /请假中
             if (stateLeavingType == 60){
                 return @"inLeaveList";
             }
            return @"agreeList";
         }
          break;
        case LeaveStatusReportApproval:
        {//销假审批中 -- 销假中
            return @"backAfterLeaveList";
        }
          break;
            
        case LeaveStatusReportDone:
        { //销假完成  -- 已完成
             return @"alreadySoldOffList";
        }
            break;
            
        case LeaveStatusApprovalReject:
        {
              //审批驳回  -- 已驳回
          return @"rejectedList";
         }
            break;
            
        case LeaveStatusClose:
        {//撤销关闭  -- 已撤销
            return @"selfRevokedList";
        }
           break;
       
        default:
            return @"approvalingList";
            break;
    }
}

// 配置详情状态图片
+(NSString *)configImageWithState:(NSInteger)state withStateLeavingType:(NSInteger)stateLeavingType{
    switch (state) {
        case LeaveStatusWaitApproval:
        { //审批中
            return @"approvaling";
        }
          break;
        case LeaveStatusApprovalDone:
         { //审批完成  -- 已同意 /请假中
             if (stateLeavingType == 60){
                 return @"inLeave";
             }
            return @"agreed";
         }
          break;
        case LeaveStatusReportApproval:
        {//销假审批中 -- 销假中
            return @"backAfterLeave";
        }
          break;
            
        case LeaveStatusReportDone:
        { //销假完成  -- 已完成
             return @"alreadySoldOff";
        }
            break;
            
        case LeaveStatusApprovalReject:
        {
              //审批驳回  -- 已驳回
          return @"rejected";
         }
            break;
            
        case LeaveStatusClose:
        {//撤销关闭  -- 已撤销
            return @"selfRevoked";
        }
           break;
       
        default:
            return @"approvaling";
            break;
    }
}

@end
