//
//  SelectTabbarView.h
//  AFNetworking
//
//  Created by admin on 2019/3/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SelectTabbarView;
@protocol SelectTabbarViewDelegate <NSObject>

- (void)deleteModel:(SelectTabbarView *)view;

- (void)selectModel:(SelectTabbarView *)view;

@end
@interface SelectTabbarView : UIView
@property(nonatomic, weak)id<SelectTabbarViewDelegate>delegate;

/**
 是否全部选中
 */
@property(nonatomic, assign)BOOL isAll;
@end

NS_ASSUME_NONNULL_END
