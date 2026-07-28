//
//  CAShapeLayerFactory.h
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2017/5/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CJPathFactory.h"

@interface CAShapeLayerFactory : NSObject

/**
 创建圆形图层（用于雷达动画等场景）
 */
+ (CAShapeLayer *)circleShapeLayerWithSize:(CGSize)size circleType:(CJCircleType)circleType;

#pragma mark - Apply Mask

/**
 将 path 应用为视图的 mask（内部会释放 path）
 */
+ (void)applyMaskToView:(UIView *)view withPath:(CGPathRef)path;

@end
