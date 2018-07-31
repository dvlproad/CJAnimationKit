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

@optional
//渐变颜色
- (CAGradientLayer *)cjGraduatedCycleView:(CJGraduatedCycleView *)graduatedCycleView
               gradientLayerForBezierPath:(UIBezierPath *)path;

//更新label文字
- (void)cjGraduatedCycleView:(CJGraduatedCycleView *)gradientCycleView
updateLabelWithProgressValue:(CGFloat)progressValue;

@end


@interface CJGraduatedCycleView : UIView

@property (nonatomic, weak) id<CJGraduatedCycleViewDelegate> delegate;

@property (nonatomic, strong) UILabel *progressLabel;  //  进度文字

@property (nonatomic, assign, readonly) CGFloat fromValue;
@property (nonatomic, assign, readonly) CGFloat toValue;
@property (nonatomic, assign) CGFloat maxValue;

@property (nonatomic) UIColor *graduatedCycleBottomStrokeColor;
@property (nonatomic) UIColor *fullCycleBottomStrokeColor;

@property (nonatomic, assign) CGFloat graduatedCycleLineWidth; // 线宽
@property (nonatomic, assign) CGFloat fullCycleLineWidth; // 圆进度的线宽

- (void)invalidateTimer;

//- (void)testStartChangeToValue:(CGFloat)toValue;

- (void)changeFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue withAnimationDuration:(CFTimeInterval)animationDuration;

@end
