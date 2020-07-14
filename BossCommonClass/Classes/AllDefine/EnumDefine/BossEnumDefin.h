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

/**
 商户状态
 */
typedef NS_ENUM(NSUInteger, MerchantState) {
    MerchantStateEnable              = 100,  // 启用
    MerchantStateDisable             = -100, // 禁用
    MerchantStateRemoved             = -101, // 删除
};

typedef NS_ENUM(NSUInteger, GenderIDs) {
    GenderIDUnknown   =  0, // 未知
    GenderIDMan       = 10, // 男人
    GenderIDWoman     = 20, // 女人
};

typedef NS_ENUM(NSInteger, StaffStates) {
    StaffStatePendingSign            =  1,    // 待签约
    StaffStateWaitApproval           =  50,   // 签约待审核
    StaffStateSigned                 =  100,  // 已签约-正常
    StaffStateWaitingRenewal         =  101,  // 已签约-待换签
    StaffStateRenewaled              =  102,  // 已签约-待续签
    StaffStateRepairSign             =  103,  // 已签约-待补签
    StaffStateDeparture              = -50,   // 解约中
    StaffStateDepartureApproval      = -51,   // 解约审核中
    StaffStateTerminated             =  -100, // 已解约
};

/**
 解约协议签字状态
 
 - DepartureStateNotSign: 未签字
 - StaffPositionType: 已签字
 */
typedef NS_ENUM(NSInteger, DepartureStates) {
    DepartureStateNotSign     = 1,   // 未签字
    DepartureStateSigned      = 100  // 已签字
};

/**
 委托个户注册状态
 */
typedef NS_ENUM(NSInteger, IndividualRegisterStates) {
    IndividualRegisterStateInit       = 1,   // 未完善
    IndividualRegisterStateDoing      = 10,   // 审核进行中
    IndividualRegisterStateDone       = 100,  // 审核通过
    IndividualRegisterStateFailed     = -100  // 审核失败
};

typedef NS_ENUM(NSInteger, StaffPositionType) {
    StaffPositionTypeAccount      =  10 // 个户
};

typedef NS_ENUM(NSInteger, StaffIndividualType) {
    StaffIndividualTypeA      =  3001, // 甲类
    StaffIndividualTypeB      =  3002, // 乙类
};

typedef NS_ENUM(NSInteger, StaffSignType) {
    StaffSignTypePaper      =  10, // 纸质签约
    StaffSignTypeElectronic =  20, // 电子签约
};

typedef NS_ENUM(NSInteger, StaffSignCycle) {
    StaffSignCycleOne      =  1, // 一年
    StaffSignCycleThree    =  3, // 三年
};

typedef NS_ENUM(NSUInteger, FlowStates) {
    FlowStateKnightWaitConfirm   = 9010, // 待骑士确认收货
    FlowStateKnightConfirmed     = 9011, // 骑士已确认收货
    FlowStateRefundWaitReview    = 9013, // 退货申请待审核
    FlowStateRefundReviewed      = 9014, // 退货申请审核通过
    FlowStateRefundNoReviewed    = 9015, // 退货申请审核不通过
};

typedef NS_ENUM(NSUInteger, RecruitmentChannelId) {
    RecruitmentChannelIdThird                      = 5001, // 第三方
    RecruitmentChannelIdPersonal                   = 5002, // 个人推荐
    RecruitmentChannelIdOther                      = 5003, // 其他
    RecruitmentChannelIdTransfer                   = 5004, // 转签
    RecruitmentChannelIdInternal                   = 5005, // 内部推荐
    RecruitmentChannelIdThirdPromotionPlatform     = 5006  // 三方推广平台
};

typedef NS_ENUM(NSUInteger, PaymentTypes) {
    PaymentTypeOnce    = 301, // 一次性
    PaymentTypeMonth   = 302, // 月付
    PaymentTypeDeposit = 303, // 押金
};

typedef NS_ENUM(NSUInteger, PopupItemTypes) {
    PopupItemAccount    = 1, // 用户
    PopupItemPost    = 2,  // 岗位
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

/**
 人员平台映射状态
 */
typedef NS_ENUM(NSUInteger, StaffCustomState) {
    StaffCustomStatePending     =    1,  // 映射草稿（等待使用中）
    StaffCustomStateEnabled     =  100,  // 映射生效（生效中）
    StaffCustomStateDisabled    = -100,  // 映射失效（已终止）
    StaffCustomStateDelete      = -101,  // 映射解除
};

#pragma mark - 审批单相关常量

/**
 审批单类型
 */
typedef NS_ENUM(NSInteger, ApplicationOrderType) {
    ApplicationOrderTypeCost          = 1, // 费用申请
    ApplicationOrderTypeSalaryRule    = 2, // 服务费规则
    ApplicationOrderTypeSalaryPayment = 3, // 服务费发放
    ApplicationOrderTypeMaterial      = 4, // 物资采购
    ApplicationOrderTypeHouseContract = 5, // 房屋管理
    ApplicationOrderTypeLoan          = 6, // 借款申请
    ApplicationOrderTypeRepayment     = 7, // 还款
    ApplicationOrderTypeBusinessTrave = 8, // 出差申请
    ApplicationOrderTypeTravelExpense = 9, // 差旅报销
    ApplicationOrderTypeOverTime      = 10,// 加班
    ApplicationOrderTypeLeaveOrder    = 11,// 请假
    ApplicationOrderTypePersonnelChanges    = 12,// 人员异动
    ApplicationOrderTypeCustomPlugInApproval    = 13,// 自定义插件审批单
    // 事务性审批流类型
    // 人事
    APPLICATION_WORK_FLOW_RECRUIT_TYPE                      = 101, // 招聘管理
    APPLICATION_WORK_FLOW_ADDENDUM_TYPE                     = 102, // 增编管理
    APPLICATION_WORK_FLOW_WORKER_TYPE                       = 103, // 转正申请
    APPLICATION_WORK_FLOW_RENEWAL_TYPE                      = 104, // 合同续签
    APPLICATION_WORK_FLOW_CHANGES_TYPE                      = 105, // 人事异动
    APPLICATION_WORK_FLOW_DEPARTURE_TYPE                    = 106, // 离职申请
    APPLICATION_WORK_FLOW_HANDOVER_TYPE                     = 107, // 工作交接
    APPLICATION_WORK_FLOW_EMPLOYED_TYPE                     = 108, // 录用申请
    // 考勤
    APPLICATION_WORK_FLOW_LEAVE_TYPE                        = 201, //请假
    APPLICATION_WORK_FLOW_OVERTIME_TYPE                     = 202, //加班
    APPLICATION_WORK_FLOW_GO_OUT_TYPE                       = 203, //外出
    APPLICATION_WORK_FLOW_ABNORMAL_TYPE                     = 204, //考勤异常
    APPLICATION_WORK_FLOW_CONFIGURE_TYPE                    = 205, //假种配置
    // 行政
    APPLICATION_WORK_FLOW_ENGRAVING_TYPE                    = 301, //印章刻制
    APPLICATION_WORK_FLOW_CANCEL_TYPE                       = 302, //印章作废
    APPLICATION_WORK_FLOW_USAGE_SEAL_TYPE                   = 303, //用章申请-用章申请表
    APPLICATION_WORK_FLOW_SEAL_LIBRARY_TYPE                 = 304, //用章申请-印章库
    APPLICATION_WORK_FLOW_CARD_TYPE                         = 305, //名片申请
    APPLICATION_WORK_FLOW_LICENCE_TYPE                      = 306, //证照借用-证照借用
    APPLICATION_WORK_FLOW_LICENCE_LIBRARY_TYPE              = 307, //证照借用-证照库
    APPLICATION_WORK_FLOW_PUNISHMENTS_TYPE                  = 308, //奖惩通知
    // 商务
    APPLICATION_WORK_FLOW_COMPANY_REGISTER_TYPE             = 401, //注册公司
    APPLICATION_WORK_FLOW_COMPANY_CHANGE_TYPE               = 402, //公司变更
    APPLICATION_WORK_FLOW_BANK_ACCOUNT_TYPE                 = 403, //银行开户
    APPLICATION_WORK_FLOW_BANK_CANCEL_TYPE                  = 404, //注销开户
    APPLICATION_WORK_FLOW_CONTRACT_APPROVAL_TYPE            = 405, //合同会审
    APPLICATION_WORK_FLOW_CONTRACT_BORROWING_TYPE           = 406, //合同借阅-合同借阅审批
    APPLICATION_WORK_FLOW_CONTRACT_BORROWING_LIBRARY_TYPE   = 407, //合同借阅-合同库
};

// 审批单整体状态
typedef NS_ENUM(NSInteger, OA_EXAMINE_STATE) {
    OA_EXAMINE_STATE_INIT     =    1,  // 待提交
    OA_EXAMINE_STATE_UNDERWAY =   10,  // 进行中
    OA_EXAMINE_STATE_DONE     =  100,  // 流程完成
    OA_EXAMINE_STATE_SHUTDOWN = -100,  // 流程关闭
};
// 审批节点状态
typedef NS_ENUM(NSInteger, OA_EXAMINE_NODE_STATE) {
    OA_EXAMINE_NODE_STATE_PAY        =   -2,  // 支付节点
    OA_EXAMINE_NODE_STATE_UNCOMMIT   =   -1,  // 待提报
    OA_EXAMINE_NODE_STATE_COMMIT     =    0,  // 提报
    OA_EXAMINE_NODE_STATE_INIT       =    1,  // 待处理
    OA_EXAMINE_NODE_STATE_SUPPLEMENT =   10,  // 待补充
    OA_EXAMINE_NODE_STATE_ERROR      =   50,  // 异常
    OA_EXAMINE_NODE_STATE_AGREE      =  100,  // 通过
    OA_EXAMINE_NODE_STATE_DONE       =  101,  // 完成
    OA_EXAMINE_NODE_STATE_WITHDRAW   =  -50,  // 撤回
    OA_EXAMINE_NODE_STATE_REJECT     = -100,  // 驳回
    OA_EXAMINE_NODE_STATE_CANCLE     = -101,  // 关闭
};

/**
 打款状态
 */
typedef NS_ENUM(NSInteger, PAY_STATE) {
    PAY_STATE_DONE   =  100, // 已打款
    PAY_STATE_ERROR  =   -1, // 异常
    PAY_STATE_NONE   =    0, // 暂无异常
    PAY_STATE_INIT   =    1, // 待处理
};

#pragma mark - 审批单子订单状态

/**
 单据状态
 */
typedef NS_ENUM(NSUInteger, OrderState) {
    OrderStateInit    =    1, // 待提交
    OrderStateDoing   =   10, // 审批进行中
    OrderStateDone    =  100, // 完成
    OrderStateClosed  = -100, // 关闭
    OrderStateDeleted = -101, // 删除
};

#pragma mark - 借款单相关常量

/**
 借款类型
 */
typedef NS_ENUM(NSUInteger, LoanType) {
    LoanTypeOrdinary = 1,  // 普通借款
    LoanTypeSpecial  = 10  // 专项借款
};

/**
 还款状态
 */
typedef NS_ENUM(NSUInteger, RepaymentState) {
    RepaymentStateInit   =   1, // 未还款
    RepaymentStateDoing  =  50, // 还款中
    RepaymentStateDone   = 100, // 已结清
};

/**
 还款方式
 */
typedef NS_ENUM(NSUInteger, RepaymentMethod) {
    RepaymentMethodCurrency   =   1 // 货币
};

/**
 还款周期
 */
typedef NS_ENUM(NSUInteger, RepaymentCycle) {
    RepaymentCycleOneTime    =  1, // 一次性还清
    RepaymentCycleInstalment = 10, // 分期还
};

#pragma mark -出差申请单相关常量

/**
 出差类别
 */
typedef NS_ENUM(NSUInteger, TravelApplyType) {
    TravelApplyTypeOneway     = 10,  // 单程
    TravelApplyTypeRoundtrip  = 20  // 往返
};

/**
 出差方式
 */
typedef NS_ENUM(NSUInteger, TravelApplyMethod) {
    TravelApplyMethodTrain                = 101,  // 火车-普通列车
    TravelApplyMethodMotorTrainFirst      = 201,  // 火车-动车-一等座
    TravelApplyMethodMotorTrainSecond     = 202,  // 火车-动车-二等座
    TravelApplyMethodHignSpeedRailFirst   = 203,  // 火车-高铁-一等座
    TravelApplyMethodHignSpeedRailSecond  = 204,  // 火车-高铁-二等座
    TravelApplyMethodAircraftFirst        = 301,  // 飞机-头等舱
    TravelApplyMethodAircraftEconomy      = 302,  // 飞机-经济舱
    TravelApplyMethodBus                  = 401,  // 客车
    TravelApplyMethodSelfDriving          = 501   // 自驾
};


typedef NS_ENUM(NSUInteger, BOSS_MODULE_TYPE) {
    BOSS_MODULE_TYPE_OA  = 1, // 费用模块
};

//# boss助理(费用模块)
typedef NS_ENUM(NSUInteger, BOSS_ASSISTANT_TYPE) {
    BOSS_ASSISTANT_URGE = 101,  // 助理类型为催办
    BOSS_ASSISTANT_WAIT =  99,  // 助理类型为代办
};

// 费用单状态
typedef NS_ENUM(NSInteger, COST_ORDER_STATE) {
    COST_ORDER_STATE_DEL     = -100, // 删除
    COST_ORDER_STATE_DOING   =   50, // 进行中
    COST_ORDER_STATE_DONE    =  100, // 审批完成
    COST_ORDER_STATE_INIT    =    1, // 待提交
};

// 费用单类型
typedef NS_ENUM(NSInteger, ApplicationSubType) {
    ApplicationSubTypeNormal    =   1,  // 正常费用单
    ApplicationSubTypeRefund    =  10,  // 退款费用单
    ApplicationSubTypeRedPush   =  20,  // 红冲费用单
};

// 成本归属分摊模式
typedef NS_ENUM(NSUInteger, ALLOCATION_MODE) {
    ALLOCATION_MODE_BALANCE  =  6, // 平均分摊
    ALLOCATION_MODE_CUSTOM   =  8, // 自定义分摊
};

// 费用类型(枚举跟后端一致，名字那么low不是我起的)
typedef NS_ENUM(NSUInteger, OS_COSTCLASS_TYPE) {
    OA_TEMPLATE_ONE          = 1, // 报销
    OA_TEMPLATE_TWO          = 2, // 租房
    OS_COSTCLASS_SALARY      = 3, // 服务费
    OS_COSTCLASS_SUBJOIN     = 4, // 租房、中介费、押金(租房)
    OS_COSTCLASS_AGENCY      = 5, // 租房、中介费、押金(中介费)
    OS_COSTCLASS_PLEDGE      = 6, // 租房、中介费、押金(押金)
};
//旧的枚举 V1
//typedef NS_ENUM(NSInteger, MESSAGE_TYPE) {
//    MESSAGE_TYPE_NEW       =    1,  // 新消息
//    MESSAGE_TYPE_SEND      =   90,  // 已送达
//    MESSAGE_TYPE_READ      =  100,  // 已读
//    MESSAGE_TYPE_DEL       = -100,  // 已删除
//};

typedef NS_ENUM(NSInteger, MESSAGE_TYPE) {
    MESSAGE_TYPE_NEW       =    1,  // 新消息
    MESSAGE_TYPE_SEND      =   90,  // 已送达
    MESSAGE_TYPE_READ      =  91,   // 已读
    MESSAGE_TYPE_DONE      =  100,  // 完成
    MESSAGE_TYPE_DEL       = -100,  // 已删除
};

typedef NS_ENUM(NSInteger, OA_EVENT) {
    OA_EVENT_URGE               =  1, // 催办提醒
    OA_EVENT_PENDING            =  2, // 待办提醒
    OA_EVENT_NODE_APPROVED      = 10, // 审核通过
    OA_EVENT_NODE_REJECT        = 11, // 审核驳回
    OA_EVENT_APPLICATION_PAID   = 12, // 财务打款
    OA_EVENT_APPLICATION_DONE   = 13, // 审批通过
    OA_EVENT_APPLICATION_CANCLE = 14, // 审批关闭
    OA_EVENT_APPLICATION_EXTRA  = 15, // 补充意见
};

typedef NS_ENUM(NSInteger, BROAD_TYPE) {
    BROAD_TYPE_GLOBAL     =  1, // 全局
    BROAD_TYPE_ORIERN     = 10, // 定向
};

typedef NS_ENUM(NSInteger, URGE_RECORD_STATE) {
    URGE_RECORD_STATE_INIT     =    1, // 未处理
    URGE_RECORD_STATE_READ     =   10, // 已读
    URGE_RECORD_STATE_COMPLETE =  100, // 已办理
    URGE_RECORD_STATE_SHUTDOWN = -100, // 关闭
};
// 消息内容类型
typedef enum : NSUInteger {
    MESSAGE_KIND_TEXT = 10, // 纯文本
    MESSAGE_KIND_VIDEO = 20, // 视频
    MESSAGE_KIND_VOICE = 30, // 语音
    MESSAGE_KIND_PICTURE = 40, // 图片
    MESSAGE_KIND_RICH_TEXT = 50, // 富文本富媒体
    MESSAGE_KIND_CUSTOM_FORM = 60, // 自定义表单信息
    MESSAGE_KIND_URL = 70 // URL外部链接跳转
} messageContextType;

typedef NS_ENUM(NSUInteger, STAFFWORKTYPE) {
    STAFFWORKTYPEFULLTIME        =  3002, // 甲类
    STAFFWORKTYPEPARTTIME        =  3001, // 乙类
};

typedef NS_ENUM(NSUInteger, PayrooCycleType) {
    PayrooCycleTypeMonth    = 1, // 按月
    PayrooCycleTypeDay      = 2, // 按日
};

typedef NS_ENUM(NSInteger, PaySalaryState) {
    PaySalaryStateNormal       =  1, // 正常
    PaySalaryStateDelayed      = -1, // 缓发
};

typedef NS_ENUM(NSUInteger, StatementDataDomain) {
    StatementDataDomainBizDistrict = 2, // 商圈
    StatementDataDomainCity        = 3, // 城市
};

typedef NS_ENUM(NSUInteger, SalaryRuleCollectionType) {
    SalaryRuleCollectionTypeOrder          = 1, // 单量
    SalaryRuleCollectionTypeAttendance     = 2, // 出勤
    SalaryRuleCollectionTypeQuality        = 3, // 质量
    SalaryRuleCollectionTypeManage         = 4, // 管理
};

typedef NS_ENUM(NSUInteger, WorkLogicType) {
    WorkLogicTypeByOnce        = 1, // 一次补贴
    WorkLogicTypeByOrderUnit   = 2, // 按单补贴
    WorkLogicTypeBySalaryBase  = 3, // 底薪补贴
};

typedef NS_ENUM(NSUInteger, SalaryComputeTaskType) {
    SalaryComputeTaskTypeStaff         = 1,  // 人员
    SalaryComputeTaskTypeBizDistrict   = 2,  // 商圈
    SalaryComputeTaskTypeCity          = 3,  // 城市
};

typedef NS_ENUM(NSUInteger, ExamineFlowBizType) {
    ExamineFlowBizTypeCost    =  1, // 成本
    ExamineFlowBizTypeNoCost  = 90, // 非成本
};

typedef enum : NSUInteger {
    BossRed,
    BossYellow,
    BossBlue,
} BossColor;

typedef NS_ENUM(NSUInteger, NodePickMode) {
    NodePickModeManual     = 1, // 手动
    NodePickModeAuto       = 2, // 自动
};

typedef NS_ENUM(NSInteger, CostUpdateRule) {
    CostUpdateRuleDown          = -1, // 向下
    CostUpdateRuleNone          =  0, // 无限制
    CostUpdateRuleUp            =  1, // 向上
};

typedef NS_ENUM(NSInteger, SupplementOpinionState) {
    SupplementOpinionStateDelete   =  -101, // 删除
    SupplementOpinionStateNormal   =   100, // 正常
};
//旧的枚举，不用了
//typedef NS_ENUM(NSUInteger, CostCenterType) {
//    CostCenterTypeKnight     = 1, // 骑士
//    CostCenterTypeBD         = 2, // 商圈
//    CostCenterTypeCity       = 3, // 城市
//    CostCenterTypeItemMainHQ = 4, // 项目主体总部
//    CostCenterTypeItem       = 5, // 项目
//};

typedef NS_ENUM(NSUInteger, CostCenterTypeV2) {
    CostCenterTypeKnight           = 1, // 骑士
    CostCenterTypeBizDistrict      = 2, // 商圈
    CostCenterTypeCity             = 3, // 城市
    CostCenterTypePrjBase          = 4, // 项目主体
    CostCenterTypePrj              = 5, // 项目总部
    CostCenterTypeManager          = 6, // 管理费用
    CostCenterTypeOperation        = 7, // 运营支持
    CostCenterTypeDirect           = 8, // 车辆直接成本
    CostCenterTypeIndirect         = 9, // 车辆间接成本
    CostCenterTypeTeam             = 10,// 团队
    CostCenterTypePersonal         = 11,// 个人
    CostCenterTypeAssets           = 12,// 资产
};
//业务考核各级团队类型
typedef NS_ENUM(NSUInteger,TeamType) {
    TEAM_TYPE_OWNER_TEAM = 1,       //业主小队
    TEAM_TYPE_COACH_TEAM = 2,       //私教小队
    TEAM_TYPE_COACH_GROUP_TEAM = 3, //私教团队
    TEAM_TYPE_COMPANY_TEAM = 4,     //业务赋能小队
    TEAM_TYPE_DATA_TEAM = 5, //数据小队
    TEAM_TYPE_OPERATION_TEAM = 6, //运维小队
    TEAM_TYPE_BUSINESS_TEAM = 7, //商务小队
    DEPARTMENT_TYPE_COACH = 10,  // 私教
    DEPARTMENT_COACH_TEAM = 20,  // 大区
    DEPARTMENT_BUSINESS = 30,  // 分部
    DEPARTMENT_DEPARTMENT = 40,  // 事业部
    DEPARTMENT_OWNER_TEAM = 50,  // 业主
};

typedef NS_ENUM(NSUInteger, NodeApproveMode) {
    NodeApproveModeAny = 20, // 任意
    NodeApproveModeAll = 10, // 全部
};

//消息会话列表
typedef NS_ENUM(NSInteger, MessageType) {
    MessageTypeSingleChat     =  40, // 单聊
    MessageTypeGroupChat =  50, // 群聊
    MessageTypeAnnouncement =  60, // 公告
    MessageTypeMeeting =  70, // 应用(会议)
};

///消息列表-消息类型 10 普通公告 20 公众号
typedef NS_ENUM(NSInteger, MessageListType) {
    MessageListTypeAnnouncement =  10,
    MessageListTypeOfficial = 20,
};

//业务线类型
typedef NS_ENUM(NSUInteger, LineDustryType) {
    LineDustryTypeLogistics              = 1000,  // 外卖配送
    LineDustryTypeTaxi                   = 2000,  // 网约车
    LineDustryTypeCleaning               = 3000,  // 家政保洁
    LineDustryTypeSecurity               = 4000,  // 安保服务
    LineDustryTypeBicycle                = 5000,  // 共享单车
    LineDustryTypePromotion              = 6000,  // 促销
    LineDustryTypeBusinessService        = 7000,  // 商业清洗
    LineDustryTypeAgentOperation         = 8000,  // 平台代运营
    LineDustryTypeHotel                  = 9000,  // 酒店服务
    LineDustryTypeAdvertising            = 10000, // 广告投放
    LineDustryTypeCarSharing             = 11000, // 共享汽车
    LineDustryTypeHRService              = 12000, // 人力资源服务
    LineDustryTypeAnchor                 = 13000, // 主播
};

// 身份信息状态
typedef NS_ENUM(NSUInteger, IdentityStatus) {
    IdentityStatusFew            = 1, // 正反面照片任一面缺少,未完善
    IdentityStatusMissSome       = 2, // 只缺手持证件照,未完善
    IdentityStatusDone           = 3, // 身份信息完善
};

// 银行卡信息状态
typedef NS_ENUM(NSUInteger, BankCardStatus) {
    BankCardStatusNOCardId       = 1, // 缺少银行卡号,未完善
    BankCardStatusNOSome         = 2, // 缺少除银行卡号之外的其他字段,未完善
    BankCardStatusDone           = 3, // 银行卡信息完善
};
// 修改用户信息流程当前状态
typedef enum : NSUInteger {
    normalState = 1, // 普通状态
    auditState = 50, // 待审核
    rejectedState = -50, // 驳回
    throughState = 100, // 通过
    deleteState = -100, // 删除
} changeUserInfoCurrentstate;

// 枚举全部遵循 大驼峰命名规则，后面统一改一下
// 修改用户信息类型
typedef enum : NSUInteger {
    fixName = 10, // 修改姓名
    fixIDNumber = 20, // 身份证号
    fixIDCardDate = 30, // 身份证日期
    fixIDcard = 40, // 临时换正式
} SelectModifyOperationType;

// 身份证类型
typedef NS_ENUM(NSUInteger, IdentityType) {
    IdentityTypeNormal            = 10, // 正常身份证
    IdentityTypeTemp              = 20, // 临时身份证
};

// 银行卡类型
typedef NS_ENUM(NSUInteger, BankCardType) {
    BankCardTypeSelf               = 10, // 自己的银行卡
    BankCardTypeOther              = 20, // 代收人的银行卡
};

// 员工类型 一线 还是二线
typedef NS_ENUM(NSUInteger, WorkerType) {
    WorkerTypeFirstLine               = 10, //一线员工
    WorkerTypeSecondLine              = 20, //二线员工
};

// 个户工商注册来源 10为伯渡 20为盟达
typedef NS_ENUM(NSUInteger, EntrustRegistrationSource) {
    EntrustRegistrationSourceBoDu                = 10, //工商注册 伯渡
    EntrustRegistrationSourceMengDa              = 20, //工商注册 盟达
};

// 个户工商注册来源 10为伯渡 20为盟达
typedef NS_ENUM(NSUInteger,  authenticationType) {
    IDCardauthentication              = 10, //身份证识别认证
    FaceIDauthentication              = 20, //人脸识别认证
};
// 签约状态
typedef NS_ENUM(NSInteger, ContractStatus) {
    ContractStatusInit                  = 1,    // 合同初始化
    ContractStatusHandSuccess           = 50,   // 骑士手签成功
    ContractStatusPerformance           = 100,  //履约中
    ContractStatusOverdue               = -105, // 过期
};

//请假类型
typedef NS_ENUM(NSInteger, LeaveType) {
    LeaveTypePersonal                   = 10,    // 事假
    LeaveTypeSick                       = 20,    // 病假
    LeaveTypeAnnual                     = 30,    // 年假
    LeaveTypeMarriage                   = 40,    // 婚假
    LeaveTypeMaternity                  = 50,    // 产假
    LeaveTypePaternity                  = 60,    // 陪产假
    LeaveTypeFuneral                    = 70,    // 丧假
    
};

//合同提示类型
typedef NS_ENUM(NSInteger, ContractTipType) {
    ContractTipTypeNotForce                = 10,    // 合同已失效
    ContractTipTypeError                   = 20,    // 合同信息有误
};

//储存文件类型[1: 七牛 2: 本地 3:S3] |
typedef NS_ENUM(NSInteger, SavePhotoType) {
    SavePhotoTypeQiNiu                 = 1,    // 七牛
    SavePhotoTypeLocal                 = 2,    // 本地
    SavePhotoTypeS3                    = 3,    // S3
    
};
typedef NS_ENUM(NSInteger, MasksStatus) {
    MasksCreateSuccess                 = 1,     // 未审核 1
    MasksReceive                       = 50,    // 待领取 50
    MasksRefused                       = -50,   // 被拒绝 -50
    MasksReceiveSuccess                = 100,   // 领取完成 100
};


typedef NS_ENUM(NSInteger, MonitType) {
    MonitTypeIdentityError              = 1,    // 身份号错误
    MonitTypeThreeIdError               = 2,   // 三方id不匹配
    MonitTypeNameError                  = 3,     // 名字错误
    MonitTypeSignError                  = 4,    // 签约不匹配

};

typedef NS_ENUM(NSInteger, TeamInfo) {
    TeamInfoNormal              =  100,    //正常在团队中
    TeamInfoExit                = -100,   // 退出团队
};

typedef NS_ENUM(NSInteger, QuestionnaireState) {
    QuestionnaireStateWaitDo              =  1,    //未提交
    QuestionnaireStateDone                = 100,   // 已提交
};

typedef NS_ENUM(NSInteger, OrderType) {
    OrderTypeIn              =  1,    //顺序
    OrderTypeDe              = -1,    //逆序
};

#endif /* BossEnumDefin_h */
