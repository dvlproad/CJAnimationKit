//
//  CJGraduatedCycleView+Countdown.h
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2018/7/28.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJGraduatedCycleView.h"

@interface CJGraduatedCycleView (Countdown)

///开始倒计时，完整的倒计时
- (void)beginCountDownWithFull;

///开始倒计时，已经走了多少秒数
- (void)beginCountDownWithGoneSecondCount:(NSInteger)goneSecondCount;

///开始倒计时，当前剩余多少秒数
- (void)beginCountDownWithLeaveSecondCount:(NSInteger)leaveSecondCount;

@end
