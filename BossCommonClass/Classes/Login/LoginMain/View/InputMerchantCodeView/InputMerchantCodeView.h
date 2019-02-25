//
//  InputMerchantCodeView.h
//  AFNetworking
//
//  Created by 张浩 on 2019/2/18.
//

#import <UIKit/UIKit.h>
UIKIT_EXTERN CGFloat const kInputMerchantCodeViewHeight;

NS_ASSUME_NONNULL_BEGIN

@interface InputMerchantCodeView : UIView

@property (nonatomic, strong) NSString *merchantCode;

/**
 成为第一响应者
 */
- (void)isBecomeFirstResponder;

/**
 释放第一响应着
 */
- (void)resignTheFirstResponder;

/**
 点击了下一步的回调
 @param merchantCode 商户号
 */
@property (nonatomic, copy) void(^nextStepBlock)(NSString *merchantCode);

@end

NS_ASSUME_NONNULL_END
