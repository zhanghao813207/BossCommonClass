//
//  BOSelectTimeView.h
//  BossKnight
//
//  Created by admin on 2019/7/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^OpenSelectPickViewBlock)(void);

@interface BOSelectTimeView : UIView

@property (nonatomic, copy) NSString *selectTimeStr; //选择的时间
@property (nonatomic, copy) OpenSelectPickViewBlock openSelectBlock; //打开选择时间器
@property (nonatomic, copy) OpenSelectPickViewBlock openSelectDistrictBlock; //打开选择商圈器

- (void)setupDefault:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
