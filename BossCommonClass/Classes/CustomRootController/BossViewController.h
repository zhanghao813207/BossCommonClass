//
//  BossViewController.h
//  BasicCommonClass
//
//  Created by 贾远潮 on 2018/3/12.
//

#import <UIKit/UIKit.h>

@interface BossViewController : UIViewController

@property (nonatomic, strong) UIBarButtonItem *customCommentLeftBarButtonItem;
/**
 是否点击屏幕收起键盘 默认可以收起
 */
@property (nonatomic, assign) BOOL packUpKeybordEnable;

- (void)popToLastViewController:(UIBarButtonItem *)sender;

- (UIBarButtonItem *)customCommentLeftBarButtonItem;

@end
