//
//  EventExtraModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/9/2.
//

#import <Foundation/Foundation.h>

@interface EventExtraModel : NSObject

#pragma mark -- boss助理 --- boss 通知 --- start
/**
 审批单ID
 */
@property (nonatomic, strong) NSString *oa_application_order_id;

/**
 审批记录ID
 */
@property (nonatomic, strong) NSString *oa_application_record_id;

/**
 催办记录ID
 */
@property (nonatomic, strong) NSString *oa_urge_record_id;

#pragma mark -- boss助理 --- boss 通知 --- end

@end
