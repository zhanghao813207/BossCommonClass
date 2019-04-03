//
//  FooterView.h
//  AFNetworking
//
//  Created by admin on 2019/3/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class FooterView;
@protocol FooterViewDelegate <NSObject>

- (void)didButton:(NSString *)typeStr view:(FooterView *)footer;

@end

@interface FooterView : UIView
@property(nonatomic,weak)id<FooterViewDelegate>delegate;
@property(nonatomic, assign)BOOL isEnable;
@end

NS_ASSUME_NONNULL_END
