//
//  GradientCycleLayer.h
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2018/7/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface GradientCycleLayer : CALayer

- (instancetype)initWithSize:(CGFloat)size cycleLineWidth:(CGFloat)cycleLineWidth NS_DESIGNATED_INITIALIZER;
+ (instancetype)layer NS_UNAVAILABLE;

@end
