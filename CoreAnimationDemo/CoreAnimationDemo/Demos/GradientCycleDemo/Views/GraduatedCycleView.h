//
//  GraduatedCycleView.h
//  CoreAnimationDemo
//
//  Created by lichq on 2018/7/27.
//  Copyright © 2018年 李超前. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class GraduatedCycleView;
//@protocol GraduatedCycleViewDelegate
//
////更新label文字
//- (void)graduatedCycleView_updateLabelText:(GraduatedCycleView *)gradientCycleView;
//
//@end


@interface GraduatedCycleView : UIView

//@property (nonatomic, weak) id<GraduatedCycleViewDelegate> delegate;
@property (nonatomic, strong) CAShapeLayer *upperShapeLayer;  // 外圆的更新的layer(对外提供)
@property (nonatomic, strong) CAShapeLayer *progressLayer;  // 小的进度progressLayer(对外提供)

@property (nonatomic, strong) UILabel *progressLabel;  //  进度文字
@property (nonatomic,assign) CGFloat labelValue;  // 记录百分比 用于数字跳动

@property (nonatomic, assign, readonly) CGFloat fromValue;
@property (nonatomic, assign, readonly) CGFloat toValue;
@property (nonatomic, assign) CGFloat maxValue;

@property (nonatomic, copy) void (^updateLabelTextBlock)(void);

//- (void)commonInit;

- (void)changeFromValue:(CGFloat)fromValue
                toValue:(CGFloat)toValue
  withAnimationDuration:(CFTimeInterval)animationDuration;

- (void)updateProgressLabelWithAnimationDuration:(CFTimeInterval)duration;

@end
