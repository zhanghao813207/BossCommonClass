//
//  IndividualRegisterStateModel.h
//  BossCommonClass
//
//  Created by 张浩 on 2019/5/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 个户注册状态model
 */
@interface IndividualRegisterStateModel : NSObject

/**
 个户注册状态
 10.未完善;20.审核进行中;30.审核通过;40.审核失败;50.审核挂起
 */
@property (nonatomic, assign) NSInteger state;

/**
 当state = 40/50,带出失败原因
 */
@property (nonatomic, strong) NSString * reason;

/**
 统一社会信用编码 当state为审核通过30时,带出此code
 */
@property (nonatomic, strong) NSString * socialCreditCode;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end

NS_ASSUME_NONNULL_END
