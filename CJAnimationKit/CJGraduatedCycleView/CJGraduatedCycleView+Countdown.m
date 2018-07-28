//
//  CJGraduatedCycleView+Countdown.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2018/7/28.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJGraduatedCycleView+Countdown.h"

@implementation CJGraduatedCycleView (Countdown)

- (void)countDownWithGoneSecondCount:(NSInteger)goneSecondCount {
    CGFloat fromValue = goneSecondCount;
    CGFloat toValue = self.maxValue;
    CGFloat animationSpeed = 1.0f;
    CFTimeInterval animationDuration = animationSpeed * (toValue - fromValue);
    [self changeFromValue:fromValue toValue:toValue withAnimationDuration:animationDuration];
}

@end
