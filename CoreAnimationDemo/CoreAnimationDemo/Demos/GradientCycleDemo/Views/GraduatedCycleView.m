//
//  GraduatedCycleView.m
//  CoreAnimationDemo
//
//  Created by lichq on 2018/7/27.
//  Copyright © 2018年 李超前. All rights reserved.
//

#import "GraduatedCycleView.h"

#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式

static CGFloat  lineWidth = 25;   // 线宽
static CGFloat  progressLineWidth = 3;  // 外圆进度的线宽


@interface GraduatedCycleView ()

@property (nonatomic, strong) CAShapeLayer *bottomShapeLayer; // 外圆的底层layer
//@property (nonatomic, strong) CAShapeLayer *upperShapeLayer;  // 外圆的更新的layer(对外提供)
@property (nonatomic, strong) CAGradientLayer *gradientLayer;  // 外圆的颜色渐变layer

@property (nonatomic, assign) CGFloat startAngle;  // 开始的弧度
@property (nonatomic, assign) CGFloat endAngle;  // 结束的弧度
@property (nonatomic, assign) CGFloat radius; // 开始角度
@property (nonatomic, assign) CGFloat progressRadius; // 外层的开始角度

@property (nonatomic, assign) CGFloat centerX;  // 中心点 x
@property (nonatomic, assign) CGFloat centerY;  // 中心点 y

@property (nonatomic, strong) CAShapeLayer *progressBottomLayer; // 底部进度条的layer
//@property (nonatomic, strong) CAShapeLayer *progressLayer;  // 小的进度progressLayer(对外提供)
@property (nonatomic, strong) CAGradientLayer *progressGradientLayer; // 小的进度渐变颜色


@property (nonatomic, weak) NSTimer *cycleUpdateTimer;
@property (nonatomic, assign, readonly) CGFloat cycleValue;  // 记录动画圆环值，用于动画

@property (nonatomic, weak) NSTimer *labelUpdateTimer;

@property (nonatomic, assign) CFTimeInterval animationDuration;

@end





@implementation GraduatedCycleView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor blackColor];
    
    
    _startAngle = - 360;  // 启始角度
    _endAngle = 0;  // 结束角度
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    _centerX = width/2;  // 控制圆盘的X轴坐标
    _centerY = height/2; // 控制圆盘的Y轴坐标
    
    
    CGFloat cycleDiameter = MIN(width, height);
    _radius = (cycleDiameter - 1*lineWidth) / 2;  // 内圆的角度
    _progressRadius = (_radius-lineWidth/2) - progressLineWidth - 10; // 外圆的角度
    
    
    /* 1、绘制内环 */
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_centerX, _centerY)
                                                        radius:_radius
                                                    startAngle:degreesToRadians(_startAngle)
                                                      endAngle:degreesToRadians(_endAngle)
                                                     clockwise:YES];
    
    // ①、绘制底部灰色填充layer
    CGColorRef bottomStrokeColor = [UIColor lightGrayColor].CGColor;
    _bottomShapeLayer = [self createGraduatedCycleShapeLayerWithBezierPath:path strokeColor:bottomStrokeColor];
    
    // ②、绘制底部进度显示 layer
    CGColorRef upStrokeColor = [UIColor redColor].CGColor;
    _upperShapeLayer = [self createGraduatedCycleShapeLayerWithBezierPath:path strokeColor:upStrokeColor];
    _upperShapeLayer.strokeStart = 0;
    _upperShapeLayer.strokeEnd =   0;
    
    // ③、绘制颜色渐变 layer
    _gradientLayer = [self createGradientLayerWithBezierPath:path];
    
    [_bottomShapeLayer addSublayer:_gradientLayer]; // 将进度渐变layer 添加到 底部layer 上
    [_gradientLayer setMask:_upperShapeLayer]; // 设置进度layer 颜色 渐变
    
    [self.layer addSublayer:_bottomShapeLayer];  // 添加到底层的layer 上
    
    
    /* 2、绘制外环 */
    [self drawProgressBottomLayer];  // 绘制外圆的底层layer
    
    [self drawProgressLayer];   // 绘制外圆的更新的layer
    
    [self drawProgressGradientLayer]; //  绘制渐变色
    
    [_progressBottomLayer addSublayer:_progressGradientLayer];  // 把更新的layer 添加到 底部的layer 上
    [_progressGradientLayer setMask:_progressLayer]; // 设置渐变色的蒙版为更新的layer
    [self.layer addSublayer:_progressBottomLayer ];  // 把bottomlayer 加到自己的layer 上
    
    
    [self addSubview:self.progressLabel];
//    if (self.delegate) {
//        [self.delegate graduatedCycleView_updateLabelText:self];
//    }
//    if (self.updateLabelTextBlock) {
//        self.updateLabelTextBlock();
//    }
}

- (CAShapeLayer *)createGraduatedCycleShapeLayerWithBezierPath:(UIBezierPath *)path
                                                   strokeColor:(CGColorRef)strokeColor {
    CAShapeLayer *graduatedCycleShapeLayer = [[CAShapeLayer alloc] init];
    graduatedCycleShapeLayer.frame = self.bounds;

    graduatedCycleShapeLayer.path = path.CGPath;
    graduatedCycleShapeLayer.lineCap = kCALineCapButt;
    graduatedCycleShapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:2],[NSNumber numberWithInt:5], nil];
    graduatedCycleShapeLayer.lineWidth = lineWidth;
    graduatedCycleShapeLayer.strokeColor = strokeColor;
    graduatedCycleShapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    return graduatedCycleShapeLayer;
}

//  绘制渐变色的layer
- (CAGradientLayer *)createGradientLayerWithBezierPath:(UIBezierPath *)path
{
    NSMutableArray *colors = [NSMutableArray arrayWithObjects:(id)[UIColor greenColor].CGColor,
                              (id)[UIColor whiteColor].CGColor,
                              (id)[UIColor purpleColor].CGColor,
                              (id)[UIColor redColor].CGColor, nil];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.shadowPath = path.CGPath;
    gradientLayer.frame = self.bounds;
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 0);
    [gradientLayer setColors:colors];
    
    return gradientLayer;
}

- (CAShapeLayer *)drawProgressBottomLayer
{
    _progressBottomLayer                 = [[CAShapeLayer alloc] init];
    _progressBottomLayer.frame           = self.bounds;
    UIBezierPath *path                = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_centerX, _centerY) radius:_progressRadius  startAngle:degreesToRadians(_startAngle) endAngle:degreesToRadians(_endAngle - 5) clockwise:YES];
    _progressBottomLayer.path = path.CGPath;
#pragma mark - 如果想显示为齿轮状态，则打开这段代码
    //    _progressBottomLayer.lineCap = kCALineCapButt;
    //    _progressBottomLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:5],[NSNumber numberWithInt:5], nil];
    
#pragma mark - 线段的开头为圆角
    _progressBottomLayer.lineCap = kCALineCapRound;
    
    _progressBottomLayer.lineWidth = progressLineWidth;
    _progressBottomLayer.strokeColor     = [UIColor clearColor].CGColor;
    _progressBottomLayer.fillColor       = [UIColor clearColor].CGColor;
    return _progressBottomLayer;
}

- (CAShapeLayer *)drawProgressLayer
{
    _progressLayer                 = [[CAShapeLayer alloc] init];
    _progressLayer.frame           = self.bounds;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_centerX, _centerY ) radius:_progressRadius  startAngle:degreesToRadians(_startAngle) endAngle:degreesToRadians(_endAngle - 5)  clockwise:YES];
    _progressLayer.path            = bezierPath.CGPath;
    _progressLayer.strokeStart = 0;
    _progressLayer.strokeEnd =   0;
    //    [self performSelector:@selector(shapeChange) withObject:nil afterDelay:0.3];
    _progressLayer.lineWidth = progressLineWidth;
    
    
#pragma mark - 如果想显示为齿轮状态，则打开这段代码
    //    _progressLayer.lineCap = kCALineCapButt;
    //    _progressLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:5],[NSNumber numberWithInt:5], nil];
    
#pragma mark - 线段的开头为圆角
    _progressLayer.lineCap = kCALineCapRound;
    
    _progressLayer.strokeColor     = [UIColor blueColor].CGColor;
    _progressLayer.fillColor       = [UIColor clearColor].CGColor;
    return _progressLayer;
    
}

- (CAGradientLayer *)drawProgressGradientLayer
{
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_centerX, _centerY ) radius:_progressRadius  startAngle:degreesToRadians(_startAngle)  endAngle:degreesToRadians(_endAngle - 5)  clockwise:YES];
    
    _progressGradientLayer = [CAGradientLayer layer];
    _progressGradientLayer.frame = self.bounds;
    _progressLayer.shadowPath = bezierPath.CGPath;
    
    _progressGradientLayer.colors =  [NSMutableArray arrayWithObjects:(id)[UIColor greenColor].CGColor,(id)[UIColor whiteColor].CGColor,(id)[UIColor purpleColor].CGColor,(id)[UIColor redColor].CGColor, nil];
    
    
    //[_progressGradientLayer setLocations:@[@0.2, @0.5, @0.7, @1]];
    [_progressGradientLayer setStartPoint:CGPointMake(0, 1)];
    [_progressGradientLayer setEndPoint:CGPointMake(1, 0)];
    
    
    return _progressGradientLayer;
}

- (UILabel *)progressLabel {
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc]init];
        
        CGFloat labelWidth = _progressRadius * 2 - 20;
        CGFloat labelHeight = 60;
        _progressLabel.frame = CGRectMake((self.frame.size.width - labelWidth) / 2, _centerY - labelHeight / 2, labelWidth, labelHeight);
        _progressLabel.font = [UIFont systemFontOfSize:40];
        _progressLabel.adjustsFontSizeToFitWidth = YES;
        _progressLabel.minimumScaleFactor = 0.5;
        //_progressLabel.backgroundColor = [UIColor greenColor];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.textColor = [UIColor whiteColor];
        _progressLabel.text = @"";
    }
    
    return _progressLabel;
}


#pragma mark - Event
- (void)testStartChangeToValue:(CGFloat)toValue {
    _toValue = toValue;
    [self performSelector:@selector(shapeChange) withObject:nil afterDelay:0];
}

- (void)shapeChange {
    [self changeFromValue:0 toValue:self.toValue withAnimationDuration:2.0f];
}

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
    _labelValue = fromValue;
    _cycleValue = fromValue;
    
    // 复原
    CGFloat fromPercent = fromValue/self.maxValue;
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [CATransaction setAnimationDuration:0];
    self.upperShapeLayer.strokeEnd = fromPercent ;
    self.progressLayer.strokeEnd = fromPercent;
    [CATransaction commit];
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(graduatedCycleView_updateLabelText:)])
    {
        [self.delegate graduatedCycleView_updateLabelText:self];
    }
    
    
    if (animationDuration > 3) {
        if (self.cycleUpdateTimer) {
            [self.cycleUpdateTimer invalidate];
            self.cycleUpdateTimer = nil;
        }
        
        if (self.cycleUpdateTimer == nil) {
            NSTimer *cycleUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(updateCycleWithTimer:) userInfo:nil repeats:YES];
            [cycleUpdateTimer fire];
            self.cycleUpdateTimer = cycleUpdateTimer;
        }
        
    } else {
        CGFloat toPercent = toValue/self.maxValue;
        [CATransaction begin];
        [CATransaction setDisableActions:NO];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
        [CATransaction setAnimationDuration:animationDuration];
        self.upperShapeLayer.strokeEnd = toPercent;;
        self.progressLayer.strokeEnd = toPercent;;
        [CATransaction commit];
    }
}

- (void)updateCycleWithTimer:(NSTimer *)cycleUpdateTimer {
    CFTimeInterval changeDuration = self.cycleUpdateTimer.timeInterval;
//    [self updateCurrentCycleWithChangeDuration:changeDuration];
//}
//
//- (void)updateCurrentCycleWithChangeDuration:(CFTimeInterval)changeDuration {
    CGFloat fromValue = self.cycleValue;
    
    CGFloat changeValueSpeed = self.animationDuration/(self.toValue - self.fromValue);
    CGFloat changeValueCount = changeDuration / changeValueSpeed;
    CGFloat toValue = fromValue + changeValueCount;
    if (toValue >= self.toValue) {
        toValue = self.toValue;
        changeDuration = (self.toValue - fromValue) * changeValueSpeed;
        
        [self.cycleUpdateTimer invalidate];
        self.cycleUpdateTimer = nil;
    }
    CGFloat toPercent = toValue/self.maxValue;
    
    
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [CATransaction setAnimationDuration:changeDuration];
    self.upperShapeLayer.strokeEnd = toPercent;;
    self.progressLayer.strokeEnd = toPercent;;
    [CATransaction commit];
    
    _cycleValue = toValue;
}


#pragma mark - updateProgressLabel
- (void)updateProgressLabelWithAnimation:(BOOL)animation {
    if (!self.delegate ||
        ![self.delegate respondsToSelector:@selector(graduatedCycleView_updateLabelText:)])
    {
        self.progressLabel.text = NSLocalizedString(@"请实现updateLabelTextBlock", nil);
        return;
    }
    
    if (animation == NO) {
        if (self.labelUpdateTimer) {
            [self.labelUpdateTimer invalidate];
            self.labelUpdateTimer = nil;
        }
        
        return;
    }
    
    
    if (self.toValue == self.fromValue) {
        return;
    }
    BOOL canContinue = (self.toValue > self.fromValue) && (self.fromValue >= 0);
    if (!canContinue) {
        NSLog(@"Error:圆环值变化值范围出错，请检查 %.0f > %.0f", self.toValue, self.fromValue);
        return;
    }
    
    CGFloat changeValueCount = self.toValue -  self.fromValue;
    CFTimeInterval changeValueNeedTime = self.animationDuration;
    CGFloat repateCount = changeValueCount;
    NSTimeInterval timeInterval = changeValueNeedTime/repateCount;
    
    if (self.labelUpdateTimer == nil) {
        NSTimer *labelUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(updateLabelWithTimer:) userInfo:nil repeats:YES];
        [labelUpdateTimer fire];
        self.labelUpdateTimer = labelUpdateTimer;
    }
}

- (void)updateLabelWithTimer:(NSTimer *)labelUpdateTimer {
    if (self.labelValue >= self.toValue) {
        _labelValue = self.toValue;
        
        [labelUpdateTimer invalidate];
        labelUpdateTimer = nil;
        
        [self.delegate graduatedCycleView_updateLabelText:self]; //之前已经判断
        _labelValue = 0;
        
    } else {
        [self.delegate graduatedCycleView_updateLabelText:self]; //之前已经判断
        _labelValue ++;
    }
}

@end
