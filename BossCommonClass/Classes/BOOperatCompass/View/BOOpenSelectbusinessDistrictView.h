//
//  BOOpenSelectTimeView.h
//  BossKnight
//
//  Created by admin on 2019/7/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 选择的具体商圈
typedef void(^SureSelectPickViewBlock)(NSString *name,NSString *dizId);

//取消
typedef void(^CanselSelectPickViewBlock)(void);

@interface BOOpenSelectbusinessDistrictView : UIView

@property (nonatomic, copy) SureSelectPickViewBlock sureSelectBlock;

@property (nonatomic, copy) CanselSelectPickViewBlock cancelSelectBlock;

-(void)show;

- (void)remove;

- (void)setupData:(NSArray *)showData;

@end

NS_ASSUME_NONNULL_END
