//
//  UIControl+CJRadarAnimation.h
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2017/5/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CJRadarAnimationType) {
    CJRadarAnimationTypeNone,       /**< 没有雷达动画 */
    CJRadarAnimationTypeOnlyDown,   /**< 只有按下的时候才产生 */
    CJRadarAnimationTypeEveryTouch, /**< 每次点击都产生 */
};

@interface UIControl (CJRadarAnimation)

@property (nonatomic, assign) CJRadarAnimationType cjRadarAnimationType;    /**< 设置可添加对应雷达动画 */

@end
