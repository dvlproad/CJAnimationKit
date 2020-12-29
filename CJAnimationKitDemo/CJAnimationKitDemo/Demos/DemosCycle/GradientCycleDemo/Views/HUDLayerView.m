//
//  HUDLayerView.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2018/7/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "HUDLayerView.h"
#import "UIView+CQHUDRotationAnimation.h"

@implementation HUDLayerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    if (CGRectEqualToRect(self.frame, CGRectZero) == NO) {
//        [self setupViews];
//    }
}


- (void)setupViews {
//    GradientCycleLayer *hudCycle = [[GradientCycleLayer alloc] initWithSize:110 cycleLineWidth:5];
//    [self.layer addSublayer:hudCycle];
    
    [self cq_addHUDRotationAnimation];
}

- (void)drawRect:(CGRect)rect{
    [[UIColor redColor] set];
    // 创建圆形路径对象
//    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    //创建一个圆环(其他参考文章：[UIBezierPath介绍](https://www.jianshu.com/p/6c9aa9c5dd68))
//    center：弧线圆心坐标
//    radius：弧线半径
//    startAngle：弧线起始角度
//    endAngle：弧线结束角度
//    clockwise：是否顺时针绘制
    CGFloat centerXY = CGRectGetWidth(rect)/2;
    CGFloat radius = centerXY - 5;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerXY, centerXY) radius:radius startAngle:0 endAngle:M_PI_2*3 clockwise:YES];
    
    path.lineWidth     = 5.f;
    path.lineCapStyle  = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    
    [path stroke];
}

@end
