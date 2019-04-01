//
//  InputMessageModel.h
//  AFNetworking
//
//  Created by admin on 2019/3/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,InputType) {
    InputTypeRole = 0,//角色
    InputTypeName,//名字
    InputTypeAge,//年龄
    InputTypeAddress,//所在区域
    InputTypeDetailAddress,//详细地址
    InputTypePhone,//联系方式
    InputTypeWorkState,//工作状态
    InputTypeWorkingExperience,//有无工作经验
    InputTypeIdNumber,//身份证号码
    InputTypeApp_type,//推荐app类型(10: boss骑士 20: boss之家)
};
@interface InputMessageModel : NSObject
@property(nonatomic, assign)InputType type;
@property(nonatomic, copy)NSString *placeholder;
@property(nonatomic, copy)NSString *text;


/**
 是详情还是输入
 */
@property(nonatomic, assign)BOOL isDetail;

/**
 详情页 cell标题头
 */
@property(nonatomic, copy)NSString *title;

/**
 是否要弹出界面(箭头要不要显示)
 */
@property(nonatomic, assign)BOOL isSkip;
+(NSArray *)getModelArr;


//////以下是传给服务器的字段
//internal_recommend_staff_id | ObjectId | N        | 新增页不传，编辑页传                   |
/**
 供应商id
 */
@property(nonatomic, copy)NSString *name;

/**
 年龄
 */
@property(nonatomic, assign)NSInteger age;

/**
 联系电话
 */
@property(nonatomic, copy)NSString *phone;

/**
 省code
 */
@property(nonatomic, assign)NSInteger province;

/**
 市code
 */
@property(nonatomic, assign)NSInteger city;

/**
 区县code
 */
@property(nonatomic, assign)NSInteger area;

/**
 详细地址
 */
@property(nonatomic, copy)NSString *detailed_address;

/**
 推荐职位(1010 骑士)
 */
@property(nonatomic, assign)NSInteger position_id;

/**
 目前工作状态(100 在职 -100 离职)
 */
@property(nonatomic, assign)NSInteger working_state;

/**
  有无工作经验(50 有 -50 无)
 */
@property(nonatomic, assign)NSInteger work_experience;

/**
  身份证号
 */
@property(nonatomic, copy)NSString *identity_card_id;

/**
 推荐app类型(10: boss骑士 20: boss之家)
 */
@property(nonatomic, assign)NSInteger app_type;
@end

NS_ASSUME_NONNULL_END
