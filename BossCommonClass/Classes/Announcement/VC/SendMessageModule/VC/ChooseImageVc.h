//
//  ChooseImageVc.h
//  BossCommonClass
//
//  Created by 高炀辉 on 2019/7/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^ChooseImageBlock)(UIImage *image);
@interface ChooseImageVc : UIViewController
@property (nonatomic, copy)ChooseImageBlock chooseImageBlock2;
@property (nonatomic, strong)UIImage *image;
@end

NS_ASSUME_NONNULL_END
