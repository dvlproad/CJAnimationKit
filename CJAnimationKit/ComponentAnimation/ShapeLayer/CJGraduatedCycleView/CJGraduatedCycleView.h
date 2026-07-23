//
//  CJGraduatedCycleView.h
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2018/7/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

///圆环类型
typedef NS_ENUM(NSUInteger, CJCycleType) {
    CJCycleTypeGraduated,       /**< 刻度环 */
    CJCycleTypeFull,            /**< 圆满的进度环 */
};

@class CJGraduatedCycleView;
@protocol CJGraduatedCycleViewDelegate <NSObject>

@required
/**
 *  获取指定环最后实际的BottomLayer(可在此方法中对layer做修改)
 *
 *  @param cycleType    圆环类型
 *
 *  @return 指定环最后实际的BottomLayer
 */
- (CALayer *)cjGraduatedCycleView:(CJGraduatedCycleView *)graduatedCycleView
    actualBottomLayerForCycleType:(CJCycleType)cycleType;

/**
 *  获取指定环最后实际的UpperLayer(可在此方法中对layer做修改)
 *
 *  @param cycleType    圆环类型
 *
 *  @return 指定环最后实际的UpperLayer
 */
- (CALayer *)cjGraduatedCycleView:(CJGraduatedCycleView *)graduatedCycleView
     actualUpperLayerForCycleType:(CJCycleType)cycleType;


@optional
//更新label文字
- (void)cjGraduatedCycleView:(CJGraduatedCycleView *)gradientCycleView
updateLabelWithProgressValue:(CGFloat)progressValue;

- (void)cjGraduatedCycleView:(CJGraduatedCycleView *)gradientCycleView
     didFinishUpdateWithInfo:(CGFloat)info;

@end


@interface CJGraduatedCycleView : UIView

@property (nonatomic, weak) id<CJGraduatedCycleViewDelegate> delegate;

@property (nonatomic, strong) CAShapeLayer *graduatedCyclePossibleBottomLayer; // 外圆的底层layer
@property (nonatomic, strong) CAShapeLayer *graduatedCyclePossibleUpperShapeLayer;  // 外圆的更新的layer(对外提供)
@property (nonatomic, strong) CAShapeLayer *fullCyclePossibleBottomLayer; // 底部进度条的layer
@property (nonatomic, strong) CAShapeLayer *fullCyclePossibleUpperLayer;  // 小的进度progressLayer(对外提供)
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
@property (nonatomic, assign, readonly) NSInteger clockwise;    /**< 是否顺时针(默认YES) */

- (void)invalidateTimer;

/**
 *  设置值
 *
 *  @param maxValue     总共多少值
 *  @param dividedCount 划分成几次来完成(默认1)
 *  @param clockwise    是否顺时针(默认YES)，顺时针时候upperLayer越来越多，逆时针时候upperLayer越来越少
 */
- (void)setMaxValue:(CGFloat)maxValue dividedCount:(NSInteger)dividedCount clockwise:(BOOL)clockwise;

- (void)changeFromValue:(CGFloat)fromValue toValue:(CGFloat)toValue withAnimationDuration:(CFTimeInterval)animationDuration;

@end
