//
//  UIAlertController+Extension.m
//  AFNetworking
//
//  Created by admin on 2019/4/16.
//

#import "UIAlertController+Extension.h"

@implementation UIAlertController (Extension)
+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message  Titles:(NSArray *)titles leftClick:(ClickBlcok)left rightClick:(ClickBlcok)right; {
    UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//    NSMutableAttributedString *leftStr = [[NSMutableAttributedString alloc] initWithString:titles.firstObject];
//    [leftStr addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(0, [titles.firstObject length])];
    UIAlertAction *leftAction = [UIAlertAction actionWithTitle:titles.firstObject style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        left(action);
    }];
    [leftAction setValue:[UIColor lightGrayColor] forKey:@"titleTextColor"];
    UIAlertAction *rightAction = [UIAlertAction actionWithTitle:titles.lastObject style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        right(action);
    }];
    [alerVC addAction:leftAction];
    [alerVC addAction:rightAction];
    return alerVC;
}
@end
