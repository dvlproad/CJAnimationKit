//
//  CJSlideCalculator.h
//  CJPopupAction
//
//  Created by ciyouzen on 2026/7/25.
//
//  弹窗动画的位置计算器，提供两类动画的位置计算：
//  1. 位移动画（Slide）：通过 CGAffineTransform 实现，视图从屏幕边缘滑入
//  2. 展开动画（Expand）：通过 frame 变化实现，视图从某个锚点展开到目标大小

#import <Foundation/Foundation.h>

/// 位移方向：视图从哪个方向滑入
typedef NS_ENUM(NSUInteger, CJSlideFromDirection) {
    CJSlideFromDirectionTop = 0,       // 从上方滑入（向下移动）
    CJSlideFromDirectionBottom,        // 从下方滑入（向上移动）
    CJSlideFromDirectionLeft,          // 从左侧滑入（向右移动）
    CJSlideFromDirectionRight,         // 从右侧滑入（向左移动）
};

@interface CJSlideCalculator : NSObject


/// 计算 hide 状态的 transform（视图从 show 状态平移 offset 到隐藏位置）
/// @param direction 滑入方向（show 状态的反方向）
/// @param offset 移动距离
/// @return hide 状态对应的 CGAffineTransform
+ (CGAffineTransform)hideTransformWithDirection:(CJSlideFromDirection)direction
                                        offset:(CGFloat)offset;

@end
