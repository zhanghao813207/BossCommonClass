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
    PositionIDAdministrator    = 1000, // 超级管理员
    PositionIDCOO              = 1001, // COO
    PositionIDOperationManager = 1002, // 运营管理
    PositionIDDirector         = 1003, // 总监
    PositionIDCityManger       = 1004, // 城市经理
    PositionIDCityAssistant    = 1005, // 城市助理
    PositionIDDispatcher       = 1006, // 调度
    PositionIDStationAgent     = 1007, // 站长
    PositionIDBuyer            = 1008, // 采购员
    PositionIDKnightCommander  = 1009, // 骑士长
    PositionIDKnight           = 1010, // 骑士
    PositionIDProjectDirector  = 1011, // 项目总监
    PositionIDPersonnel        = 1012, // 人事或人事总监
    PositionIDA1013            = 1013, // 张仕洋
    PositionIDA1014            = 1014, // 巴朕巴总
    PositionIDA1015            = 1015, // 总裁特别助理
    PositionIDA1016            = 1016, // 财务负责人
    PositionIDA1017            = 1017, // 财务经理
    PositionIDA1018            = 1018, // 出纳
    PositionIDA1019            = 1019, // 人事专员
    PositionIDCEO              = 1020, // CEO
    PositionIDA1021            = 1021, // 行政经理
    PositionIDA1022            = 1022, // 行政专员
    PositionIDA1023            = 1023, // 行政主管
    PositionIDA1024            = 1024, // 主体总监
};

typedef NS_ENUM(NSUInteger, MaterialStates) {
    MATERIAL_KNIGHT_RECEIPTING    = 9019,  // 待骑士确认收货
    MATERIAL_KNIGHT_RECEIPTED     = 9020,  // 确认收货
    MATERIAL_KNIGHT_REFUNDING     = 9017,  // 退货中
    MATERIAL_KNIGHT_REFUND_DOWN   = 9018,  // 退货完成
    MATERIAL_KNIGHT_REFUND_FAILED = 9022,  // 退货驳回
};

#endif /* BossEnumDefin_h */
