//
//  BossEnumDefin.h
//  Pods
//
//  Created by 贾远潮 on 2018/3/12.
//

#ifndef BossEnumDefin_h
#define BossEnumDefin_h

#import "OperationTypes.h"

typedef NS_ENUM(NSUInteger, NNBSendSMSType) {
    NNBSendSMSTypeLogin              = 1, // 登录
    NNBSendSMSTypeRegist             = 2, // 注册
    NNBSendSMSTypeChangePhoneNumber  = 3, // 修改手机号
};

typedef NS_ENUM(NSUInteger, GenderIDs) {
    GenderIDUnknown   =  0, // 未知
    GenderIDMan       = 10, // 男人
    GenderIDWoman     = 20, // 女人
};

typedef NS_ENUM(NSInteger, StaffStates) {
    StaffStateOnTheJob      =  50, // 在职
    StaffStateLeaveToReview =   1, // 离职待审核
    StaffStateLeave         = -50, // 离职
};

typedef NS_ENUM(NSUInteger, FlowStates) {
    FlowStateKnightWaitConfirm   = 9010, // 待骑士确认收货
    FlowStateKnightConfirmed     = 9011, // 骑士已确认收货
    FlowStateRefundWaitReview    = 9013, // 退货申请待审核
    FlowStateRefundReviewed      = 9014, // 退货申请审核通过
    FlowStateRefundNoReviewed    = 9015, // 退货申请审核不通过
};

typedef NS_ENUM(NSUInteger, PaymentTypes) {
    PaymentTypeOnce    = 301, // 一次性
    PaymentTypeMonth   = 302, // 月付
    PaymentTypeDeposit = 303, // 押金
};

typedef NS_ENUM(NSUInteger, PositionID) {
    PositionIDDirector        = 2003, // 总监
    PositionIDCityManger      = 2004, // 城市经理
    PositionIDCityAssistant   = 2005, // 城市助理
    PositionIDDispatcher      = 2006, // 调度
    PositionIDStationAgent    = 2007, // 站长
    PositionIDKnightCommander = 2008, // 骑士长
    PositionIDKnight          = 2009, // 骑士
};

typedef NS_ENUM(NSUInteger, MaterialStates) {
    MATERIAL_KNIGHT_RECEIPTING    = 9019,  // 待骑士确认收货
    MATERIAL_KNIGHT_RECEIPTED     = 9020,  // 确认收货
    MATERIAL_KNIGHT_REFUNDING     = 9017,  // 退货中
    MATERIAL_KNIGHT_REFUND_DOWN   = 9018,  // 退货完成
    MATERIAL_KNIGHT_REFUND_FAILED = 9022,  // 退货驳回
};

#endif /* BossEnumDefin_h */
