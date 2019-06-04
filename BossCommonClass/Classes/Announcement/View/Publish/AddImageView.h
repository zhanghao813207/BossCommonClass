//
//  AddImageView.h
//  AFNetworking
//
//  Created by admin on 2019/4/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AddImageViewDelegate <NSObject>

- (void)didselectDeleteImage:(UIImage *)image;

@end

@interface AddImageView : UIView
- (void)addImage:(UIImage *)image;
@property(nonatomic, weak)id<AddImageViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
