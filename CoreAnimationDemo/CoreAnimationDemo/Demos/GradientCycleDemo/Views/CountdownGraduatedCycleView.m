//
//  CountdownGraduatedCycleView.m
//  CoreAnimationDemo
//
//  Created by lichq on 2018/7/27.
//  Copyright © 2018年 李超前. All rights reserved.
//

#import "CountdownGraduatedCycleView.h"

@implementation CountdownGraduatedCycleView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self  commonInit];
    }
    
    return self;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self commonInit];
        
    }
    return self;
}

- (void)commonInit {
    __weak typeof(self)weakSelf = self;
    self.updateLabelTextBlock = ^{
        NSInteger leaveSecondCount = (NSInteger)(weakSelf.maxValue - weakSelf.labelValue);
        NSInteger secondValue = leaveSecondCount%60;
        NSInteger minuteValue = leaveSecondCount/60;
        NSString *string = [NSString stringWithFormat:@"%02d:%02d", minuteValue, secondValue];
        weakSelf.progressLabel.text = string;
    };
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.updateLabelTextBlock();
}

- (void)changeFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue withSpeed:(CGFloat)animationSpeed
{
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
