//
//  PhotoManager.h
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/7/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^chooseImageBlock)(UIImage *image);
@interface PhotoManager : NSObject

@property(nonatomic, copy)chooseImageBlock chooseImageBlock;

+ (PhotoManager *)sharedInstance;

- (void)showPhotoLibary;

- (void)showCamera;


@end

NS_ASSUME_NONNULL_END
