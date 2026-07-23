//
//  CJAnimationFactory.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2017/5/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJAnimationFactory.h"

@implementation CJAnimationFactory

+ (CAAnimationGroup *)cjRadarAnimationWithScale:(CGFloat)scale duration:(CGFloat)duration
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(scale, scale, 1)];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @1;
    alphaAnimation.toValue = @0;
    
    CAAnimationGroup *radarAnimationGroup = [CAAnimationGroup animation];
    radarAnimationGroup.animations = @[scaleAnimation, alphaAnimation];
    radarAnimationGroup.duration = duration;
    radarAnimationGroup.repeatCount = INFINITY;
    radarAnimationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    return radarAnimationGroup;
}

@end
