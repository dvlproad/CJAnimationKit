//
//  GradientCycleView.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2018/7/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "GradientCycleView.h"

@interface GradientCycleView ()

@property (nonatomic, strong) CALayer *cycleLayer;

@end;


@implementation GradientCycleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        /* 创建并添加一个图层 */
        CALayer *cycleLayer = [CALayer layer];
        cycleLayer.frame = CGRectMake(0, 0, 110, 110);
        cycleLayer.backgroundColor = [UIColor blueColor].CGColor;
        [self.layer addSublayer:cycleLayer];
        self.cycleLayer = cycleLayer;
        
        [self setupLayer];
    }
    return self;
}

- (void)setupLayer {
    //创建圆环
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(55, 55) radius:50 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    //圆环遮罩
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 1;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineDashPhase = 0.8;
    shapeLayer.path = bezierPath.CGPath;
    
    
    //颜色渐变
    NSMutableArray *colors = [NSMutableArray arrayWithObjects:(id)[UIColor redColor].CGColor,(id)[UIColor whiteColor].CGColor, nil];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.shadowPath = bezierPath.CGPath;
    gradientLayer.frame = CGRectMake(50, 50, 60, 60);
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 0);
    [gradientLayer setColors:[NSArray arrayWithArray:colors]];
    
    
    [self.cycleLayer addSublayer:gradientLayer]; //设置颜色渐变
    [self.cycleLayer setMask:shapeLayer]; //设置圆环遮罩
    
    
    //动画
    CABasicAnimation *scaleAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation1.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation1.toValue = [NSNumber numberWithFloat:1.5];
    scaleAnimation1.autoreverses = YES;
    //    scaleAnimation1.fillMode = kCAFillModeForwards;
    scaleAnimation1.duration = 0.8;
    
    CABasicAnimation *rotationAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation2.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation2.toValue = [NSNumber numberWithFloat:6.0*M_PI];
    rotationAnimation2.autoreverses = YES;
    //    scaleAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation2.repeatCount = MAXFLOAT;
    rotationAnimation2.beginTime = 0.8; //延时执行，注释掉动画会同时进行
    rotationAnimation2.duration = 2;
    
    
    //组合动画
    CAAnimationGroup *groupAnnimation = [CAAnimationGroup animation];
    groupAnnimation.duration = 4;
    groupAnnimation.autoreverses = YES;
    groupAnnimation.animations = @[scaleAnimation1, rotationAnimation2];
    groupAnnimation.repeatCount = MAXFLOAT;
    [self.cycleLayer addAnimation:groupAnnimation forKey:@"groupAnnimation"];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
}


@end
