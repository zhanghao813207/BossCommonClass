//
//  JYCScaleView.m
//  JYCScaleView
//
//  Created by 贾远潮 on 2017/9/25.
//

#import "JYCScaleView.h"

#define Calculate_radius ((self.bounds.size.height>self.bounds.size.width)?(self.bounds.size.width*0.5-self.lineWidth):(self.bounds.size.height*0.5-self.lineWidth))

#define ScaleViewCenter CGPointMake(self.center.x-self.frame.origin.x, self.center.y-self.frame.origin.y)


@interface JYCScaleView()

/**
 *  圆盘开始角度
 */
@property(nonatomic,assign)CGFloat startAngle;
/**
 *  圆盘结束角度
 */
@property(nonatomic,assign)CGFloat endAngle;
/**
 *  圆盘总共弧度弧度
 */
@property(nonatomic,assign)CGFloat arcAngle;
/**
 *  线宽
 */
@property(nonatomic,assign)CGFloat lineWidth;
/**
 *  刻度值长度
 */
@property(nonatomic,assign)CGFloat scaleValueRadiusWidth;
/**
 *  速度表半径
 */
@property(nonatomic,assign)CGFloat arcRadius;
/**
 *  刻度半径
 */
@property(nonatomic,assign)CGFloat scaleRadius;

/**
 进度条的layer
 */
@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic, strong) UIColor *fillColor;

/**
 小圆点
 */
@property (nonatomic, strong) UIView *circleView;


@end

@implementation JYCScaleView

/**
 *  画弧度
 *
 *  @param startAngle  开始角度
 *  @param endAngle    结束角度
 *  @param lineWitdth  线宽
 *  @param filleColor  扇形填充颜色
 *  @param strokeColor 弧线颜色
 */
-(void)drawArcWithStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle lineWidth:(CGFloat)lineWitdth fillColor:(UIColor*)filleColor strokeColor:(UIColor*)strokeColor{
    //保存弧线宽度,开始角度，结束角度
    self.lineWidth=lineWitdth;
    self.startAngle=startAngle;
    self.endAngle=endAngle;
    self.arcAngle=endAngle-startAngle;
    self.arcRadius=Calculate_radius;
    self.scaleRadius = self.arcRadius-self.lineWidth;
    
    
    UIBezierPath* outArc=[UIBezierPath bezierPathWithArcCenter:ScaleViewCenter radius:self.arcRadius startAngle:startAngle endAngle:endAngle clockwise:YES];
    CAShapeLayer* shapeLayer=[CAShapeLayer layer];
    shapeLayer.lineWidth=lineWitdth;
    shapeLayer.fillColor=filleColor.CGColor;
    shapeLayer.strokeColor=strokeColor.CGColor;
    shapeLayer.path=outArc.CGPath;
    shapeLayer.lineCap=kCALineCapRound;
    [self.layer addSublayer:shapeLayer];
}

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
-(void)drawScaleWithDivide:(int)divide andRemainder:(NSInteger)remainder strokeColor:(UIColor*)strokeColor filleColor:(UIColor*)fillColor scaleLineNormalWidth:(CGFloat)scaleLineNormalWidth scaleLineBigWidth:(CGFloat)scaleLineBigWidth{
    
    CGFloat perAngle=self.arcAngle/divide;
    //我们需要计算出每段弧线的起始角度和结束角度
    //这里我们从- M_PI 开始，我们需要理解与明白的是我们画的弧线与内侧弧线是同一个圆心
    for (NSInteger i = 0; i<= divide; i++) {
        
        CGFloat startAngel = (self.startAngle + perAngle * i) - perAngle / 10;
        CGFloat endAngel   = startAngel + perAngle/5;
        
        CAShapeLayer *perLayer = [CAShapeLayer layer];
        
        if((remainder!=0)&&(i % remainder) == 0) {
            perLayer.strokeColor = strokeColor.CGColor;
            perLayer.lineWidth   = scaleLineBigWidth;
            self.scaleRadius = self.arcRadius + self.lineWidth * 0.5 - scaleLineBigWidth * 0.5;
        }else{
            perLayer.strokeColor = strokeColor.CGColor;;
            perLayer.lineWidth   = scaleLineNormalWidth;
            self.scaleRadius = self.arcRadius + self.lineWidth * 0.5 - scaleLineNormalWidth * 0.5;
        }
        
        [self.layer addSublayer:perLayer];
        
        UIBezierPath *tickPath = [UIBezierPath bezierPathWithArcCenter:ScaleViewCenter radius:self.scaleRadius startAngle:startAngel endAngle:endAngel clockwise:YES];
        
        perLayer.path = tickPath.CGPath;
        
    }
}

/**
 *  进度条曲线
 *
 *  @param fillColor   填充颜色
 *  @param strokeColor 轮廓颜色
 */
- (void)drawProgressCicrleWithfillColor:(UIColor*)fillColor strokeColor:(UIColor*)strokeColor{
    self.fillColor = strokeColor;
    UIBezierPath *progressPath  = [UIBezierPath bezierPathWithArcCenter:ScaleViewCenter radius:self.arcRadius startAngle:self.startAngle endAngle:self.endAngle clockwise:YES];
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    self.progressLayer = progressLayer;
    progressLayer.lineWidth = self.lineWidth;
    progressLayer.fillColor = fillColor.CGColor;
    progressLayer.strokeColor = strokeColor.CGColor;
    progressLayer.path = progressPath.CGPath;
    progressLayer.strokeStart = 0;
    progressLayer.strokeEnd = 0.0;
    progressLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:progressLayer];
   
    [self addSubview:self.circleView];
}

- (void)setPercent:(CGFloat)percent
{
    if (_progressLayer) {
        [UIView animateWithDuration:1 animations:^{
            CGFloat startAngle = self.startAngle + 2 * M_PI * _percent;
            CGFloat endAngle = self.startAngle + 2 * M_PI * percent;
            [self createCircle:startAngle andEndAngle:endAngle];
            self.progressLayer.strokeEnd = percent;
            _percent = percent;
        }];
    }
}

-(void)createCircle:(float)startAngle andEndAngle:(float)endAngle
{
    //创建运动的轨迹动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = 0.25;
    pathAnimation.repeatCount = 1;
    
    //设置运转动画的路径
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathAddArc(curvedPath, NULL, ScaleViewCenter.x, ScaleViewCenter.y, Calculate_radius, startAngle, endAngle, 0);
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    //设置运转的动画
    [self.circleView.layer addAnimation:pathAnimation forKey:@"moveTheCircleOne"];


}

- (UIView *)circleView
{
    if (!_circleView) {
        _circleView = [[UIView alloc] init];
        _circleView.frame = CGRectMake(self.frame.size.width/2, 0, 10, 10);
        [_circleView.layer setCornerRadius:5.f];
        _circleView.layer.masksToBounds = YES;
        _circleView.layer.borderColor = [UIColor whiteColor].CGColor;
        _circleView.layer.borderWidth = 1.f;
        _circleView.backgroundColor = self.fillColor;

    }
    return _circleView;
}



@end
