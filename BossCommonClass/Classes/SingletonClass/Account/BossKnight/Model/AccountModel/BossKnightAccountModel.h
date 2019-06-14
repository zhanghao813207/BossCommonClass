//
//  BossKnightAccountModel.h
//  AFNetworking
//
//  Created by 张浩 on 2019/2/20.
//

#import <Foundation/Foundation.h>
#import "BossEnumDefin.h"
#import "ContractBelongModel.h"
#import "BalanceMoneyModel.h"
#import "WeChatModel.h"
#import "MobileOpenModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BossKnightAccountModel : NSObject

/**
 员工Id
 */
@property (nonatomic, strong) NSString *_id;

/**
 姓名
 */
@property (nonatomic, strong) NSString *name;

/**
 性别(10:男人, 20:女人)
 */
@property (nonatomic, assign) GenderIDs gender_id;

/**
 员工手机号
 */
@property (nonatomic, strong) NSString *phone;

/**
 民族 默认汉族
 */
@property (nonatomic, strong) NSString *national;

/**
 紧急联系人
 */
@property (nonatomic, strong) NSString *emergency_contact;

/**
 紧急联系人电话
 */
@property (nonatomic, strong) NSString *emergency_contact_phone;

/**
 学历
 */
@property (nonatomic, strong) NSString *education;

/**
 员工状态(1:待签约 100:已签约-正常 101:已签约-待换签 102:已签约-待续签 -100:已解约)
 */
@property (nonatomic, assign) StaffStates state;

/**
 常居地
 */
@property (nonatomic, strong) NSString *often_address;

/**
 入职日期
 */
@property (nonatomic, strong) NSString *entry_date;

/**
 合同生效日期yyyymmdd
 */
@property (nonatomic, strong) NSString *signed_date;

/**
 创建时间
 */
@property (nonatomic, strong) NSString *created_at;

/**
 更新时间
 */
@property (nonatomic, strong) NSString *updated_at;

/**
 推荐公司ID
 */
@property (nonatomic, strong) NSString *referrer_company_id;

/**
 签约类型
 */
@property (nonatomic, assign) StaffSignType sign_type;

/**
 职位类型（10:个户）
 */
@property (nonatomic, assign) StaffPositionType position_type;

/**
 个户类型（3001：甲类，3002：乙类）
 */
@property (nonatomic, assign) StaffIndividualType individual_type;

/**
 签约周期
 */
@property (nonatomic, assign) StaffSignCycle sign_cycle;

/**
 当前有效期内的合同id
 */
@property (nonatomic, strong) NSString *signed_date_id;

/**
 钱包信息
 */
@property (nonatomic, strong) BalanceMoneyModel *WalletModel;

/**
 微信绑定信息
 */
@property (nonatomic, strong) WeChatModel *WeChatModel;

/**
 合同附件ID
 */
@property (nonatomic, strong) NSString *contract_asset_id;

/**
 电子签约合同 url
 - pdf格式
 */
@property (nonatomic, strong) NSString *contract_asset_url;

/**
 招聘渠道Id(5001:第三方，5002:个人推荐，5003:其他 5004:转签 5005:内部推荐)
 */
@property (nonatomic, assign) RecruitmentChannelId recruitment_channel_id;

/**
 半身照(照片)
 */
@property (nonatomic, strong) NSString *bust;

/**
 半身照(照片) url
 */
@property (nonatomic, strong) NSString *bust_url;

/**
 身份证号
 */
@property (nonatomic, strong) NSString *identity_card_id;

/**
 身份证正面照(照片)
 */
@property (nonatomic, strong) NSString *identity_card_front;

/**
 身份证正面照(照片) url
 */
@property (nonatomic, strong) NSString *identity_card_front_url;

/**
 身份证背面照(照片)
 */
@property (nonatomic, strong) NSString *identity_card_back;

/**
 身份证背面照(照片) url
 */
@property (nonatomic, strong) NSString *identity_card_back_url;

/**
 健康证(正面照片)
 */
@property (nonatomic, strong) NSString *health_certificate;

/**
 健康证(正面照片) url
 */
@property (nonatomic, strong) NSString *health_certificate_url;

/**
 健康证(背面照片)
 */
@property (nonatomic, strong) NSString *health_certificate_back;

/**
 健康证(背面照片) url
 */
@property (nonatomic, strong) NSString *health_certificate_back_url;

/**
 健康证开始日期
 格式：yyyymmdd
 */
@property (nonatomic, strong) NSString *health_certificate_start;

/**
 健康证结束日期
 格式：yyyymmdd
 */
@property (nonatomic, strong) NSString *health_certificate_end;

/**
 健康证剩余天数
 */
@property (nonatomic, assign) NSInteger health_certificate_days;

/**
 平台名称列表
 */
@property (nonatomic, strong) NSArray *platform_names;

/**
 商圈名称列表
 */
@property (nonatomic, strong) NSArray *biz_district_names;

/**
 供应商名称列表
 */
@property (nonatomic, strong) NSArray *supplier_names;

/**
 城市名称列表
 */
@property (nonatomic, strong) NSArray *city_names;

/**
 平台ID
 */
@property (nonatomic, strong) NSString *custom_id;
/**
 平台ID Model List
 */
@property (nonatomic, strong) NSMutableArray *custom_list;
/**
 平台身份证
 */
@property (nonatomic, strong) NSString *associated_identity_card_id;

/**
 关联三方平台历史ID
 */
@property (nonatomic, strong) NSArray *associated_knight_id_list;

/**
 其他平台骑士ID
 */
@property (nonatomic, strong) NSString *associated_knight_id;

/**
 合同归属ID
 */
@property (nonatomic, strong) NSString *contract_belong_id;

/**
 合同信息
 */
@property (nonatomic, strong) ContractBelongModel *contract_belong_info;

/**
 纸质签约合同图片名称
 */
@property (nonatomic, strong) NSArray *contract_photo_list;

/**
 纸质签约合同图片 url
 */
@property (nonatomic, strong) NSArray *contract_photo_list_url;

/**
 银行卡号
 */
@property (nonatomic, strong) NSString *bank_card_id;

/**
 持卡人姓名
 */
@property (nonatomic, strong) NSString *cardholder_name;

/**
 银行卡省市
 */
@property (nonatomic, strong) NSArray *bank_location;

/**
 银行卡省市
 */
@property (nonatomic, strong) NSString *bank_location_Str;

/**
 开户行
 */
@property (nonatomic, strong) NSString *bank_branch;

/**
 支行名称
 */
@property (nonatomic, strong) NSString *bank_branch_name;

/**
 银行卡正面照(照片)
 */
@property (nonatomic, strong) NSString *bank_card_front;

/**
 银行卡正面照(照片)
 */
@property (nonatomic, strong) NSString *bank_card_front_url;

/**
 身份证有效期限
 */
@property (nonatomic, strong) NSString *identity_card_valid_term;

/**
 操作人ID
 */
@property (nonatomic, strong) NSString *operator_id;

/**
 银行卡上传方式 1：自动识别，2：手动填写
 */
@property (nonatomic, assign) NSUInteger bank_info_type;

/**
 工作交接备注
 */
@property (nonatomic, strong) NSString *job_transfer_remark;

/**
 解约协议签字状态 1：未签字 ，100：已签字
 */
@property (nonatomic, assign) DepartureStates departure_state;

@property (nonatomic, strong) MobileOpenModel *mobileOpen;


#pragma mark -- 枚举对应的字符串

/**
 职位
 */
@property (nonatomic, strong, readonly) NSString *postionIDString;

/**
 状态
 */
@property (nonatomic, strong, readonly) NSString *staffStateString;

/**
 性别
 */
@property (nonatomic, strong, readonly) NSString *genderString;

/**
 个户类型
 */
@property (nonatomic, strong, readonly) NSString *individualTypeStr;

/**
 推荐渠道
 */
@property (nonatomic, strong, readonly) NSString *recruitmentChannelStr;

#pragma mark -- 附加属性

@property (nonatomic, strong, readonly) NSString *supplier_name;

@property (nonatomic, strong, readonly) NSString *platform_name;

@property (nonatomic, strong, readonly) NSString *city_name;

@property (nonatomic, strong, readonly) NSString *biz_district_name;

/**
 合同归属
 */
@property (nonatomic, strong, readonly) NSString *contract_belong_name;

/**
 电子签约合同url - PDF
 */
@property (nonatomic, strong, readonly) NSString *contract_url_electronic;

/**
 纸质签约合同url - 多张照片
 
 @return return 合同url列表
 */
@property (nonatomic, strong, readonly) NSArray *contract_url_list_paper;

/**
 电子签约状态信息
 - 未完成 - 未签约
 - 已完成 - 已签约-正常、已签约-待续签、已签约-待换签
 */
@property (nonatomic, strong, readonly) NSString *electronicContractStateStr;

#pragma mark -- 更新用户信息是需要使用的属性

/**
 原手机号
 */
@property (nonatomic, strong) NSString *befor_phone;

/**
 修改手机号时的姓名
 */
@property (nonatomic, strong) NSString *befor_name;

/**
 修改手机号时的身份证
 */
@property (nonatomic, strong) NSString *befor_identity_card_id;

/**
 验证码
 */
@property (nonatomic, strong) NSString *verify_code;

#pragma mark -- help property

/**
 用户信息是否完善
 */
@property (nonatomic, assign, readonly) BOOL userInfoIsPerfect;

/**
 员工信息是否完善
 */
@property (nonatomic, assign, readonly) BOOL staffInfoIsPerfect;

/**
 工作信息是否完善
 */
@property (nonatomic, assign, readonly) BOOL jobInfoIsPerfect;

/**
 身份信息是否完善
 */
@property (nonatomic, assign, readonly) BOOL identityInfoIsPerfect;

/**
 银行卡信息是否完善
 */
@property (nonatomic, assign, readonly) BOOL bankCardInfoIsPerfect;

/**
 近期半身照是否上传
 */
@property (nonatomic, assign, readonly) BOOL bustInfoIsPerfect;

/**
 健康证是否上传
 */
@property (nonatomic, assign, readonly) BOOL healthCertificateInfoIsPerfect;

/**
 健康证有效期是否已提交
 */
@property (nonatomic, assign, readonly) BOOL checkHealthCertificateDateSubmitted;

/**
 健康证即将到期
 小于等于30天
 */
@property (nonatomic, assign, readonly) BOOL checkHealthCertificateExpiring;

/**
 健康证已到期
 */
@property (nonatomic, assign, readonly) BOOL checkHealthCertificateExpired;

/**
 检查是否签约
 */
@property (nonatomic, assign, readonly) BOOL checkSigned;

/**
 检查是否解约中
 - 站长提交解约后变为解约中
 */
@property (nonatomic, assign, readonly) BOOL checkStaffDeparture;

/**
 检查解约是否签字
 */
@property (nonatomic, assign, readonly) BOOL checkDepartureSigned;

/**
 检查是否电子签约
 */
@property (nonatomic, assign, readonly) BOOL checkElectronicContract;

/**
 检查工作交接备注是否填写
 */
@property (nonatomic, assign, readonly) BOOL checkJobTransferRemarkFill;

/**
 检查合同是否上传
 */
@property (nonatomic, assign, readonly) BOOL checkContractUploaded;

/**
 检查用户信息是否可以重新提交
 
 重新提交的条件
 - 待签约
 - 待换签
 - 解约中-未签字
 */
@property (nonatomic, assign, readonly) BOOL checkUserInfoReSubmit;


/**
 模型转字典
 
 @return 字典
 */
- (NSDictionary *)decodeToDic;

- (NSString *)getHealthCertificateStartDate;

- (NSString *)getHealthCertificateEndDate;

@end

NS_ASSUME_NONNULL_END
