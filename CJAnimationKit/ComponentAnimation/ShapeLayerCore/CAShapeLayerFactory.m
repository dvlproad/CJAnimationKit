//
//  CAShapeLayerFactory.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2017/5/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CAShapeLayerFactory.h"

@implementation CAShapeLayerFactory

+ (CAShapeLayer *)circleShapeLayerWithSize:(CGSize)size circleType:(CJCircleType)circleType {
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    layer.path = [CJPathFactory circlePathWithSize:size circleType:circleType];
    layer.fillColor = [UIColor purpleColor].CGColor;
    layer.strokeColor = [UIColor purpleColor].CGColor;
    layer.lineWidth = 1;
    layer.opacity = 0; // 雷达动画用作 sublayer（addSublayer），圆本身不可见，只显示动画；若用作 mask 需手动设置为 1
    layer.position = CGPointMake(size.width / 2, size.height / 2);
    layer.bounds = CGRectMake(0, 0, size.width, size.height);
    
    return layer;
}


#pragma mark - Apply Mask

+ (void)applyMaskToView:(UIView *)view withPath:(CGPathRef)path {
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path;
    maskLayer.frame = view.bounds;
    view.layer.mask = maskLayer;
    [view setNeedsDisplay];
    CGPathRelease(path);
}

@end
