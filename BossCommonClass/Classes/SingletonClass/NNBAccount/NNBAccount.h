//
//  NNBAccount.h
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/27.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "CityModel.h"
#import "PlatformModel.h"
#import "DepartureLogModel.h"
#import "BizDistrictModel.h"

@interface NNBAccount : NSObject

+ (__kindof NNBAccount *)defaultAccount;

/**
 银行卡正面照(照片)
 */
@property (nonatomic, strong) NSString *bank_card_front_key;

/**
 (平台ID（其他骑士ID列表）
 */
@property (nonatomic, strong) NSArray *associated_knight_id_list;

/**
 半身照(照片)
 */
@property (nonatomic, strong) NSString *bust_key;

/**
 离职原因
 */
@property (nonatomic, strong) NSString *departure_reason;

/**
 职位id
 */
@property (nonatomic, assign) PositionID position_id;

/**
 离职日期
 */
@property (nonatomic, strong) NSString *departure_date;

/**
 民族 默认汉族
 */
@property (nonatomic, strong) NSString *national;

/**
 更新时间
 */
@property (nonatomic, strong) NSString *updated_at;

/**
 工作性质id
 */
@property (nonatomic, assign) NSInteger job_category_id;

/**
 薪资发放周期
 */
@property (nonatomic, assign) NSInteger pay_salary_cycle;

/**
 城市列表
 */
@property (nonatomic, strong) NSArray <CityModel *>*city_list;

/**
 开户行支行
 */
@property (nonatomic, strong) NSString *bank_branch;

/**
 持卡人姓名
 */
@property (nonatomic, strong) NSString *cardholder_name;


/**
 健康证(照片)
 */
@property (nonatomic, strong) NSString *health_certificate_key;
/**
 学历
 */
@property (nonatomic, strong) NSString *education;
/**
 健康证(照片)
 */
@property (nonatomic, strong) NSString *health_certificate;
/**
 平台（APP端）
 */
@property (nonatomic, strong) NSString *platform_name;
/**
 商圈（APP端）
 */
@property (nonatomic, strong) NSString *biz_district_name;

/**
 招聘渠道id
 */
@property (nonatomic, assign) NSInteger recruitment_channel_id;

/**
 账号ID
 */
@property (nonatomic, strong) NSString *staff_id;
/**
 紧急联系人
 */
@property (nonatomic, strong) NSString *emergency_contact;

/**
 合同照片
 */
@property (nonatomic, strong) NSArray *contract_photo_key_list;

/**
 身份证正面照(照片)
 */
@property (nonatomic, strong) NSString *identity_card_front;

/**
 银行卡号
 */
@property (nonatomic, strong) NSString *bank_card_id;

/**
 半身照(照片)
 */
@property (nonatomic, strong) NSString *bust;

/**
 平台列表
 */
@property (nonatomic, strong) NSArray <PlatformModel *>*platform_list;

/**
 状态id
 */
@property (nonatomic, assign) StaffStates state;

/**
 入职日期
 */
@property (nonatomic, strong) NSString *entry_date;

/**
 骑士类型转换日志
 */
@property (nonatomic, strong) NSArray *job_category_log;

/**
 紧急联系人电话
 */
@property (nonatomic, strong) NSString *emergency_contact_phone;

/**
 健康证(背面照片)
 */
@property (nonatomic, strong) NSString *health_certificate_back;

/**
 银行卡正面照(照片)
 */
@property (nonatomic, strong) NSString *bank_card_front;

/**
 招聘渠道（APP端）
 */
@property (nonatomic, strong) NSString *recruitment_channel;

/**
 身份证背面照(照片)
 */
@property (nonatomic, strong) NSString *identity_card_back_key;

/**
 操作人ID
 */
@property (nonatomic, strong) NSString *operator_id;

/**
 合同照片
 */
@property (nonatomic, strong) NSArray *contract_photo_list;

/**
 合同归属
 */
@property (nonatomic, strong) NSString *contract_belong_name;

/**
 推荐人
 */
@property (nonatomic, strong) NSString *referrer_name;

/**
 职审批人姓名
 */
@property (nonatomic, strong) NSString *departure_approver_name;

/**
 骑士类型ID
 */
@property (nonatomic, strong) NSString *knight_type_id;

/**
 身份证背面照(照片)
 */
@property (nonatomic, strong) NSString *identity_card_back;

/**
 供应商ID
 */
@property (nonatomic, strong) NSString *supplier_id;

/**
 商圈描述
 */
@property (nonatomic, strong) NSArray *district_description;

/**
 供应商名称
 */
@property (nonatomic, strong) NSString *supplier_name;

/**
 城市（APP端）
 */
@property (nonatomic, strong) NSString *city_name;

/**
 其他平台骑士ID
 */
@property (nonatomic, strong) NSString *associated_knight_id;

/**
 离职日志
 */
@property (nonatomic, strong) NSArray <DepartureLogModel *>*departure_log;

/**
 商圈列
 */
@property (nonatomic, strong) NSArray <BizDistrictModel *>*biz_district_list;

/**
 职审批人id
 */
@property (nonatomic, strong) NSString *departure_approver_account_id;

/**
 骑士类型
 */
@property (nonatomic, strong) NSString *knight_type_name;

/**
 合同归属ID
 */
@property (nonatomic, strong) NSString *contract_belong_id;

/**
 姓名
 */
@property (nonatomic, strong) NSString *name;

/**
 手机号
 */
@property (nonatomic, strong) NSString *phone;

/**
 身份证正面照(照片)
 */
@property (nonatomic, strong) NSString *identity_card_front_key;

/**
 创建时间
 */
@property (nonatomic, strong) NSString *created_at;

/**
 身份证号
 */
@property (nonatomic, strong) NSString *identity_card_id;

/**
 性别(10:男人, 20:女人)
 */
@property (nonatomic, assign) GenderIDs gender_id;

/**
 平台身份证
 */
@property (nonatomic, strong) NSString *associated_identity_card_id;

/**
 操作人姓名
 */
@property (nonatomic, strong) NSString *operator_name;

/**
 银行卡省市
 */
@property (nonatomic, strong) NSArray *bank_location;

/**
 id
 */
@property (nonatomic, strong) NSString *_id;

/**
 工作交接备注
 */
@property (nonatomic, strong) NSString *job_transfer_remark;

/**
 access_token
 */
@property (nonatomic, strong) NSString *access_token;

/**
 refresh_token
 */
@property (nonatomic, strong) NSString *refresh_token;

/**
 过期时间
 */
@property (nonatomic, strong) NSString *expired_at;

#pragma mark -- 枚举对应的字符串

/**
 职位
 */
@property (nonatomic, strong, readonly) NSString *postionIDString;

/**
 岗位状态
 */
@property (nonatomic, strong, readonly) NSString *staffStateString;

/**
 性别
 */
@property (nonatomic, strong, readonly) NSString *genderString;




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
 个人信息是否需要更新
 */
@property (nonatomic, assign) BOOL isNeedUpdate;

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
 合同照片是否上传
 */
@property (nonatomic, assign, readonly) BOOL contractPhotosInfoIsPerfect;

/**
 近期半身照是否上传
 */
@property (nonatomic, assign, readonly) BOOL bustInfoIsPerfect;

/**
 健康证是否上传
 */
@property (nonatomic, assign, readonly) BOOL healthCertificateInfoIsPerfect;

#pragma mark --method

/**
 判断用户是否是第一次登录
 */
@property (nonatomic, assign) BOOL isFirstLogin;


/**
 判断用户是否登录

 @param success 成功登录
 @param viewController 弹出登录的控制器（一般为当前控制器）
 */
+ (void)userIsLoginSuccess:(void (^)(BOOL isSuccess, BOOL isFirstLogin))success withController:(UIViewController *)viewController;

/**
 判断用户是否信息完善
 
 @param perfectBlock 完善
 @param toPerfectBlock 去完善
 @param viewController 弹出去完善的按钮
 */
+ (void)userInfoIsPerfect:(void(^)(BOOL isPerfect))perfectBlock toPerfect:(void(^)(void))toPerfectBlock withController:(UIViewController *)viewController;

/**
 用户退出登录

 @param confirmBlock 点击确认后的回调
 @param viewController 弹出的登录
 */
+ (void)userIsLoginOutConfirm:(void(^)(BOOL isLoginOut))confirmBlock withController:(UIViewController *)viewController;

/**
 模型转字典

 @return 字典
 */
- (NSDictionary *)decodeToDic;

/**
 清除登录数据
 */
+ (void)clearAccountInfo;

@end
