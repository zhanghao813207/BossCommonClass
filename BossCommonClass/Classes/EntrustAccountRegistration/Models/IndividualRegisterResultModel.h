//
//  IndividualRegisterResultModel.h
//  BossCommonClass
//
//  Created by 张浩 on 2019/5/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 用户注册结果
 */
@interface IndividualRegisterResultModel : NSObject

/**
 用户注册是否成功
 */
@property (nonatomic, assign) BOOL ok;

/**
 注册成功返回url
 */
@property (nonatomic, strong) NSString * registerUrl;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end

NS_ASSUME_NONNULL_END
