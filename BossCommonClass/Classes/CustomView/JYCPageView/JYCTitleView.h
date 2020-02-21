//
//  JYCTitleView.h
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/9/20.
//

#import <UIKit/UIKit.h>
#import "JYCPageStyle.h"

@class JYCTitleView;

@protocol JYCTitleViewDelegate <NSObject>

- (void)JYCTitleView:(JYCTitleView *)titleView DidSelectIndex:(NSInteger)index;

@end

@interface JYCTitleView : UIView

@property (nonatomic, weak) id<JYCTitleViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles pageStyle:(JYCPageStyle *)pageStyle;

- (BOOL)selectTitleWithIndex:(NSInteger)index;

- (void)updateTitle:(NSString *)string index:(NSInteger)index;

@end
