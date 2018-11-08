//
//  KnightMaterialModel.h
//  Pods-BossKnight
//
//  Created by 贾远潮 on 2018/5/23.
//

#import <Foundation/Foundation.h>
#import "BossBasicDefine.h"

@interface KnightMaterialModel : NSObject

/**
 物资id
 */
@property (nonatomic, strong) NSString *_id;


/**
 付款方式
 */
@property (nonatomic, assign) PaymentTypes payment_way;

/**
 单号
 */
@property (nonatomic, strong) NSString *order_id;

/**
 操作时间
 */
@property (nonatomic, strong) NSString *created_at;

/**
 物资规格
 */
@property (nonatomic, strong) NSString *material_type;

/**
 操作人手机号
 */
@property (nonatomic, strong) NSString *applicant_phone;

/**
 操作人account_id
 */
@property (nonatomic, strong) NSString *applicant_account_id;

/**
 付款金额(元)
 */
@property (nonatomic, assign) CGFloat purchase_price;

/**
 物资名称
 */
@property (nonatomic, strong) NSString *material_name;

/**
 操作人姓名
 */
@property (nonatomic, strong) NSString *applicant_name;

/**
 物资数量
 */
@property (nonatomic, assign) NSInteger material_amount;

/**
物资状态
 */
@property (nonatomic, assign) MaterialStates material_state;

/**
 支付方式的字符串描述
 */
@property (nonatomic, strong, readonly) NSString *paymentTypeString;

/**
 物资状态的字符串
 */
@property (nonatomic, strong, readonly) NSString *materialStateString;


@end
