//
//  KnightMaterialModel.m
//  Pods-BossKnight
//
//  Created by 贾远潮 on 2018/5/23.
//

#import "KnightMaterialModel.h"

@interface KnightMaterialModel()

/**
 支付方式的字符串描述
 */
@property (nonatomic, strong) NSString *paymentTypeString;

/**
 物资状态的字符串
 */
@property (nonatomic, strong) NSString *materialStateString;

@end

@implementation KnightMaterialModel

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value || value == [NSNull null]) {
        return;
    }
    
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

- (NSString *)paymentTypeString
{
    switch (self.payment_way) {
        case PaymentTypeOnce:
            _paymentTypeString = @"一次性支付";
            break;
        case PaymentTypeMonth:
            _paymentTypeString = @"月使用费支付";
            break;
        case PaymentTypeDeposit:
            _paymentTypeString = @"押金支付";
            break;
        default:
            _paymentTypeString = @"暂未支付";
            break;
    }
    return _paymentTypeString;
}

- (NSString *)materialStateString
{
    switch (self.material_state) {
        case MATERIAL_KNIGHT_RECEIPTING:
            _materialStateString = @"待骑士确认收货";
            break;
        case MATERIAL_KNIGHT_RECEIPTED:
            _materialStateString = @"确认收货";
            break;
        case MATERIAL_KNIGHT_REFUNDING:
            _materialStateString = @"退货中";
            break;
        case MATERIAL_KNIGHT_REFUND_DOWN:
            _materialStateString = @"退货完成";
            break;
        case MATERIAL_KNIGHT_REFUND_FAILED:
            _materialStateString = @"退货失败";
            break;
        default:
            _materialStateString = @"物资状态未知";
            break;
    }
    return _materialStateString;
}

@end
