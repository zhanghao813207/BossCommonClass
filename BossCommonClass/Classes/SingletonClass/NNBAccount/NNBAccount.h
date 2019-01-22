//
//  NNBAccount.h
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/27.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"
#import "ContractBelongModel.h"

@interface NNBAccount : NSObject

+ (__kindof NNBAccount *)defaultAccount;

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
 合同附件ID
 */
@property (nonatomic, strong) NSString *contract_asset_id;

/**
 招聘渠道Id(5001:第三方，5002:个人推荐，5003:其他 5004:转签 5005:内部推荐)
 */
@property (nonatomic, assign) RecruitmentChannelId recruitment_channel_id;

/**
 半身照(照片)
 */
@property (nonatomic, strong) NSString *bust;

/**
 身份证号
 */
@property (nonatomic, strong) NSString *identity_card_id;

/**
 身份证正面照(照片)
 */
@property (nonatomic, strong) NSString *identity_card_front;

/**
 身份证背面照(照片)
 */
@property (nonatomic, strong) NSString *identity_card_back;

/**
 健康证(正面照片)
 */
@property (nonatomic, strong) NSString *health_certificate;

/**
 健康证(背面照片)
 */
@property (nonatomic, strong) NSString *health_certificate_back;

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
 合同照片
 */
@property (nonatomic, strong) NSArray *contract_photo_list;

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
 开户行支行
 */
@property (nonatomic, strong) NSString *bank_branch;

/**
 银行卡正面照(照片)
 */
@property (nonatomic, strong) NSString *bank_card_front;

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
 当前用户是否登录，登录信息是否过期

 @param loginBlock 是否登录
 @param expeiredBlock 登录是否过期（只有登录才会回调是否过期）
 */
+ (void)userIsLogin:(void(^)(BOOL isLogin))loginBlock Expired:(void (^)(BOOL isExpired))expeiredBlock;

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
