//
//  UIControl+CJRadarAnimation.m
//  CoreAnimationDemo
//
//  Created by 李超前 on 2017/5/19.
//  Copyright © 2017年 李超前. All rights reserved.
//

#import "UIControl+CJRadarAnimation.h"
#import <objc/runtime.h>

#import "CJAnimationFactory.h"
#import "CAShapeLayerFactory.h"

@interface UIControl ()

@property (nonatomic, strong) CAShapeLayer *cjCircleShapeLayer;

@end

@implementation UIControl (CJRadarAnimation)

static NSString *cjCircleShapeLayerKey = @"cjCircleShapeLayerKey";
static NSString *cjRadarAnimationTypeKey = @"cjRadarAnimationTypeKey";

#pragma mark - runtime
//cjCircleShapeLayer
- (CAShapeLayer *)cjCircleShapeLayer {
    return objc_getAssociatedObject(self, &cjCircleShapeLayerKey);
}

- (void)setCjCircleShapeLayer:(CAShapeLayer *)cjCircleShapeLayer {
    objc_setAssociatedObject(self, &cjCircleShapeLayerKey, cjCircleShapeLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CJRadarAnimationType)cjRadarAnimationType {
    return [objc_getAssociatedObject(self, &cjRadarAnimationTypeKey) integerValue];
}

- (void)setCjRadarAnimationType:(CJRadarAnimationType)cjRadarAnimationType {
    objc_setAssociatedObject(self, &cjRadarAnimationTypeKey, @(cjRadarAnimationType), OBJC_ASSOCIATION_ASSIGN) ;
    
    switch (cjRadarAnimationType) {
        case CJRadarAnimationTypeOnlyDown:
        {
            [self addTarget:self action:@selector(touchDownAction) forControlEvents:UIControlEventTouchDown];
            [self addTarget:self action:@selector(touchUpAction) forControlEvents:UIControlEventTouchUpInside]; //点击事件，其实包含了抬起事件，所以至少需要处理与TouchDown相对应的事件
            break;
        }
        case CJRadarAnimationTypeEveryTouch:
        {
            [self addTarget:self action:@selector(touchDownAction) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
        default:
            break;
    }
}


#pragma mark - 按下操作
- (void)touchDownAction {
    [self performSelector:@selector(addCJRadarAnimation) withObject:nil afterDelay:0.5]; //需要延迟执行，因为有可能它只是点击操作，而不是按住操作
}

- (void)addCJRadarAnimation {
    CAShapeLayer *circleShape = [CAShapeLayerFactory cjCircleShapeLayerForView:self circleType:CJCircleTypeInscribe];
    CAAnimationGroup *radarAnimationGroup = [CJAnimationFactory cjRadarAnimationWithScale:5 duration:3];
    if (self.cjRadarAnimationType == CJRadarAnimationTypeEveryTouch) {
        radarAnimationGroup.repeatCount = 1;
    }
    
    [circleShape addAnimation:radarAnimationGroup forKey:nil];
    [self.layer addSublayer:circleShape];
    
    self.cjCircleShapeLayer = circleShape;
}

#pragma mark - 抬起操作
- (void)touchUpAction {
    //①处理抬起事件
    [self stopAnimation];
    
    //②处理点击事件
    //[[[UIAlertView alloc] initWithTitle:@"点击了按钮" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
}

- (void)stopAnimation {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(addCJRadarAnimation) object:nil];
    
    if (self.cjCircleShapeLayer) {
        [self.cjCircleShapeLayer removeFromSuperlayer];
    }
}




@end
