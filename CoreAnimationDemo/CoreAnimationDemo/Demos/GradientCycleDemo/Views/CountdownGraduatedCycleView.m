//
//  CountdownGraduatedCycleView.m
//  CoreAnimationDemo
//
//  Created by lichq on 2018/7/27.
//  Copyright © 2018年 李超前. All rights reserved.
//

#import "CountdownGraduatedCycleView.h"

@implementation CountdownGraduatedCycleView

- (void (^)(void))updateLabelTextBlock {
    __weak typeof(self)weakSelf = self;
    void(^updateLabelTextBlock)(void) = ^{
        NSInteger leaveSecondCount = (NSInteger)(weakSelf.maxValue - weakSelf.labelValue);
        NSInteger secondValue = leaveSecondCount%60;
        NSInteger minuteValue = leaveSecondCount/60;
        NSString *string = [NSString stringWithFormat:@"%02d:%02d", minuteValue, secondValue];
        weakSelf.progressLabel.text = string;
    };
    return updateLabelTextBlock;
}


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
