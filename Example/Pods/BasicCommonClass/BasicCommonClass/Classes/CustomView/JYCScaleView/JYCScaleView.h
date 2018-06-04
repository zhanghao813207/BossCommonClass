//
//  JYCScaleView.h
//  JYCScaleView
//
//  Created by 贾远潮 on 2017/9/25.
//

#import <UIKit/UIKit.h>

@interface JYCScaleView : UIView

@property (nonatomic, assign) CGFloat percent;

/**
 *  画弧度
 *
 *  @param startAngle  开始角度
 *  @param endAngle    结束角度
 *  @param lineWitdth  线宽
 *  @param filleColor  扇形填充颜色
 *  @param strokeColor 弧线颜色
 */
-(void)drawArcWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle lineWidth:(CGFloat)lineWitdth fillColor:(UIColor*)filleColor strokeColor:(UIColor*)strokeColor;

/**
 *  画刻度
 *
 *  @param divide      刻度几等分
 *  @param remainder   刻度数
 *  @param strokeColor 轮廓填充颜色
 *  @param fillColor   刻度颜色
 */
//center:中心店，即圆心
//startAngle：起始角度
//endAngle：结束角度
//clockwise：是否逆时针
-(void)drawScaleWithDivide:(int)divide andRemainder:(NSInteger)remainder strokeColor:(UIColor*)strokeColor filleColor:(UIColor*)fillColor scaleLineNormalWidth:(CGFloat)scaleLineNormalWidth scaleLineBigWidth:(CGFloat)scaleLineBigWidth;

/**
 *  进度条曲线
 *
 *  @param fillColor   填充颜色
 *  @param strokeColor 轮廓颜色
 */
- (void)drawProgressCicrleWithfillColor:(UIColor*)fillColor strokeColor:(UIColor*)strokeColor;


@end
