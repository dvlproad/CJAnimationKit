//
//  CQGradientBorderButton.h
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2018/7/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

/**
 渐变边框按钮，通过CAShapeLayer实现边框渐变效果
 
 功能：
 1. 支持自定义边框渐变颜色（绿→红）
 2. 可选磨砂玻璃效果
 */

#import <UIKit/UIKit.h>


@interface CQGradientBorderButton : UIButton {
    
}
@property (nonatomic) UIColor *fullCycleUpStrokeColor;

@property (nonatomic, assign) CGFloat fullCycleLineWidth; // 圆进度的线宽

/**
 初始化渐变边框按钮

 @param cornerRadius 圆角半径
 @param shouldEffect 是否添加磨砂玻璃效果
 @return 渐变边框按钮实例
 */
- (instancetype)initWithCornerRadius:(CGFloat)cornerRadius shouldEffect:(BOOL)shouldEffect NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
+ (instancetype)buttonWithType:(UIButtonType)buttonType NS_UNAVAILABLE;

@end
