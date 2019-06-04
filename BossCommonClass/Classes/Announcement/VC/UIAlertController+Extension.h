//
//  UIAlertController+Extension.h
//  AFNetworking
//
//  Created by admin on 2019/4/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
API_AVAILABLE(ios(8.0))
typedef void(^ClickBlcok)(UIAlertAction * _Nonnull action);
@interface UIAlertController (Extension)
+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message  Titles:(NSArray *)titles leftClick:(ClickBlcok)left rightClick:(ClickBlcok)right;
@end

NS_ASSUME_NONNULL_END
