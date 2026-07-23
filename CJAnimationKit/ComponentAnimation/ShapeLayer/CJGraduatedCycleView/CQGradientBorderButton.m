//
//  CQGradientBorderButton.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2018/7/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQGradientBorderButton.h"

@interface CQGradientBorderButton () {
    
}
@property (nonatomic, assign, readonly) CGFloat cornerRadius;
@property (nonatomic, assign, readonly) BOOL shouldEffect;
@property (nonatomic, strong) CAShapeLayer *fullCyclePossibleUpperLayer;  // 小的进度progressLayer(对外提供)

@property (nonatomic, strong) UIVisualEffectView *effectView;

@end


@implementation CQGradientBorderButton

- (instancetype)initWithCornerRadius:(CGFloat)cornerRadius shouldEffect:(BOOL)shouldEffect {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _cornerRadius = cornerRadius;
        _shouldEffect = shouldEffect;
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = cornerRadius;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.fullCycleLineWidth = 2;
    self.fullCycleUpStrokeColor = [UIColor greenColor];
    
    if (self.shouldEffect) {
        self.backgroundColor = [UIColor clearColor]; // 请确保背景色没设置
        [self addSubview:self.effectView];
    }
}

- (UIVisualEffectView *)effectView {
    if (_effectView == nil) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    }
    return _effectView;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIBezierPath *fullCyclePath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.cornerRadius];
    CGColorRef fullUpStrokeColor = self.fullCycleUpStrokeColor.CGColor;
    _fullCyclePossibleUpperLayer = [self createFullCycleShapeLayerWithBezierPath:fullCyclePath strokeColor:fullUpStrokeColor];
    _fullCyclePossibleUpperLayer.strokeStart = 0;
    _fullCyclePossibleUpperLayer.strokeEnd =   1;
    CALayer *actualFullCycleUpperLayer = [self gradientLayerToLayer:_fullCyclePossibleUpperLayer];
    [self.layer addSublayer:actualFullCycleUpperLayer];  // 把bottomlayer 加到自己的layer 上
//
//    UIBezierPath *fullCyclePath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.cornerRadius];
//    _fullCyclePossibleUpperLayer.path = fullCyclePath.CGPath;
//    _fullCyclePossibleUpperLayer.frame = self.bounds;
    
    if (self.effectView) {
        self.effectView.frame = self.bounds;
    }
}


- (CALayer *)gradientLayerToLayer:(CAShapeLayer *)possibleUpperLayer
{
    NSArray *colors = @[(id)[UIColor greenColor].CGColor,
                        (id)[UIColor redColor].CGColor];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colors;
    gradientLayer.shadowPath = possibleUpperLayer.path;
    gradientLayer.frame = possibleUpperLayer.bounds;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    //gradientLayer.locations = @[@0.2, @1];
    
    [gradientLayer setMask:possibleUpperLayer]; // 设置进度layer 颜色 渐变
    
    return gradientLayer;
}


- (CAShapeLayer *)createFullCycleShapeLayerWithBezierPath:(UIBezierPath *)path
                                                   strokeColor:(CGColorRef)strokeColor
{
    NSAssert(strokeColor != nil, @"Error:strokeColor不能为空，否则会导致无法正常添加图层");
    
    CAShapeLayer *graduatedCycleShapeLayer = [[CAShapeLayer alloc] init];
    graduatedCycleShapeLayer.frame = self.bounds;
    
    graduatedCycleShapeLayer.path = path.CGPath;
    //线段的开头为圆角
    graduatedCycleShapeLayer.lineCap = kCALineCapRound;
    
    graduatedCycleShapeLayer.lineWidth = self.fullCycleLineWidth;
    graduatedCycleShapeLayer.strokeColor = strokeColor;
    graduatedCycleShapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    return graduatedCycleShapeLayer;
}




@end
