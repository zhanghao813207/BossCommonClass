//
//  EventExtraModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/9/2.
//

#import <Foundation/Foundation.h>
#import "ExamineOrderModel.h"
#import "ApplicationUrgeRecordModel.h"

@interface EventExtraModel : NSObject

#pragma mark -- boss助理 --- boss 通知 --- start

@property (nonatomic, assign) BOOL needUrgeInfo;

/**
 审批单ID
 */
@property (nonatomic, strong) NSString *oa_application_order_id;

/**
 审批记录ID
 */
@property (nonatomic, strong) NSString *oa_application_record_id;

@property (nonatomic, strong) NSString *oa_application_record_extra_id;


/**
 催办记录ID
 */
@property (nonatomic, strong) NSString *oa_urge_record_id;

/**
 审批单信息
 */
@property (nonatomic, strong, readonly) ExamineOrderModel *examineOrderInfo;

/**
 审批记录信息
 */
@property (nonatomic, strong, readonly) ExamineFlowRecordModel *flowRecordInfo;

/**
 催办记录信息
 */
@property (nonatomic, strong, readonly) ApplicationUrgeRecordModel *urgeRecordInfo;

/**
 数据请求来的需要更新
 */
@property (nonatomic, copy) void (^dateNeedUpdateBlock)(EventExtraModel *eventModel);

/**
 底部数据需要更新
 */
@property (nonatomic, copy) void (^footDateNeedUpdateBlock)(EventExtraModel *eventModel);

@property (nonatomic, assign, readonly) BOOL loadError;


/**
 数据请求失败
 */
@property (nonatomic, copy) void (^dateLoadErrorBlock)(void);

- (void)reloadDate;


#pragma mark -- boss助理 --- boss 通知 --- end

@end
