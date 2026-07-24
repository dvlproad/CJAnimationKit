//
//  CJPathFactory.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2017/5/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJPathFactory.h"

@implementation CJPathFactory

#pragma mark - Circle

+ (CGPathRef)circlePathWithSize:(CGSize)size circleType:(CJCircleType)circleType {
    CGFloat diameter = 0;
    if (circleType == CJCircleTypeInscribe) {
        diameter = MIN(size.width, size.height);
    } else {
        diameter = sqrt(size.width * size.width + size.height * size.height);
    }
    CGFloat radius = diameter / 2;
    CGFloat centerX = size.width / 2;
    CGFloat centerY = size.height / 2;
    CGRect rect = CGRectMake(centerX - radius, centerY - radius, diameter, diameter);
    
    // UIBezierPath 是 autorelease 对象，.CGPath 归其所有，释放后失效
    // 所以需要 retain 后再返回，调用方使用完毕后需 CGPathRelease()
    CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath;
    CGPathRetain(path);
    return path;
}

#pragma mark - Shape
// 以下方法使用 CGPathCreateMutable() 创建路径，路径归调用方所有，无需 retain
// 调用方使用完毕后需 CGPathRelease()

+ (CGPathRef)arrowPathWithSize:(CGSize)size {
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, size.width - size.height * 0.5, 0.0);
    CGPathAddLineToPoint(path, NULL, size.width, size.height * 0.5);
    CGPathAddLineToPoint(path, NULL, size.width - size.height * 0.5, size.height);
    CGPathAddLineToPoint(path, NULL, 0.0, size.height);
    CGPathCloseSubpath(path);
    
    return path;
}

+ (CGPathRef)halfAnglePathWithSize:(CGSize)size {
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, size.width - size.height * 0.5, 0.0);
    CGPathAddArc(path, NULL, size.width - size.height * 0.5, size.height * 0.5, size.height * 0.5, M_PI_2, M_PI_2 * 3, YES);
    CGPathAddLineToPoint(path, NULL, size.width - size.height * 0.5, size.height);
    CGPathAddLineToPoint(path, NULL, 0.0, size.height);
    CGPathCloseSubpath(path);
    
    return path;
}

+ (CGPathRef)pentagramPathWithSize:(CGSize)size {
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat centerX = size.width * 0.5;
    CGFloat centerY = size.height * 0.5;
    CGFloat radius = MIN(size.width, size.height) * 0.5;
    CGFloat innerRadius = radius * sinf(18 * M_PI / 180) / sinf(54 * M_PI / 180);
    
    CGPathMoveToPoint(path, NULL, centerX, centerY - radius);
    CGPathAddLineToPoint(path, NULL, centerX + sinf(36 * M_PI / 180) * innerRadius, centerY - cosf(36 * M_PI / 180) * innerRadius);
    CGPathAddLineToPoint(path, NULL, centerX + cosf(18 * M_PI / 180) * radius, centerY - sinf(18 * M_PI / 180) * radius);
    CGPathAddLineToPoint(path, NULL, centerX + cosf(18 * M_PI / 180) * innerRadius, centerY + sinf(18 * M_PI / 180) * innerRadius);
    CGPathAddLineToPoint(path, NULL, centerX + cosf(54 * M_PI / 180) * radius, centerY + sinf(54 * M_PI / 180) * radius);
    CGPathAddLineToPoint(path, NULL, centerX, centerY + innerRadius);
    CGPathAddLineToPoint(path, NULL, centerX - cosf(54 * M_PI / 180) * radius, centerY + sinf(54 * M_PI / 180) * radius);
    CGPathAddLineToPoint(path, NULL, centerX - cosf(18 * M_PI / 180) * innerRadius, centerY + sinf(18 * M_PI / 180) * innerRadius);
    CGPathAddLineToPoint(path, NULL, centerX - cosf(18 * M_PI / 180) * radius, centerY - sinf(18 * M_PI / 180) * radius);
    CGPathAddLineToPoint(path, NULL, centerX - sinf(36 * M_PI / 180) * innerRadius, centerY - cosf(36 * M_PI / 180) * innerRadius);
    CGPathCloseSubpath(path);
    
    return path;
}

+ (CGPathRef)heartPathWithSize:(CGSize)size {
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat centerX = size.width * 0.5;
    CGFloat startY = size.height * 0.5 - 5;
    CGFloat endY = size.height * 0.5 + 60;
    
    UIBezierPath *bezier1 = [UIBezierPath bezierPath];
    [bezier1 moveToPoint:CGPointMake(centerX, startY)];
    [bezier1 addCurveToPoint:CGPointMake(centerX, endY)
               controlPoint1:CGPointMake(centerX + 15, startY - 40)
               controlPoint2:CGPointMake(centerX + 80, endY - 50)];
    
    UIBezierPath *bezier2 = [UIBezierPath bezierPath];
    [bezier2 moveToPoint:CGPointMake(centerX, endY)];
    [bezier2 addCurveToPoint:CGPointMake(centerX, startY)
               controlPoint1:CGPointMake(centerX - 80, endY - 50)
               controlPoint2:CGPointMake(centerX - 15, startY - 40)];
    
    CGPathAddPath(path, NULL, bezier1.CGPath);
    CGPathAddPath(path, NULL, bezier2.CGPath);
    CGPathCloseSubpath(path);
    
    return path;
}

+ (CGPathRef)batPathWithSize:(CGSize)size {
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat centerX = size.width * 0.5;
    CGFloat centerY = size.height * 0.5;
    
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    
    [bezier moveToPoint:CGPointMake(centerX - 140, centerY + 40)];
    [bezier addCurveToPoint:CGPointMake(centerX - 10, centerY)
          controlPoint1:CGPointMake(centerX - 90, centerY - 50)
          controlPoint2:CGPointMake(centerX - 30, centerY)];
    [bezier addLineToPoint:CGPointMake(centerX - 5, centerY)];
    [bezier addLineToPoint:CGPointMake(centerX - 10, centerY - 15)];
    [bezier addLineToPoint:CGPointMake(centerX, centerY - 13)];
    [bezier addArcWithCenter:CGPointMake(centerX + 5, centerY - 4) radius:11 startAngle:5.0/3*M_PI endAngle:5.1/3.0*M_PI clockwise:YES];
    [bezier addLineToPoint:CGPointMake(centerX + 18, centerY - 20)];
    [bezier addLineToPoint:CGPointMake(centerX + 20, centerY)];
    [bezier addCurveToPoint:CGPointMake(centerX + 150, centerY - 40)
          controlPoint1:CGPointMake(centerX + 50, centerY - 10)
          controlPoint2:CGPointMake(centerX + 40, centerY - 70)];
    [bezier addArcWithCenter:CGPointMake(centerX + 130, centerY - 15.5) radius:27 startAngle:4.8/3*M_PI endAngle:M_PI clockwise:NO];
    [bezier addArcWithCenter:CGPointMake(centerX + 95, centerY + 10) radius:25 startAngle:4.8/3*M_PI endAngle:M_PI clockwise:NO];
    [bezier addArcWithCenter:CGPointMake(centerX + 65, centerY + 30.5) radius:20 startAngle:4.8/3*M_PI endAngle:M_PI clockwise:NO];
    [bezier addArcWithCenter:CGPointMake(centerX + 35, centerY + 35) radius:10 startAngle:4.8/3*M_PI endAngle:3.2/3.0*M_PI clockwise:NO];
    [bezier addLineToPoint:CGPointMake(centerX + 20, centerY + 45)];
    [bezier addLineToPoint:CGPointMake(centerX + 10, centerY + 35)];
    [bezier addArcWithCenter:CGPointMake(centerX, centerY + 40) radius:10 startAngle:5.3/3*M_PI endAngle:3.5/3.0*M_PI clockwise:NO];
    [bezier addArcWithCenter:CGPointMake(centerX - 30, centerY + 50.5) radius:20 startAngle:5.5/3*M_PI endAngle:4.3/3.0*M_PI clockwise:NO];
    [bezier addArcWithCenter:CGPointMake(centerX - 55, centerY + 44) radius:25 startAngle:5.5/3*M_PI endAngle:4.0/3.0*M_PI clockwise:NO];
    [bezier addArcWithCenter:CGPointMake(centerX - 105, centerY + 45.5) radius:30 startAngle:5.6/3*M_PI endAngle:3.5/3.0*M_PI clockwise:NO];
    
    CGPathAddPath(path, NULL, bezier.CGPath);
    CGPathCloseSubpath(path);
    
    return path;
}

+ (CGPathRef)stampPathWithSize:(CGSize)size {
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat radius = 10;
    
    CGPathMoveToPoint(path, NULL, 0, radius);
    
    for (unsigned i = 0; i < size.width / (radius * 2); i++) {
        CGPathAddArc(path, NULL, radius + i * radius * 2, radius, radius, 0, M_PI, YES);
    }
    CGPathAddArc(path, NULL, size.width - radius, radius, radius, M_PI, M_PI_2 * 3, YES);
    
    for (unsigned i = 0; i < size.height / (radius * 2); i++) {
        CGPathAddArc(path, NULL, size.width - radius, radius * 3 + i * radius * 2, radius, M_PI_2, M_PI_2 * 3, YES);
    }
    CGPathAddArc(path, NULL, size.width - radius, size.height - radius, radius, M_PI_2 * 3, M_PI_2 * 4, YES);
    
    for (unsigned i = 0; i < size.width / (radius * 2); i++) {
        CGPathAddArc(path, NULL, size.width - radius * 3 - i * radius * 2, size.height - radius, radius, M_PI, M_PI * 2, YES);
    }
    CGPathAddArc(path, NULL, radius, size.height - radius, radius, M_PI_2 * 4, M_PI_2 * 5, YES);
    
    for (unsigned i = 0; i < size.height / (radius * 2); i++) {
        CGPathAddArc(path, NULL, radius, size.height - radius * 3 - i * radius * 2, radius, M_PI_2 * 3, M_PI_2 * 5, YES);
    }
    CGPathAddArc(path, NULL, radius, radius, radius, M_PI_2 * 3, M_PI_2 * 4, YES);
    
    CGPathCloseSubpath(path);
    
    return path;
}

@end
