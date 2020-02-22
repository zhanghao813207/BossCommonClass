//
//  NNBBottomAlertView.h
//  NNBarKnight
//
//  Created by 贾远潮 on 2017/10/9.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NNBBottomAlertViewType) {
    NNBBottomAlertViewTypeNormal              = 0,  // 标题
    NNBBottomAlertViewTypeCancelBtn           = 1,  // 带取消按钮
    NNBBottomAlertViewTypeHasIcon             = 2,  // 有图标的
    NNBBottomAlertViewTypeHasSubtitle         = 3,  // 有副标题的
    NNBBottomAlertViewTypeTwoTitle            = 4,  // 左右标题
};

@interface NNBBottomAlertView : UIView

@property (nonatomic, assign) NNBBottomAlertViewType bottomAlertType;


/**
 带标题类型的弹框初始化方法

 @param frame 位置
 @param title 标题
 @param btnTitle 按钮标题
 @param btnClickBlock 按钮被点击的回调
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title buttonTitle:(NSString *)btnTitle buttonClicked:(void(^)(NNBBottomAlertView *view))btnClickBlock;

/**
 带有取消按钮的弹框

 @param frame 位置
 @param title 标题
 @param cancelTitle 取消按钮
 @param btnTitle 其他按钮
 @param cancelBtnClickBlock 取消按钮点击回调
 @param btnClickBlock 按钮点击回调
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle buttonTitle:(NSString *)btnTitle cancelBtnClick:(void(^)(NNBBottomAlertView *view))cancelBtnClickBlock buttonClicked:(void(^)(NNBBottomAlertView *view))btnClickBlock;

/**
 带图标的弹框初始化方法

 @param frame 位置
 @param icon 图标
 @param name 店名
 @param title 提示标题
 @param btnTitle 按钮标题
 @param btnClickBlock 按钮点击的回调
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame icon:(NSString *)icon name:(NSString *)name title:(NSString *)title buttonTitle:(NSString *)btnTitle buttonClicked:(void(^)(NNBBottomAlertView *view))btnClickBlock;

/**
 带图标且标题分左右的弹框初始化方法

 @param frame 位置
 @param icon 图标
 @param name 名字
 @param leftTitle 左标题
 @param rightTitle 右标题
 @param btnTitle 按钮标题
 @param btnClickBlock 按钮点击
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame icon:(NSString *)icon name:(NSString *)name leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle buttonTitle:(NSString *)btnTitle buttonClicked:(void(^)(NNBBottomAlertView *view))btnClickBlock;


/**
 带标题和副标题类型的弹框初始化方法
 
 @param frame 位置
 @param title 标题
 @param subTitle 副标题
 @param btnTitle 按钮标题
 @param btnClickBlock 按钮被点击的回调
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title subTitle:(NSString *)subTitle buttonTitle:(NSString *)btnTitle buttonClicked:(void(^)(NNBBottomAlertView *view))btnClickBlock;

/**
 展示
 */
- (void)show;

/**
 消失

 @param completionBlcok 消失后的回调
 */
- (void)dismissWithCompletion:(void(^)(BOOL complete))completionBlcok;


@end
