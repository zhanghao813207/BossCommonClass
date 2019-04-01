//
//  UIView+Corner.h
//  AFNetworking
//
//  Created by admin on 2019/3/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Corner)
- (void)QH_AddCorner:(CGFloat)radius borwidth:(CGFloat)width backgroundColor:(UIColor *)color borderColor:(UIColor *)color;
- (void)QH_addRounderCornerWithRadius:(CGFloat)radius size:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
