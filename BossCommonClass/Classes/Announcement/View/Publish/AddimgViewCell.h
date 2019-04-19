//
//  AddimgViewCell.h
//  AFNetworking
//
//  Created by admin on 2019/4/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol AddimgViewCellDelegate <NSObject>

/**
 删除图片

 @param image 要删除的图片
 */
- (void)deleteImage:(UIImage *)image;
- (void)clickImg:(UIImage *)image;

@end
@interface AddimgViewCell : UICollectionViewCell
@property(nonatomic, strong)UIImage *image;
@property(nonatomic, weak)id<AddimgViewCellDelegate>delegate;
@property(nonatomic, strong)UIImageView *imgView;
@end

NS_ASSUME_NONNULL_END
