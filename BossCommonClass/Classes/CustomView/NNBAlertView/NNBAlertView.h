//
//  NNBAlertView.h
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/10/9.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import <UIKit/UIKit.h>

// 根据 APPROVE_FLAGS（微仓／骑士交接单审核标记） 确定
typedef NS_ENUM(NSUInteger, NNBAlertViewType) {
    NNBAlertViewTypeWaitAudit   =    1, // 等待审核
    NNBAlertViewTypeThrough     =  100, // 审核通过
    NNBAlertViewTypeReject      = -100, // 驳回
};

@interface NNBAlertView : UIView

@property (nonatomic, copy) void (^refreshBlock)();

@property (nonatomic, copy) void (^countingBlock)();

@property (nonatomic, copy) void (^signBlock)();

- (instancetype)initWithFrame:(CGRect)frame AlertType:(NNBAlertViewType)alertType pickup:(BOOL)isPickUp;

- (void)show;

- (void)dismissWithCompletion:(void(^)(BOOL complete))completionBlcok;

@end
