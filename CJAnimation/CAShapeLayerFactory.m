//
//  CAShapeLayerFactory.m
//  CoreAnimationDemo
//
//  Created by 李超前 on 2017/5/19.
//  Copyright © 2017年 李超前. All rights reserved.
//

#import "CAShapeLayerFactory.h"

@implementation CAShapeLayerFactory

+ (CAShapeLayer *)cjCircleShapeLayerForView:(UIView *)view circleType:(CJCircleType)circleType {
    CAShapeLayer *circleShape = [CAShapeLayer layer];
    
    CGFloat width = CGRectGetWidth(view.frame);
    CGFloat height = CGRectGetHeight(view.frame);
    
    CGFloat diameter = 0;   //圆的直径
    if (circleType == CJCircleTypeInscribe) {
        diameter = MIN(width, height);
    } else {
        diameter = sqrt(width*width + height*height);
    }
    CGFloat radius = diameter/2;
    
    CGPoint center = CGPointMake(width/2, height/2);
    CGRect frame = CGRectMake(center.x-radius, center.y-radius, diameter, diameter);
    
    //layer①使用frame的时候，颜色使用backgroundColor设置，②使用path的时候，颜色使用fillColor(填充色)和strokeColor(边框色)设置，边框大小通过lineWidth设置
    //circleShape.frame = frame;
    //circleShape.backgroundColor = [UIColor cyanColor].CGColor;
    
    
    circleShape.path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:radius].CGPath;
    circleShape.fillColor = [UIColor purpleColor].CGColor; //填充色设为透明
    circleShape.strokeColor = [UIColor purpleColor].CGColor;
    circleShape.lineWidth = 1;
    
    circleShape.opacity = 0; //显示的透明度(值为[0-1]，则0为透明即不显示)
    //要使用雷达radar效果的话必须有下面两行代码
    circleShape.position = center;
    circleShape.bounds = frame;
    
    return circleShape;
}

@end
