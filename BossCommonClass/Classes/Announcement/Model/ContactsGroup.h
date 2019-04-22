//
//  ContactsGroup.h
//  AFNetworking
//
//  Created by admin on 2019/4/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContactsGroup : NSObject
@property(nonatomic, copy)NSString *_id;
@property(nonatomic, copy)NSString *account_id;

/**
 是否消息置顶(true 是 false 否)
 */
@property(nonatomic, assign)BOOL is_pin;

/**
 昵称
 */
@property(nonatomic, copy)NSString *nick_name;

/**
 是否免打扰(true 是 false 否)
 */
@property(nonatomic, assign)NSString *no_disturb;

/**
 关联群组id（群组id/用户id/团队id）
 */
@property(nonatomic, copy)NSString *target_id;

/**
 // 关联类型 (10:群组, 20:点对点, 30:team),
 */
@property(nonatomic, assign)NSInteger target_type;
@property(nonatomic, strong)NSDictionary *target_info;
@end

NS_ASSUME_NONNULL_END
