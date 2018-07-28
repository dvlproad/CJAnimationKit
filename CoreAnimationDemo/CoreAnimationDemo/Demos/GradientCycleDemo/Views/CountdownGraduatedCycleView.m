//
//  CountdownGraduatedCycleView.m
//  CoreAnimationDemo
//
//  Created by lichq on 2018/7/27.
//  Copyright © 2018年 李超前. All rights reserved.
//

#import "CountdownGraduatedCycleView.h"

@implementation CountdownGraduatedCycleView

- (void)countDownWithGoneSecondCount:(NSInteger)goneSecondCount {
    CGFloat fromValue = goneSecondCount;
    CGFloat toValue = self.maxValue;
    CGFloat animationSpeed = 1.0f;
    CFTimeInterval animationDuration = animationSpeed * (toValue - fromValue);
    [self changeFromValue:fromValue toValue:toValue withAnimationDuration:animationDuration];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
