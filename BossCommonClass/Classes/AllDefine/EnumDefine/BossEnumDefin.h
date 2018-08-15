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

typedef NS_ENUM(NSUInteger, MOBILE_EXAMINE_TYPES) {
    MOBILE_WAIT_EXAMINE         = 1,  // 待我审批的
    
    MOBILE_PUT_EXAMINE_ALL      = 2,  // 我提报的（全部）
    MOBILE_PUT_EXAMINE_PRESENT  = 3,  // 我提报的(审核中)
    MOBILE_PUT_EXAMINE_SUCCEED  = 4,  // 我提报的(已通过)
    MOBILE_PUT_EXAMINE_FAIL     = 5,  // 我提报的(已驳回)
    
    MOBILE_PASS_EXAMINE_ALL     = 6,  // 我经手的(全部)
    MOBILE_PASS_EXAMINE_PRESENT = 7,  // 我经手的(审批中)
    MOBILE_PASS_EXAMINE_SUCCEED = 8,  // 我经手的(已通过)
    MOBILE_PASS_EXAMINE_FAIL    = 9,  // 我经手的(已驳回),
};

// 审批单整体状态
typedef NS_ENUM(NSInteger, OA_EXAMINE_STATE) {
    OA_EXAMEINE_DELETE   = -2,  // 删除
    OA_EXAMEINE_FAILT    = -1,  // 驳回、不通过
    OA_EXAMEINE_INIT     =  0,  // 待提交
    OA_EXAMEINE_WAIT     =  1,  // 待审核，审核中
    OA_EXAMEINE_SUCCESS  =  2,  // 通过, 所有审批人都通过
};
// 审批节点状态
typedef NS_ENUM(NSInteger, OA_EXAMINE_NODE_STATE) {
    OA_EXAMEINEFLOW_FAILT    = -1,  // 驳回、不通过
    OA_EXAMEINEFLOW_INIT     =  0,  // 审批中
    OA_EXAMEINEFLOW_SUCCESS  =  1,  // 通过
    OA_EXAMINEFLOW_SUBMIT    =  2,  // 提报
};

typedef NS_ENUM(NSUInteger, BOSS_MODULE_TYPE) {
    BOSS_MODULE_TYPE_OA  = 1, // 费用模块
};

//# boss助理(费用模块)
typedef NS_ENUM(NSUInteger, BOSS_ASSISTANT_TYPE) {
    BOSS_ASSISTANT_URGE = 101,  // 助理类型为催办
    BOSS_ASSISTANT_WAIT =  99,  // 助理类型为代办
};

// 费用类型(枚举跟后端一致，名字那么low不是我起的)
typedef NS_ENUM(NSUInteger, OS_COSTCLASS_TYPE) {
    OA_TEMPLATE_ONE          = 1, // 报销
    OA_TEMPLATE_TWO          = 2, // 租房
    OS_COSTCLASS_SALARY      = 3, // 薪资
    OS_COSTCLASS_SUBJOIN     = 4, // 租房、中介费、押金(租房)
    OS_COSTCLASS_AGENCY      = 5, // 租房、中介费、押金(中介费)
    OS_COSTCLASS_PLEDGE      = 6, // 租房、中介费、押金(押金)
};

typedef NS_ENUM(NSInteger, OA_HOUSE_STATES) {
    OA_HOUSE_STATE_DEL      = -2,  // 删除
    OA_HOUSE_STATE_STOP     = -1,  // 断租，算违约
    OA_HOUSE_STATE_EXP      =  0,  // 退租，合同到期，合法解除
    OA_HOUSE_STATE_NEW      =  1,  // 新租
    OA_HOUSE_STATE_KEEP     =  2,  // 续租
    OA_HOUSE_STATE_DOUKEEP  =  3,  // 续签
    OA_HOUSE_STATE_NEW_LOCK =  4,  // 已续租（不显示续租按钮，但是前端还是现实新租）,
};

#endif /* BossEnumDefin_h */
