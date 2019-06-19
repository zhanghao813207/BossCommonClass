//
//  PayeeAccountModel.h
//  BossCommonClass
//
//  Created by 张浩 on 2019/6/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 收款人账户信息
 */
@interface PayeeAccountModel : NSObject

/**
 银行卡号
 */
@property (nonatomic, strong) NSString *card_num;

/**
 开户支行
 */
@property (nonatomic, strong) NSString *bank_details;

@end

NS_ASSUME_NONNULL_END
