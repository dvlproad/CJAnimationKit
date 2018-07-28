//
//  PercentGraduatedCycleView.m
//  CoreAnimationDemo
//
//  Created by lichq on 2018/7/27.
//  Copyright © 2018年 李超前. All rights reserved.
//

#import "PercentGraduatedCycleView.h"

@interface PercentGraduatedCycleView ()


@end




@implementation PercentGraduatedCycleView

- (void (^)(void))updateLabelTextBlock {
    __weak typeof(self)weakSelf = self;
    void(^updateLabelTextBlock)(void) = ^{
        NSString *string = [NSString stringWithFormat:@"%.0f%%", weakSelf.toValue];
        weakSelf.progressLabel.text = string;
    };

    return updateLabelTextBlock;
}

- (void)updateLabelWithTimer:(NSTimer *)timer {
    if (self.labelValue >= self.toValue) {
        [timer invalidate];
        timer = nil;
        
        self.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", self.labelValue];
        self.labelValue = 0;
        
    } else {
        self.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", self.labelValue];
    }
    
    self.labelValue ++;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
