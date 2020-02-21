//
//  JYCContentView.h
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/21.
//

#import <UIKit/UIKit.h>

@class JYCContentView;

@protocol JYCContentViewDelegate <NSObject>

- (void)JYCContentView:(JYCContentView *)contentView scrollToIndex:(NSInteger)index;

@end

@interface JYCContentView : UIView

@property (nonatomic, weak) id<JYCContentViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray <UIViewController *>*)childVCs parentVC:(UIViewController *)parentVC;

- (void)scrollToIndex:(NSInteger)index;

@end
