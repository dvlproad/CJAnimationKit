//
//  CJGraduatedCycleView.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2018/7/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJGraduatedCycleView.h"

#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式


@interface CJGraduatedCycleView ()

@property (nonatomic, strong) CAShapeLayer *graduatedCycleBottomShapeLayer; // 外圆的底层layer
@property (nonatomic, strong) CAShapeLayer *graduatedCycleUpperShapeLayer;  // 外圆的更新的layer(对外提供)

@property (nonatomic, assign) CGFloat startAngle;  // 开始的弧度
@property (nonatomic, assign) CGFloat endAngle;  // 结束的弧度
@property (nonatomic, assign) CGFloat radius; // 开始角度
@property (nonatomic, assign) CGFloat progressRadius; // 外层的开始角度

@property (nonatomic, assign) CGFloat centerX;  // 中心点 x
@property (nonatomic, assign) CGFloat centerY;  // 中心点 y

@property (nonatomic, strong) CAShapeLayer *fullCycleBottomLayer; // 底部进度条的layer
@property (nonatomic, strong) CAShapeLayer *fullCycleUpperLayer;  // 小的进度progressLayer(对外提供)


@property (nonatomic, assign, readonly) CGFloat progressValue;  // 记录动画圆环值，用于动画
//@property (nonatomic, weak) NSTimer *cycleUpdateTimer;
//@property (nonatomic, weak) NSTimer *labelUpdateTimer;
@property (nonatomic, weak) NSTimer *minTimer;
@property (nonatomic, assign) BOOL timerAlsoForCycleChange;
@property (nonatomic, assign) CGFloat cumulativeValueInThisRepeat; //当前累积的值

@property (nonatomic, assign) CFTimeInterval animationDuration;
@property (nonatomic, assign, readonly) CGFloat changeValueSpeed; /**< 变化速度 */

@end





@implementation CJGraduatedCycleView

- (void)invalidateTimer {
    if (self.minTimer) {
        [self.minTimer invalidate];
        self.minTimer = nil;
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.graduatedCycleLineWidth = 25;
    self.fullCycleLineWidth = 3;
    
    self.graduatedCycleBottomStrokeColor = [UIColor lightGrayColor];
    self.fullCycleBottomStrokeColor = [UIColor colorWithRed:180/255.0 green:195/255.0 blue:208/255.0 alpha:1]; //#cfd4dd
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    _startAngle = - 360;  // 启始角度
    _endAngle = 0;  // 结束角度
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    _centerX = width/2;  // 控制圆盘的X轴坐标
    _centerY = height/2; // 控制圆盘的Y轴坐标
    
    
    CGFloat cycleDiameter = MIN(width, height);
    _radius = (cycleDiameter - 1*self.graduatedCycleLineWidth) / 2;  // 内圆的角度
    _progressRadius = (_radius-self.graduatedCycleLineWidth/2) - self.fullCycleLineWidth - 10; // 外圆的角度
    
    
    /* 1、绘制内环 */
    UIBezierPath *graduatedCyclePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_centerX, _centerY)
                                                        radius:_radius
                                                    startAngle:degreesToRadians(_startAngle)
                                                      endAngle:degreesToRadians(_endAngle)
                                                     clockwise:YES];
    // ①、绘制底部灰色填充layer
    CGColorRef graduatedCycleBottomStrokeColor = self.graduatedCycleBottomStrokeColor.CGColor;

    _graduatedCycleBottomShapeLayer = [self createGraduatedCycleShapeLayerWithBezierPath:graduatedCyclePath strokeColor:graduatedCycleBottomStrokeColor];
    // ②、绘制底部进度显示 layer
    CGColorRef graduatedCycleUpStrokeColor = [UIColor redColor].CGColor;
    _graduatedCycleUpperShapeLayer = [self createGraduatedCycleShapeLayerWithBezierPath:graduatedCyclePath strokeColor:graduatedCycleUpStrokeColor];
    _graduatedCycleUpperShapeLayer.strokeStart = 0;
    _graduatedCycleUpperShapeLayer.strokeEnd =   0;
    // ③、绘制颜色渐变 layer
    CAGradientLayer *graduatedGradientLayer = [self createGradientLayerWithBezierPath:graduatedCyclePath];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cjGraduatedCycleView:gradientLayerForBezierPath:)]) {
        graduatedGradientLayer = [self.delegate cjGraduatedCycleView:self
                                          gradientLayerForBezierPath:graduatedCyclePath];
    } else {
        graduatedGradientLayer = [self createGradientLayerWithBezierPath:graduatedCyclePath];
    }
    
    // ④、按层次设置①②③
    [_graduatedCycleBottomShapeLayer addSublayer:graduatedGradientLayer]; // 将进度渐变layer 添加到 底部layer 上
    [graduatedGradientLayer setMask:_graduatedCycleUpperShapeLayer]; // 设置进度layer 颜色 渐变
    [self.layer addSublayer:_graduatedCycleBottomShapeLayer];  // 添加到底层的layer 上
    
    
    /* 2、绘制外环 */
    UIBezierPath *fullCyclePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_centerX, _centerY)
                                                                 radius:_progressRadius
                                                             startAngle:degreesToRadians(_startAngle)
                                                               endAngle:degreesToRadians(_endAngle)
                                                              clockwise:YES];
    // ①、绘制外圆的底层layer
    CGColorRef fullBottomStrokeColor = self.fullCycleBottomStrokeColor.CGColor;
    _fullCycleBottomLayer = [self createFullCycleShapeLayerWithBezierPath:fullCyclePath strokeColor:fullBottomStrokeColor];
    _fullCycleBottomLayer.strokeStart = 0;
    _fullCycleBottomLayer.strokeEnd =   1;
    
    // ②、绘制外圆的更新的layer
    CGColorRef fullUpStrokeColor = [UIColor blueColor].CGColor;
    _fullCycleUpperLayer = [self createFullCycleShapeLayerWithBezierPath:fullCyclePath strokeColor:fullUpStrokeColor];
    _fullCycleUpperLayer.strokeStart = 0;
    _fullCycleUpperLayer.strokeEnd =   0;
    //[self performSelector:@selector(shapeChange) withObject:nil afterDelay:0.3];
    //  ③、绘制渐变色
    CAGradientLayer *fullCycleGradientLayer = nil;
    // ④、按层次设置①②③
    if (self.delegate && [self.delegate respondsToSelector:@selector(cjGraduatedCycleView:gradientLayerForBezierPath:)]) {
        fullCycleGradientLayer = [self.delegate cjGraduatedCycleView:self
                                          gradientLayerForBezierPath:fullCyclePath];
    } else {
        fullCycleGradientLayer = [self createGradientLayerWithBezierPath:fullCyclePath];
    }
    [_fullCycleBottomLayer addSublayer:fullCycleGradientLayer];  // 把更新的layer 添加到 底部的layer 上
    [fullCycleGradientLayer setMask:_fullCycleUpperLayer]; // 设置渐变色的蒙版为更新的layer
    
    [self.layer addSublayer:_fullCycleBottomLayer ];  // 把bottomlayer 加到自己的layer 上
    
    
    [self addSubview:self.progressLabel];
}

- (CAShapeLayer *)createGraduatedCycleShapeLayerWithBezierPath:(UIBezierPath *)path
                                                   strokeColor:(CGColorRef)strokeColor
{
    CAShapeLayer *graduatedCycleShapeLayer = [[CAShapeLayer alloc] init];
    graduatedCycleShapeLayer.frame = self.bounds;

    graduatedCycleShapeLayer.path = path.CGPath;
    graduatedCycleShapeLayer.lineCap = kCALineCapButt;
    graduatedCycleShapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:5], nil];
    graduatedCycleShapeLayer.lineWidth = self.graduatedCycleLineWidth;
    graduatedCycleShapeLayer.strokeColor = strokeColor;
    graduatedCycleShapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    return graduatedCycleShapeLayer;
}

- (CAShapeLayer *)createFullCycleShapeLayerWithBezierPath:(UIBezierPath *)path
                                                   strokeColor:(CGColorRef)strokeColor
{
    CAShapeLayer *graduatedCycleShapeLayer = [[CAShapeLayer alloc] init];
    graduatedCycleShapeLayer.frame = self.bounds;
    
    graduatedCycleShapeLayer.path = path.CGPath;
    /*
    //如果想显示为齿轮状态，则打开这段代码
    graduatedCycleShapeLayer.lineCap = kCALineCapButt;
    graduatedCycleShapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:2],[NSNumber numberWithInt:5], nil];
    */
    //线段的开头为圆角
    graduatedCycleShapeLayer.lineCap = kCALineCapRound;
    
    graduatedCycleShapeLayer.lineWidth = self.fullCycleLineWidth;
    graduatedCycleShapeLayer.strokeColor = strokeColor;
    graduatedCycleShapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    return graduatedCycleShapeLayer;
}


//  绘制渐变色的layer
- (CAGradientLayer *)createGradientLayerWithBezierPath:(UIBezierPath *)path
{
    NSArray *colors = @[(id)[UIColor greenColor].CGColor,
                        (id)[UIColor whiteColor].CGColor,
                        (id)[UIColor purpleColor].CGColor,
                        (id)[UIColor redColor].CGColor];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colors;
    gradientLayer.shadowPath = path.CGPath;
    gradientLayer.frame = self.bounds;
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 0);
    //gradientLayer.locations = @[@0.2, @0.5, @0.7, @1];
    
    return gradientLayer;
}

- (UILabel *)progressLabel {
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc]init];
        
        _progressLabel.font = [UIFont systemFontOfSize:40];
        _progressLabel.adjustsFontSizeToFitWidth = YES;
        _progressLabel.minimumScaleFactor = 0.5;
        //_progressLabel.backgroundColor = [UIColor greenColor];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.textColor = [UIColor blackColor];
        _progressLabel.text = @"";
    }
    CGFloat labelWidth = _progressRadius * 2 - 20;
    CGFloat labelHeight = 60;
    _progressLabel.frame = CGRectMake((self.frame.size.width - labelWidth) / 2, _centerY - labelHeight / 2, labelWidth, labelHeight);
    
    return _progressLabel;
}


#pragma mark - Event
//- (void)testStartChangeToValue:(CGFloat)toValue {
//    _toValue = toValue;
//    [self performSelector:@selector(shapeChange) withObject:nil afterDelay:0];
//}
//
//- (void)shapeChange {
//    [self changeFromValue:0 toValue:self.toValue withAnimationDuration:2.0f];
//}

- (void)changeFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue withAnimationDuration:(CFTimeInterval)animationDuration
{
    if (toValue == fromValue) {
        return;
    }
    
    BOOL canContinue = (self.maxValue >= toValue) && (toValue > fromValue) && (fromValue >= 0);
    if (!canContinue) {
        NSLog(@"Error:圆环值设置出错，请检查 %.0f >= %.0f > %.0f", self.maxValue, toValue, fromValue);
        return;
    }
    
    //NSLog(@"开始改变刻度，从%.2f到%.2f", fromValue, toValue);
    _fromValue = fromValue;
    _toValue = toValue;
    _animationDuration = animationDuration;
    _changeValueSpeed = (toValue-fromValue)/animationDuration;
    _progressValue = fromValue;
    
    // 复原
    CGFloat fromPercent = fromValue/self.maxValue;
    [self changeStrokeEnd:fromPercent withAnimationDuration:0];
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
//    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
//    [CATransaction setAnimationDuration:0];
//    self.graduatedCycleUpperShapeLayer.strokeEnd = fromPercent;;
//    self.fullCycleUpperLayer.strokeEnd = fromPercent;
//    [CATransaction commit];
    
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(cjGraduatedCycleView:updateLabelWithProgressValue:)])
    {
        [self.delegate cjGraduatedCycleView:self updateLabelWithProgressValue:self.progressValue];
    }
    
    if (animationDuration <= 3) {
        [self createMinTimerForCycleChange:NO];
        CGFloat actualToPercent = toValue/self.maxValue;
        [self changeStrokeEnd:actualToPercent withAnimationDuration:animationDuration];
        
    } else {
        //设置定时器，开启动画
        [self createMinTimerForCycleChange:YES];
    }
    
}

- (void)createMinTimerForCycleChange:(BOOL)shouldForCycleChange {
    _timerAlsoForCycleChange = shouldForCycleChange;
    
    CGFloat changeValueCount = self.toValue -  self.fromValue;
    CFTimeInterval changeValueNeedTime = self.animationDuration;
    CGFloat shouldUpdateCount = changeValueCount/1; //用多少遍去更新这些要变化的值（这里每次去更新一个值）
    NSTimeInterval timeInterval = changeValueNeedTime/shouldUpdateCount;
    if (self.minTimer) {
        [self.minTimer invalidate];
        self.minTimer = nil;
    }
    if (self.minTimer == nil) {
        //NSLog(@"开始设置定时器");
        [self updateCycleValueWithChangeDuration:timeInterval];
        NSTimer *minTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(updateValueWithMinTimer:) userInfo:nil repeats:YES];
//        [minTimer fire];
        self.minTimer = minTimer;
    }
    _cumulativeValueInThisRepeat = 0;
}



#pragma mark - updateValue
- (void)updateValueWithMinTimer:(NSTimer *)minTimer {
    //NSLog(@"定时器开始执行");
    CFTimeInterval changeDuration = self.minTimer.timeInterval;
    _cumulativeValueInThisRepeat += changeDuration;
    
    CFTimeInterval actualChangeDuration = 0;
    CGFloat possibleToValue = self.progressValue + changeDuration * self.changeValueSpeed;
    //NSLog(@"possibleToValue = %.2f", possibleToValue);
    if (possibleToValue >= self.toValue) {
        actualChangeDuration = (self.toValue - self.progressValue) * self.changeValueSpeed;
        _progressValue = self.toValue;
        if (self.minTimer) {
            [self.minTimer invalidate];
            self.minTimer = nil;
        }
        
    } else {
        actualChangeDuration = changeDuration;
        _progressValue = possibleToValue;
    }
    
    //NSLog(@"progressValue = %.2f", self.progressValue);
    //更新label
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(cjGraduatedCycleView:updateLabelWithProgressValue:)])
    {
        [self.delegate cjGraduatedCycleView:self updateLabelWithProgressValue:self.progressValue];
    }
    
    if (self.timerAlsoForCycleChange) {
        [self updateCycleValueWithChangeDuration:actualChangeDuration];
    }
}

//更新cycle
- (void)updateCycleValueWithChangeDuration:(CFTimeInterval)changeDuration {
    CFTimeInterval actualChangeDuration = 0;
    CGFloat actualToValue = 0;
    CGFloat possibleToValue = self.progressValue + changeDuration * self.changeValueSpeed;
    if (possibleToValue >= self.toValue) {
        actualChangeDuration = (self.toValue - self.progressValue) * self.changeValueSpeed;
        actualToValue = self.toValue;
        
    } else {
        actualChangeDuration = changeDuration;
        actualToValue = possibleToValue;
    }
    

    CGFloat actualToPercent = actualToValue/self.maxValue;
    [self changeStrokeEnd:actualToPercent withAnimationDuration:actualChangeDuration];
}

- (void)changeStrokeEnd:(CGFloat)strokeEnd withAnimationDuration:(CFTimeInterval)animationDuration {
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [CATransaction setAnimationDuration:animationDuration];
    self.graduatedCycleUpperShapeLayer.strokeEnd = strokeEnd;;
    self.fullCycleUpperLayer.strokeEnd = strokeEnd;
    [CATransaction commit];
}



@end
