//
//  UIView+CQHUDRotationAnimation.m
//  CJAnimationKitDemo
//
//  Created by 李超前 on 2020/12/30.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "UIView+CQHUDRotationAnimation.h"

@implementation UIView (CQHUDRotationAnimation)

- (void)cq_addHUDRotationAnimation {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:6.0*M_PI];
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.duration = 4;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnnimation"];
}

@end
