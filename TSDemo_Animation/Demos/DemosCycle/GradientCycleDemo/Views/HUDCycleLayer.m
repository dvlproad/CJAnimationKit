//
//  HUDCycleLayer.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2018/7/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "HUDCycleLayer.h"

@implementation HUDCycleLayer

- (instancetype)initWithSize:(CGFloat)size {
    self = [super init];
    if (self) {
        [self setupLayerWithSizeWidth:size];
    }
    return self;
}

- (void)setupLayerWithSizeWidth:(CGFloat)sizeWidth {
    CGFloat centerXY = sizeWidth/2;
    CGFloat radius = centerXY - 5;
    //创建一个圆环(其他参考文章：[UIBezierPath介绍](https://www.jianshu.com/p/6c9aa9c5dd68))
//    center：弧线圆心坐标
//    radius：弧线半径
//    startAngle：弧线起始角度
//    endAngle：弧线结束角度
//    clockwise：是否顺时针绘制
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerXY, centerXY) radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    //圆环遮罩
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 1.0;
    shapeLayer.lineCap = @"round";
    shapeLayer.lineDashPhase = 0.8;
    shapeLayer.path = bezierPath.CGPath;
    
//    CAAnimationGroup *groupAnnimation = [self getGroupAnnimation];
//    [self addAnimation:groupAnnimation forKey:@"groupAnnimation"];
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:6.0*M_PI];
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.duration = 4;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self addAnimation:rotationAnimation forKey:@"rotationAnnimation"];
}

- (CAAnimationGroup *)getGroupAnnimation {
    CABasicAnimation *rotationAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation2.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation2.toValue = [NSNumber numberWithFloat:6.0*M_PI];
//    rotationAnimation2.autoreverses = YES;
    //    scaleAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation2.repeatCount = 1;
    rotationAnimation2.beginTime = 1; //延时执行，注释掉动画会同时进行
    rotationAnimation2.duration = 2;
    
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:6.0*M_PI];
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.duration = 4;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    
    //组合动画
    CAAnimationGroup *groupAnnimation = [CAAnimationGroup animation];
    groupAnnimation.duration = 2;
    groupAnnimation.autoreverses = NO;
    groupAnnimation.animations = @[rotationAnimation];
    groupAnnimation.repeatCount = MAXFLOAT;
    
    return groupAnnimation;
}

@end
