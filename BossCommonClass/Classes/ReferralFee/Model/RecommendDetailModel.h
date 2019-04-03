//
//  RecommendDetailModel.h
//  AFNetworking
//
//  Created by admin on 2019/4/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecommendDetailModel : NSObject
@property(nonatomic, copy)NSString *_id;

/**
 地址
 */
@property(nonatomic, copy)NSString *address;

/**
 年龄
 */
@property(nonatomic, assign)NSInteger age;
@property(nonatomic, copy)NSString *ageStr;

/**
 推荐app类型(10:boss骑士 20:boss之家)
 */
@property(nonatomic, assign)NSInteger app_type;

/**
  区县code
 */
@property(nonatomic, assign)NSInteger area;

/**
 入职商圈id
 */
@property(nonatomic, copy)NSString *biz_district_id;

/**
 入职商圈名称
 */
@property(nonatomic, copy)NSString *biz_district_name;

/**
 市code
 */
@property(nonatomic, assign)NSInteger city;

/**
 创建时间
 */
@property(nonatomic, copy)NSString *created_at;

/**
 详细地址
 */
@property(nonatomic, copy)NSString *detailed_address;

/**
 入职日期
 */
@property(nonatomic, assign)NSInteger entry_date;

/**
 身份证号
 */
@property(nonatomic, copy)NSString *identity_card_id;

/**
 公司名称
 */
@property(nonatomic, copy)NSString *name;

/**
 联系电话
 */
@property(nonatomic, copy)NSString *phone;

/**
 推荐职位(1010 骑士)
 */
@property(nonatomic, assign)NSInteger position_id;

/**
 省code
 */
@property(nonatomic, assign)NSInteger province;

/**
 内荐费推荐渠道(5005:内部推荐)
 */
@property(nonatomic, assign)NSInteger recommend_channel;

/**
 推荐人id
 */
@property(nonatomic, copy)NSString *recommend_id;

/**
 入职状态 (1:已保存 10:已推荐 100:已入职 )
 */
@property(nonatomic, assign)NSInteger state;

/**
 推荐时间
 */
@property(nonatomic, copy)NSString *submited_at;

/**
 更新时间
 */
@property(nonatomic, copy)NSString *updated_at;

/**
 有无工作经验(50 有 -50 无)
 */
@property(nonatomic, assign)NSInteger work_experience;
@property(nonatomic, copy)NSString *work_experienceStr;

/**
 目前工作状态(100 在职 -100 离职)
 */
@property(nonatomic, assign)NSInteger working_state;
@property(nonatomic, copy)NSString *working_stateStr;
@end

NS_ASSUME_NONNULL_END
