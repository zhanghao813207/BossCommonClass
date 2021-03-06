//
//  NNBUploadManager.m
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/10/17.
//

#import "NNBUploadManager.h"
#import "QHErrorView.h"
#import "UIImage+Category.h"
#import "UIImage+Category.h"
#import "BossBasicDefine.h"

@interface NNBUploadManager()<NSURLSessionDelegate>
@property (nonatomic, strong) QNUploadManager *upLoader;

@end

@implementation NNBUploadManager

+ (__kindof NNBUploadManager *)defaultManager
{
    static NNBUploadManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NNBUploadManager alloc] init];
    });
    return manager;
}

- (void)putData:(NSData *)data key:(NSString *)key token:(NSString *)token progressHandler:(void(^)(NSString *key, float percent))progressHandler complete:(void(^)(QNResponseInfo *info, NSString *key, NSDictionary *resp))complete fail:(void(^)(id error))failBlock
{
    QNUploadOption *percentOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:progressHandler params:nil checkCrc:NO cancellationSignal:^BOOL(){
        return NO;
    }];
    
    [self.upLoader putData:data key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        if (info.error) {
            
            if(failBlock){
                failBlock(info.error);
            }
            [[[QHErrorView alloc] initWithTitle:@"上传失败，请稍后重试"] showInView:[JYCSimpleToolClass getCurrentVC].view];
        } else {
            if (complete) {
                complete(info,key,resp);
            }
        }
    } option:percentOption];
}

/**
 压缩图片
 
 @param image 原图片
 @param proportion 压缩比例
 @return 压缩完的图片
 */
+ (UIImage *)compressionImage:(UIImage *)image proportion:(CGFloat)proportion
{
    // 调整图片的方向
    image = [image fixOrientation];
    UIImage *imageNew;
    // 设置image的尺寸
    CGSize imagesize = CGSizeMake(image.size.width * proportion, image.size.height * proportion);
    // 对图片大小进行压缩
    imageNew = [image scaledImageToSize:imagesize];
    return imageNew;
}

#pragma mark -- lazy property
- (QNUploadManager *)upLoader
{
    
    if (!_upLoader) {
        //        QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
        //            builder.zone = QNFixedZone.zone1;
        //        }];
        //        _upLoader = [[QNUploadManager alloc] initWithConfiguration:config];
        _upLoader = [[QNUploadManager alloc] init];
    }
    return _upLoader;
}


@end
