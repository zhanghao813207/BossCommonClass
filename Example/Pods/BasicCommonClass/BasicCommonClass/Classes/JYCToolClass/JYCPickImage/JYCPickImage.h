//
//  JYCPickImage.h
//  BasicCommonClass
//
//  Created by 贾远潮 on 2018/3/12.
//

#import <Foundation/Foundation.h>

@interface JYCPickImage : NSObject

/**
 拍照获取图片
 
 @param edite 图片是否能够编辑
 @param finishBlock 选取完成回调
 @param cancelBlock 取消选取图片回调
 @param viewController 弹出拍照的控制器
 */
+ (__kindof JYCPickImage *)pickImageFromCameraCanEdite:(BOOL)edite Finish:(void(^)(UIImage *pickImage))finishBlock cancel:(void(^)())cancelBlock viewController:(UIViewController *)viewController;

@end

