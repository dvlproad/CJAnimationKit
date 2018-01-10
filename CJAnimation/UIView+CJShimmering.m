//
//  UIView+CJShimmering.m
//  CoreAnimationDemo
//
//  Created by 李超前 on 2017/7/10.
//  Copyright © 2017年 李超前. All rights reserved.
//

#import "UIView+CJShimmering.h"
#import <objc/runtime.h>

@implementation UIView (CJShimmering)

static NSString *cjShimmeringKey = @"cjShimmeringKey";

#pragma mark - runtime
- (BOOL)cjShimmering {
    return [objc_getAssociatedObject(self, &cjShimmeringKey) boolValue];
}


- (void)setCjShimmering:(BOOL)cjShimmering {
    
    
    CAGradientLayer *graLayer = [CAGradientLayer layer];
    graLayer.frame = self.bounds;
    graLayer.colors = @[(__bridge id)[[UIColor greenColor] colorWithAlphaComponent:0.3].CGColor,
                        (__bridge id)[UIColor yellowColor].CGColor,
                        (__bridge id)[[UIColor yellowColor] colorWithAlphaComponent:0.3].CGColor];
    
    graLayer.startPoint = CGPointMake(0, 0);//设置渐变方向起点
    graLayer.endPoint = CGPointMake(1, 0);  //设置渐变方向终点
    graLayer.locations = @[@(0.0), @(0.0), @(0.1)]; //colors中各颜色对应的初始渐变点
    
    // 第二步：通过设置颜色渐变点(locations)动画，达到预期效果
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"locations"];
    animation.duration = 3.0f;
    animation.toValue = @[@(0.9), @(1.0), @(1.0)];
    animation.removedOnCompletion = NO;
    animation.repeatCount = HUGE_VALF;
    animation.fillMode = kCAFillModeForwards;
    [graLayer addAnimation:animation forKey:@"xindong"];
    
    // 最后一步：也是关键一步，将graLayer设置成textLabel的遮罩
    self.layer.mask = graLayer;
}

@end
