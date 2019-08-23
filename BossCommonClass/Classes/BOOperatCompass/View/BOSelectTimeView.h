//
//  BOSelectTimeView.h
//  BossKnight
//
//  Created by admin on 2019/7/19.
//  Copyright © 2019 贾远潮. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^OpenSelectPickViewBlock)(void);

@interface BOSelectTimeView : UIView
@property (nonatomic, copy) NSString *businessDistrictStr; //商圈名字
@property (nonatomic, copy) NSString *selectTimeStr; //选择的时间
@property (nonatomic, copy) OpenSelectPickViewBlock openSelectBlock; //打开选择时间器

@end

NS_ASSUME_NONNULL_END
