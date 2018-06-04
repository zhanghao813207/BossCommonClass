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

typedef NS_ENUM(NSUInteger, ACCOUNT_ROLE) {
    ACCOUNT_ROLE_SUPER_MAN         =   1, // 超级管理员
    ACCOUNT_ROLE_BIZ_MAN           =  50, // 高管
    ACCOUNT_ROLE_OP_MAN            = 100, // 运营管理
    ACCOUNT_ROLE_SUPPLY_MAN        = 120, // 采购管理
    ACCOUNT_ROLE_FINANCE_MAN       = 140, // 财务管理
    ACCOUNT_ROLE_WMS_MAN           = 200, // 仓库管理
    ACCOUNT_ROLE_DC_MAN            = 300, // 微仓管理
    ACCOUNT_ROLE_STORE_MAN_COURIER = 400, // 末端骑士
    ACCOUNT_ROLE_STORE_MAN_BIZ     = 401, // 末端骑士长
    ACCOUNT_ROLE_SALES_MAN         = 500, // 销售地推
};

#pragma mark -- knightEnum --
/**
 通过单例模仿的字符串的枚举方式
 
 @param OperationTypes 七牛云上传图片的操作类型
 */
#define OPERATE_TYPE ((OperationTypes *)[OperationTypes defaultType])


typedef NS_ENUM(NSUInteger, TASK_TYPES) {
    TASK_TYPE_REPLENISH   = 1, // 补退货任务
    TASK_TYPE_DISTRIBUTE  = 2, // 铺货任务
    TASK_TYPE_CLOSE_STORE = 3, // 撤店任务
};

typedef NS_ENUM(NSUInteger, TASK_STATES) {
    TASK_STATE_INIT         =  1, // 初始化
    TASK_STATE_PENDING      =  5, // 待领任务
    TASK_STATE_WAIT_PICKUP  =  6, // 等待分拣
    TASK_STATE_DOING        = 10, // 进行中
};

/**
 入库单状态
 
 - IN_ORDER_STATE_INIT: 未开始
 - IN_ORDER_STATE_DOING: 进行中
 - IN_ORDER_STATE_DONE: 完成
 - IN_ORDER_STATE_CLOSED: 关闭
 */
typedef NS_ENUM(NSUInteger, IN_ORDER_STATES) {
    IN_ORDER_STATE_INIT   =    1,
    IN_ORDER_STATE_DOING  =   10,
    IN_ORDER_STATE_DONE   =  100,
    IN_ORDER_STATE_CLOSED = -100,
};

/**
 入库类型
 
 - IN_ORDER_TYPE_REPLENISH: 补货入库
 - IN_ORDER_TYPE_CHECK: 盘点损益
 - IN_ORDER_TYPE_DISTRIBUTE: 铺货入库
 */
typedef NS_ENUM(NSUInteger, IN_ORDER_TYPES) {
    IN_ORDER_TYPE_REPLENISH  = 1,
    IN_ORDER_TYPE_CHECK      = 2,
    IN_ORDER_TYPE_DISTRIBUTE = 3,
};

/**
 出库单状态
 
 - OUT_ORDER_STATE_INIT: 未开始
 - OUT_ORDER_STATE_DOING: 进行中
 - OUT_ORDER_STATE_DONE: 完成
 - OUT_ORDER_STATE_CLOSED: 关闭
 */
typedef NS_ENUM(NSUInteger, OUT_ORDER_STATES) {
    OUT_ORDER_STATE_INIT    =    1,
    OUT_ORDER_STATE_DOING   =   10,
    OUT_ORDER_STATE_DONE    =  100,
    OUT_ORDER_STATE_CLOSED  = -100,
};

/**
 骑士领货交接单状态
 
 - PICKUP_TICKET_STATE_INIT: 未开始
 - PICKUP_TICKET_STATE_DOING: 未领货
 - PICKUP_TICKET_STATE_PENDING_CHECK: 待清点
 - PICKUP_TICKET_STATE_CHECKING: 清点中
 - PICKUP_TICKET_STATE_DONE: 完成
 */
typedef NS_ENUM(NSUInteger, PICKUP_TICKET_STATES) {
    PICKUP_TICKET_STATE_INIT          =   1,
    PICKUP_TICKET_STATE_DOING         =  10,
    PICKUP_TICKET_STATE_PENDING_CHECK =  20,
    PICKUP_TICKET_STATE_CHECKING      =  21,
    PICKUP_TICKET_STATE_DONE          = 100,
};

/**
 微仓／骑士退货交接单状态
 
 - RETURN_TICKET_STATE_INIT: 未开始
 - RETURN_TICKET_STATE_DOING: 未回仓
 - RETURN_TICKET_STATE_PENDING_CHECK: 待清点
 - RETURN_TICKET_STATE_CHECKING: 清点中
 - RETURN_TICKET_STATE_DONE: 完成
 */
typedef NS_ENUM(NSUInteger, RETURN_TICKET_STATES) {
    RETURN_TICKET_STATE_INIT          =   1,
    RETURN_TICKET_STATE_DOING         =  10,
    RETURN_TICKET_STATE_PENDING_CHECK =  20,
    RETURN_TICKET_STATE_CHECKING      =  21,
    RETURN_TICKET_STATE_DONE          = 100,
};

/**
 微仓／骑士交接单审核标记
 
 - APPROVE_FLAG_NONE: 未提交审核
 - APPROVE_FLAG_PENDING: 待审核
 - APPROVE_FLAG_YES: 通过
 - APPROVE_FLAG_NO: 驳回
 */
typedef NS_ENUM(NSInteger, APPROVE_FLAGS) {
    APPROVE_FLAG_NONE    =    0, // 移动端状态
    APPROVE_FLAG_PENDING =    1,
    APPROVE_FLAG_YES     =  100,
    APPROVE_FLAG_NO      = -100,
};

/**
 中转袋状态
 
 - OrderPackStateInit: 装袋中
 - OrderPackStatePicked: 已领用
 - OrderPackStateDone: 已完成
 */
typedef NS_ENUM(NSUInteger, OrderPackState) {
    OrderPackStateInit    =   1,
    OrderPackStatePicked  =   5,
    OrderPackStateDone    = 100,
};


typedef NS_ENUM(NSUInteger, TicketType) {
    TicketTypePickup    =   1, // 领货交接单
    TicketTypeReturn    =   2, // 退货交接单
};

#pragma mark -- sellerEnum --

typedef NS_ENUM(NSUInteger, VISIT_STATE) {
    VISIT_STATE_All      = 0,  // 已拜访
    VISIT_STATE_NOSIGNUP = 1,  // 未签约
    VISIT_STATE_SIGNUP   = 2,  // 已签约
};

typedef NS_ENUM(NSUInteger, QiNiuToken_Image_Type) {
    QiNiuToken_Image_Type_MySelf  = 1, // 自己
    QiNiuToken_Image_Type_Rival   = 2, // 对手
    QiNiuToken_Image_Type_Receipt = 3, // 回执单
};

typedef NS_ENUM(NSUInteger, SIGNUP_STATE) {
    SIGNUP_STATE_FAIL      = 1,  // 未签约
    SIGNUP_STATE_SUCCESS   = 2,  // 签约成功
};

typedef NS_ENUM(NSUInteger, CONTENDER_STATE) {
    CONTENDER_STATE_NOHAVE    = 0,  // 无竞争对手
    CONTENDER_STATE_HAVE      = 1,  // 有竞争对手
};

typedef NS_ENUM(NSUInteger, ACCOUNT_STATE) {
    ACCOUNT_STATE_REST        = 0, // 休息
    ACCOUNT_STATE_WORKING     = 1, // 工作
};

typedef NS_ENUM(NSUInteger, TASK_LIST_TYPE) {
    TASK_LIST_TYPE_ALL        = 0, // 全部记录
    TASK_LIST_TYPE_TODAY      = 1, // 今日任务
};

typedef NS_ENUM(NSUInteger, StoreState) {
    StoreStateNotOpen = 1, // 未开店
    StoreStateHasOpen = 2, // 已开店
};

typedef NS_ENUM(NSUInteger, CONTAINER_TASK_TYPES) {
    CONTAINER_TASK_TYPE_REPLENISH,           // 智能柜补货任务
    CONTAINER_TASK_TYPE_REPLENISH_REVIEWING, // 智能柜补货任务审核中
    CONTAINER_TASK_TYPE_RETURN,              // 智能柜退货任务
};

typedef NS_ENUM(NSUInteger, GOODS_CHANGE_TYPE) {
    GOODS_CHANGE_TYPE_IN,  // 上货
    GOODS_CHANGE_TYPE_OUT, // 退货
};


#endif /* BossEnumDefin_h */
