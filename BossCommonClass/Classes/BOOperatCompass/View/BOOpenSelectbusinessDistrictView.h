//
//  BOOpenSelectTimeView.h
//  BossKnight
//
//  Created by admin on 2019/7/21.
//  Copyright © 2019 贾远潮. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 选择的具体时间
typedef void(^SureSelectPickViewBlock)(NSString *year,NSString *mouth);

//取消
typedef void(^CanselSelectPickViewBlock)(void);

@interface BOOpenSelectbusinessDistrictView : UIView

@property (nonatomic, copy) SureSelectPickViewBlock sureSelectBlock;

@property (nonatomic, copy) CanselSelectPickViewBlock cancelSelectBlock;

-(void)show;

- (void)remove;

@end

NS_ASSUME_NONNULL_END
