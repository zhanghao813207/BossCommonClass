//
//  CameraView.h
//  AFNetworking
//
//  Created by admin on 2019/4/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PictureType) {
    PictureTypeCamera = 99,///相机
    PictureTypePhoto///相册
};

@protocol CameraViewDelegate <NSObject>

- (void)pictureSelect:(PictureType)type;

@end

@interface CameraView : UIView
@property(nonatomic, weak)id<CameraViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
