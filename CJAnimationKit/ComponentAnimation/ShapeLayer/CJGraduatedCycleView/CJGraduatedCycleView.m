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


@property (nonatomic, assign) CGFloat startAngle;  // 开始的弧度
@property (nonatomic, assign) CGFloat endAngle;  // 结束的弧度
@property (nonatomic, assign) CGFloat radius; // 开始角度
@property (nonatomic, assign) CGFloat progressRadius; // 外层的开始角度

@property (nonatomic, assign) CGFloat centerX;  // 中心点 x
@property (nonatomic, assign) CGFloat centerY;  // 中心点 y




@property (nonatomic, assign, readonly) CGFloat progressValue;  // 记录动画圆环值，用于动画
@property (nonatomic, weak) NSTimer *minTimer;
@property (nonatomic, assign) BOOL timerAlsoForCycleChange;
@property (nonatomic, assign) CGFloat cumulativeValueInThisRepeat; //当前累积的值

@property (nonatomic, assign) CFTimeInterval animationDuration;
@property (nonatomic, assign, readonly) CGFloat changeValueSpeed; /**< 变化速度 */

@property (nonatomic, assign) NSInteger hasExecCount;   /**< 已经执行了几次 */

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
    
    self.graduatedCycleUpStrokeColor = [UIColor greenColor];
    self.graduatedCycleBottomStrokeColor = [UIColor lightGrayColor];
    
    self.fullCycleUpStrokeColor = [UIColor greenColor];
    self.fullCycleBottomStrokeColor = [UIColor colorWithRed:180/255.0 green:195/255.0 blue:208/255.0 alpha:1]; //#cfd4dd
 
    _dividedCount = 1;
    _clockwise = YES;
}


- (void)setMaxValue:(CGFloat)maxValue dividedCount:(NSInteger)dividedCount clockwise:(BOOL)clockwise {
    _maxValue = maxValue;
    _dividedCount = dividedCount;
    _clockwise = clockwise;
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
    
    
    /* 1、绘制刻度环 */
    UIBezierPath *graduatedCyclePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_centerX, _centerY)
                                                        radius:_radius
                                                    startAngle:degreesToRadians(_startAngle)
                                                      endAngle:degreesToRadians(_endAngle)
                                                     clockwise:YES];
    // ①、绘制bottomLayer及其上的渐变layer
    CGColorRef graduatedCycleBottomStrokeColor = self.graduatedCycleBottomStrokeColor.CGColor;
    _graduatedCyclePossibleBottomLayer = [self createGraduatedCycleShapeLayerWithBezierPath:graduatedCyclePath strokeColor:graduatedCycleBottomStrokeColor];
    
    CALayer *actualGraduatedCycleBottomLayer = [self.delegate cjGraduatedCycleView:self actualBottomLayerForCycleType:CJCycleTypeGraduated];
    [self.layer addSublayer:actualGraduatedCycleBottomLayer]; // 将进度渐变layer 添加到 底部layer 上
    
    
    // ②、绘制upLayer及其上的渐变layer
    CGColorRef graduatedCycleUpStrokeColor = self.graduatedCycleUpStrokeColor.CGColor;
    _graduatedCyclePossibleUpperShapeLayer = [self createGraduatedCycleShapeLayerWithBezierPath:graduatedCyclePath strokeColor:graduatedCycleUpStrokeColor];
    _graduatedCyclePossibleUpperShapeLayer.strokeStart = 0;
    _graduatedCyclePossibleUpperShapeLayer.strokeEnd =   0;
    CALayer *actualGraduatedCycleUpperLayer = [self.delegate cjGraduatedCycleView:self actualUpperLayerForCycleType:CJCycleTypeGraduated];
    [self.layer addSublayer:actualGraduatedCycleUpperLayer];
    
    
    
    /* 2、绘制圆满的进度环 */
    UIBezierPath *fullCyclePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_centerX, _centerY)
                                                                 radius:_progressRadius
                                                             startAngle:degreesToRadians(_startAngle)
                                                               endAngle:degreesToRadians(_endAngle)
                                                              clockwise:YES];
    // ①、绘制bottomLayer及其上的渐变layer
    CGColorRef fullBottomStrokeColor = self.fullCycleBottomStrokeColor.CGColor;
    _fullCyclePossibleBottomLayer = [self createFullCycleShapeLayerWithBezierPath:fullCyclePath strokeColor:fullBottomStrokeColor];
    _fullCyclePossibleBottomLayer.strokeStart = 0;
    _fullCyclePossibleBottomLayer.strokeEnd =   1;
    
    CALayer *actualFullCycleBottomLayer = [self.delegate cjGraduatedCycleView:self actualBottomLayerForCycleType:CJCycleTypeFull];
    [self.layer addSublayer:actualFullCycleBottomLayer];  // 添加到底层的layer 上
    
    
    // ②、绘制upLayer及其上的渐变layer
    CGColorRef fullUpStrokeColor = self.fullCycleUpStrokeColor.CGColor;
    _fullCyclePossibleUpperLayer = [self createFullCycleShapeLayerWithBezierPath:fullCyclePath strokeColor:fullUpStrokeColor];
    _fullCyclePossibleUpperLayer.strokeStart = 0;
    _fullCyclePossibleUpperLayer.strokeEnd =   0;
    CALayer *actualFullCycleUpperLayer = [self.delegate cjGraduatedCycleView:self actualUpperLayerForCycleType:CJCycleTypeFull];
    [self.layer addSublayer:actualFullCycleUpperLayer ];  // 把bottomlayer 加到自己的layer 上
    

    /**< 3、添加label */
    [self addSubview:self.progressLabel];
}

- (CAShapeLayer *)createGraduatedCycleShapeLayerWithBezierPath:(UIBezierPath *)path
                                                   strokeColor:(CGColorRef)strokeColor
{
    NSAssert(strokeColor != nil, @"Error:strokeColor不能为空，否则会导致无法正常添加图层");
    
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
    NSAssert(strokeColor != nil, @"Error:strokeColor不能为空，否则会导致无法正常添加图层");
    
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
    NSInteger everyLoopMaxValue = self.maxValue/self.dividedCount;  /**< 每个循环的最大值 */
    _hasExecCount = fromValue/everyLoopMaxValue;
    
    // 复原
    CGFloat fromPercent = [self getPercentForProgressValue:fromValue];
    [self changeStrokeEnd:fromPercent withAnimationDuration:0];
    
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(cjGraduatedCycleView:updateLabelWithProgressValue:)])
    {
        [self.delegate cjGraduatedCycleView:self updateLabelWithProgressValue:self.progressValue];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ //TODO:不延迟的话，圆环动画会有两个问题①刚进入时候，动画会从0开始，而不是从fromPercent开始；②如果执行完一圈，还要继续执行，会导致会有一个后退的动画。
        if (animationDuration <= 3) {
            [self createMinTimerShouldAlsoForCycleChange:NO];
            CGFloat actualToPercent = [self getPercentForProgressValue:toValue];
            [self changeStrokeEnd:actualToPercent withAnimationDuration:animationDuration];
            
        } else {
            //设置定时器，开启动画
            [self createMinTimerShouldAlsoForCycleChange:YES];
        }
    });
    
    
}

- (CGFloat)getPercentForProgressValue:(NSInteger)progressValue {
//    CGFloat percent = (CGFloat)(progressValue)/self.maxValue; //确保结果是浮点数
    
    NSInteger everyLoopMaxValue = self.maxValue/self.dividedCount;  /**< 每个循环的最大值 */
    NSInteger currentLoopFromValue = progressValue%(everyLoopMaxValue);//确保范围为0-everyLoopMaxValue
    
    CGFloat percent = 0;
    if (currentLoopFromValue == 0) {
        if (progressValue == 0) {
            percent = 0;
        } else {
            percent = 1;
        }
    } else {
        percent = (CGFloat)(currentLoopFromValue)/everyLoopMaxValue; //确保结果是浮点数
    }
    
    if (self.clockwise) {
        return percent;
    } else {
        return 1-percent;
    }
}

- (void)createMinTimerShouldAlsoForCycleChange:(BOOL)shouldAlsoForCycleChange {
    _timerAlsoForCycleChange = shouldAlsoForCycleChange;
    
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
    CGFloat actualToValue = 0;
    CGFloat possibleToValue = self.progressValue + changeDuration * self.changeValueSpeed;
    //NSLog(@"possibleToValue = %.2f", possibleToValue);
    if (possibleToValue >= self.toValue) {
        actualChangeDuration = (self.toValue - self.progressValue) * self.changeValueSpeed;
        actualToValue = self.toValue;
        
    } else {
        actualChangeDuration = changeDuration;
        actualToValue = possibleToValue;
    }
    _progressValue = actualToValue;
    //NSLog(@"progressValue = %.2f", self.progressValue);
    
    if ([self checkCurrentLoopWillFinishAfterThisTime]) {
        _hasExecCount ++;
        if (self.progressValue < self.toValue) { //全部完成的时候不能恢复到0
            [self changeStrokeEnd:0 withAnimationDuration:0];
        }
    }
    
    //更新label
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(cjGraduatedCycleView:updateLabelWithProgressValue:)])
    {
        [self.delegate cjGraduatedCycleView:self updateLabelWithProgressValue:self.progressValue];
    }
    
    
    if (self.timerAlsoForCycleChange) {
        [self updateCycleValueWithChangeDuration:actualChangeDuration];
    }
    
    
    
    
    if (self.progressValue >= self.toValue) {
        if (self.minTimer) {
            [self.minTimer invalidate];
            self.minTimer = nil;
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(cjGraduatedCycleView:didFinishUpdateWithInfo:)]) {
            [self.delegate cjGraduatedCycleView:self didFinishUpdateWithInfo:0];
        }
    }
    
}


- (BOOL)checkCurrentLoopWillFinishAfterThisTime {
//    BOOL isCurrentLoopFinish = self.progressValue >= self.toValue;
    
    NSInteger everyLoopMaxValue = self.maxValue/self.dividedCount;  /**< 每个循环的最大值 */
    NSInteger maxValueAfterThisLoop = (self.hasExecCount+1) * everyLoopMaxValue;
    BOOL isCurrentLoopFinish = self.progressValue >= maxValueAfterThisLoop;
    //NSLog(@"isCurrentLoopFinish = %@, progressValue = %.0f, maxValueAfterThisLoop = %ld", isCurrentLoopFinish ? @"YES":@"NO", self.progressValue, maxValueAfterThisLoop);
    
    return isCurrentLoopFinish;
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
    

    CGFloat actualToPercent = [self getPercentForProgressValue:actualToValue];;
    [self changeStrokeEnd:actualToPercent withAnimationDuration:actualChangeDuration];
}

- (void)changeStrokeEnd:(CGFloat)strokeEnd withAnimationDuration:(CFTimeInterval)animationDuration {
    //NSLog(@"progressValue = %.2f, percent = %.2lf, animationDuration = %.2f", self.progressValue, strokeEnd, animationDuration);
    
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
//    if (animationDuration == 0) {
//        [CATransaction setDisableActions:YES];
//    } else {
//        [CATransaction setDisableActions:NO];
//    }
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [CATransaction setAnimationDuration:animationDuration];
    self.graduatedCyclePossibleUpperShapeLayer.strokeEnd = strokeEnd;;
    self.fullCyclePossibleUpperLayer.strokeEnd = strokeEnd;
    [CATransaction commit];
}



@end
