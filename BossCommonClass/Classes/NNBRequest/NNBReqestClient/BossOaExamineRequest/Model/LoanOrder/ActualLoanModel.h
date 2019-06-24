//
//  ActualLoanModel.h
//  BossCommonClass
//
//  Created by 张浩 on 2019/6/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 实际借款人信息
 */
@interface ActualLoanModel : NSObject

/**
 姓名
 */
@property (nonatomic, strong) NSString *name;

/**
 身份证号
 */
@property (nonatomic, strong) NSString *identity;

/**
 手机号
 */
@property (nonatomic, strong) NSString *phone;

@end

NS_ASSUME_NONNULL_END
