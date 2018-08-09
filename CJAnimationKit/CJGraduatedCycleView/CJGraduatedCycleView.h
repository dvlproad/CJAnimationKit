//
//  CJGraduatedCycleView.h
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2018/7/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CJCycleType) {
    CJCycleTypeGraduated,
    CJCycleTypeFull,
};

@class CJGraduatedCycleView;
@protocol CJGraduatedCycleViewDelegate <NSObject>

@required
/**
 *  通过刻度环目前可能的BottomLayer 获取刻度环最后实际的BottomLayer(可在此方法中对layer做修改)
 *
 *  @param graduatedCyclePossibleBottomLayer 刻度环目前可能的BottomLayer
 *
 *  @return 刻度环最后实际的BottomLayer
 */
- (CALayer *)cjGraduatedCycleView:(CJGraduatedCycleView *)graduatedCycleView actualGraduatedCycleBottomLayerWithPossibleBottomLayer:(CAShapeLayer *)graduatedCyclePossibleBottomLayer;

/**
 *  通过刻度环目前可能的UpperLayer 获取刻度环最后实际的UpperLayer(可在此方法中对layer做修改)
 *
 *  @param graduatedCyclePossibleUpperLayer 刻度环目前可能的底部layer
 *
 *  @return 刻度环最后实际的UpperLayer
 */
- (CALayer *)cjGraduatedCycleView:(CJGraduatedCycleView *)graduatedCycleView actualGraduatedCycleUpperLayerWithPossibleUpperLayer:(CAShapeLayer *)graduatedCyclePossibleUpperLayer;


/**
 *  通过圆满的进度环目前可能的BottomLayer 获取圆满的进度环最后实际的BottomLayer(可在此方法中对layer做修改)
 *
 *  @param fullCyclePossibleBottomLayer 圆满的进度环目前可能的BottomLayer
 *
 *  @return 圆满的进度环最后实际的BottomLayer
 */
- (CALayer *)cjGraduatedCycleView:(CJGraduatedCycleView *)graduatedCycleView actualFullCycleBottomLayerWithPossibleBottomLayer:(CAShapeLayer *)fullCyclePossibleBottomLayer;

/**
 *  通过圆满的进度环目前可能的UpperLayer 获取圆满的进度环最后实际的UpperLayer(可在此方法中对layer做修改)
 *
 *  @param fullCyclePossibleUpperLayer 圆满的进度环目前可能的底部layer
 *
 *  @return 圆满的进度环最后实际的UpperLayer
 */
- (CALayer *)cjGraduatedCycleView:(CJGraduatedCycleView *)graduatedCycleView actualFullCycleUpperLayerWithPossibleUpperLayer:(CAShapeLayer *)fullCyclePossibleUpperLayer;



@optional
//更新label文字
- (void)cjGraduatedCycleView:(CJGraduatedCycleView *)gradientCycleView
updateLabelWithProgressValue:(CGFloat)progressValue;

- (void)cjGraduatedCycleView:(CJGraduatedCycleView *)gradientCycleView
     didFinishUpdateWithInfo:(CGFloat)info;

@end


@interface CJGraduatedCycleView : UIView

@property (nonatomic, weak) id<CJGraduatedCycleViewDelegate> delegate;

@property (nonatomic, strong) CAShapeLayer *graduatedCycleBottomShapeLayer; // 外圆的底层layer
@property (nonatomic, strong) CAShapeLayer *graduatedCycleUpperShapeLayer;  // 外圆的更新的layer(对外提供)
@property (nonatomic, strong) CAShapeLayer *fullCycleBottomLayer; // 底部进度条的layer
@property (nonatomic, strong) CAShapeLayer *fullCycleUpperLayer;  // 小的进度progressLayer(对外提供)
@property (nonatomic, strong) UILabel *progressLabel;  //  进度文字

@property (nonatomic, assign, readonly) CGFloat fromValue;
@property (nonatomic, assign, readonly) CGFloat toValue;

@property (nonatomic) UIColor *graduatedCycleBottomStrokeColor;
@property (nonatomic) UIColor *graduatedCycleUpStrokeColor;
@property (nonatomic) UIColor *fullCycleBottomStrokeColor;
@property (nonatomic) UIColor *fullCycleUpStrokeColor;

@property (nonatomic, assign) CGFloat graduatedCycleLineWidth; // 线宽
@property (nonatomic, assign) CGFloat fullCycleLineWidth; // 圆进度的线宽

@property (nonatomic, assign, readonly) CGFloat maxValue;       /**< 总共多少值 */
@property (nonatomic, assign, readonly) NSInteger dividedCount; /**< 划分成几次来完成(默认1) */

- (void)invalidateTimer;

- (void)setMaxValue:(CGFloat)maxValue dividedCount:(NSInteger)dividedCount;

- (void)changeFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue withAnimationDuration:(CFTimeInterval)animationDuration;

@end
