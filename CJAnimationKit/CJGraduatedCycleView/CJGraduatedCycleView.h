//
//  CJGraduatedCycleView.h
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2018/7/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CJGraduatedCycleView;
@protocol CJGraduatedCycleViewDelegate <NSObject>

//更新label文字
- (void)cjGraduatedCycleView_updateLabelText:(CJGraduatedCycleView *)gradientCycleView;

@end


@interface CJGraduatedCycleView : UIView

@property (nonatomic, weak) id<CJGraduatedCycleViewDelegate> delegate;
@property (nonatomic, strong) CAShapeLayer *upperShapeLayer;  // 外圆的更新的layer(对外提供)
@property (nonatomic, strong) CAShapeLayer *progressLayer;  // 小的进度progressLayer(对外提供)

@property (nonatomic, strong) UILabel *progressLabel;  //  进度文字
@property (nonatomic, assign, readonly) CGFloat labelValue;  // 记录百分比 用于数字跳动

@property (nonatomic, assign, readonly) CGFloat fromValue;
@property (nonatomic, assign, readonly) CGFloat toValue;
@property (nonatomic, assign) CGFloat maxValue;

//- (void)testStartChangeToValue:(CGFloat)toValue;

- (void)changeFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue withAnimationDuration:(CFTimeInterval)animationDuration;

- (void)updateProgressLabelWithAnimation:(BOOL)animation;

@end
