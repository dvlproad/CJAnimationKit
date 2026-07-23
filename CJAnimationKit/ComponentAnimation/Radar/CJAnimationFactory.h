//
//  CJAnimationFactory.h
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2017/5/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface CJAnimationFactory : NSObject

/**
 *  创建一个雷达动画(大小逐渐变大，颜色逐渐透明)
 *
 *  @param scale    scale
 *  @param duration 单个动画的执行时间
 */
+ (CAAnimationGroup *)cjRadarAnimationWithScale:(CGFloat)scale duration:(CGFloat)duration;

@end
