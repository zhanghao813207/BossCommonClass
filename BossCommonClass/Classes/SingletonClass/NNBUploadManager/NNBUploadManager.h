//
//  NNBUploadManager.h
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/10/17.
//  Copyright © 2017年 贾远潮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QiniuSDK.h"

@interface NNBUploadManager : NSObject

+ (__kindof NNBUploadManager *)defaultManager;

/**
 压缩图片
 
 @param image 原图片
 @param proportion 压缩比例
 @return 压缩完的图片
 */
+ (UIImage *)compressionImage:(UIImage *)image proportion:(CGFloat)proportion;


- (void)putData:(NSData *)data key:(NSString *)key token:(NSString *)token progressHandler:(void(^)(NSString *key, float percent))progressHandler complete:(void(^)(QNResponseInfo *info, NSString *key, NSDictionary *resp))complete;

@end
