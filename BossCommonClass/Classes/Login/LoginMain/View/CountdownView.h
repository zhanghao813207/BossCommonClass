//
//  CountdownView.h
//  NNB
//
//  Created by 贾远潮 on 2017/12/7.
//

#import <UIKit/UIKit.h>
@class CountdownView;

typedef NS_ENUM(NSInteger, CountViewStatus) {
    CountViewStatusNomal,
    CountViewStatusBegainCount,
    CountViewStatusCounting,
};

@protocol CountdownViewDelegate <NSObject>

- (void)timeCountDownViewWillStartCount:(CountdownView *)countView;
@optional
- (void)timeCountDownViewDidStartCount:(CountdownView *)countView;
- (void)timeCountDownViewDidFinishedCountDown:(CountdownView *)countView;

@end


@interface CountdownView : UIView

@property (nonatomic, weak) id<CountdownViewDelegate> delegate;

@property (nonatomic, assign) CountViewStatus countViewStatus;

- (instancetype)initWithFrame:(CGRect)frame countTime:(NSInteger)countTime;

@end
