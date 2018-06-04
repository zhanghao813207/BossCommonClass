//
//  UIImage+Category.h
//  CreateQR
//
//  Created by white on 2017/5/24.
//  Copyright © 2017年 white. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

+ (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;

@end

@interface UIImage (EditingImage)

/**对图片尺寸进行压缩*/
- (UIImage*)scaledImageToSize:(CGSize)newSize;
/**对图片方向进行调整*/
- (UIImage *)fixOrientation;

@end
