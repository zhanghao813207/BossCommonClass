//
//  WorkLogicOnceParamModel.h
//  AFNetworking
//
//  Created by 贾远潮 on 2018/11/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorkLogicOnceParamModel : NSObject

@property (nonatomic, assign) NSInteger once_money;

/**
 是否扣款
 */
@property (nonatomic, assign) BOOL auto_dec_option;

/**
 不满足？天
 */
@property (nonatomic, assign) NSInteger when_days;

/**
 每 X 天
 */
@property (nonatomic, assign) NSInteger dec_unit_days;

/**
 扣 ？元
 */
@property (nonatomic, assign) NSInteger dec_unit_money;

@end

NS_ASSUME_NONNULL_END
