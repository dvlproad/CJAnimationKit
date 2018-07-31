//
//  UIView+CJZoomFrame.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2017/5/22.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UIView+CJZoomFrame.h"
#import <objc/runtime.h>

@interface UIView ()<CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *cjMaskLayer;
@property (nonatomic, assign) CGRect cjMaskLayerFrame;
@property (nonatomic, assign) CJLayerAddType cjLayerAddType;
@property (nonatomic, copy) void (^cjSubviewSetupBlockWhenAnimationDidStop)(void);

@end


@implementation UIView (CJZoomFrame)

static NSString *cjMaskLayerKey = @"cjMaskLayerKey";
static NSString *cjMaskLayerFrameStringKey = @"cjMaskLayerFrameStringKey";
static NSString *cjLayerAddTypeKey = @"cjLayerAddTypeKey";
static NSString *cjSubviewSetupBlockWhenAnimationDidStopKey = @"cjSubviewSetupBlockWhenAnimationDidStopKey";


#pragma mark - runtime
//cjMaskLayer
- (CAShapeLayer *)cjMaskLayer {
    return objc_getAssociatedObject(self, &cjMaskLayerKey);
}

- (void)setCjMaskLayer:(CAShapeLayer *)cjMaskLayer {
    objc_setAssociatedObject(self, &cjMaskLayerKey, cjMaskLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//cjMaskLayerFrame
- (CGRect)cjMaskLayerFrame {
    return CGRectFromString(objc_getAssociatedObject(self, &cjMaskLayerFrameStringKey));
}

- (void)setCjMaskLayerFrame:(CGRect)cjMaskLayerFrame {
    objc_setAssociatedObject(self, &cjMaskLayerFrameStringKey, NSStringFromCGRect(cjMaskLayerFrame), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//cjMaskLayer
- (CJLayerAddType)cjLayerAddType {
    return [objc_getAssociatedObject(self, &cjLayerAddTypeKey) integerValue];
}


- (void)setCjLayerAddType:(CJLayerAddType)cjLayerAddType {
    objc_setAssociatedObject(self, &cjLayerAddTypeKey, @(cjLayerAddType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//cjSubviewSetupBlockWhenAnimationDidStop
- (void (^)(void))cjSubviewSetupBlockWhenAnimationDidStop {
    return objc_getAssociatedObject(self, &cjSubviewSetupBlockWhenAnimationDidStopKey);
}

- (void)setCjSubviewSetupBlockWhenAnimationDidStop:(void (^)(void))cjSubviewSetupBlockWhenAnimationDidStop {
    objc_setAssociatedObject(self, &cjSubviewSetupBlockWhenAnimationDidStopKey, cjSubviewSetupBlockWhenAnimationDidStop, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (void)removeAddedLayer {
    if (self.cjMaskLayer) {
        [self.cjMaskLayer removeFromSuperlayer];
    }
}


/**
 *  在视图上的置顶位置添加一个layer(直接添加，不会有任何动画)
 *
 *  @param layerFrame           所添加layer的位置(layer的位置是相对于其superView的)
 */
- (void)cj_addPeiwoLayerWithLayerFrame:(CGRect)layerFrame {
    [self cj_addPeiwoLayerWithLayerFrame:layerFrame
                           layerAnimated:NO
                            layerAddType:self.cjLayerAddType
whenAnimationDidStopUpdateFrameToLayerFrame:NO
                  andDoSubviewSetupBlock:self.cjSubviewSetupBlockWhenAnimationDidStop];//确保之前设置的block不会被改变
}

/* 完整的描述请参见文件头部 */
- (void)cj_addPeiwoLayerWithLayerFrame:(CGRect)layerFrame
                         layerAnimated:(BOOL)layerAnimated
                          layerAddType:(CJLayerAddType)layerAddType
whenAnimationDidStopUpdateFrameToLayerFrame:(BOOL)updateFrame
    andDoSubviewSetupBlock:(void(^)(void))subviewSetupBlock
{
    [self removeAddedLayer]; //防止重复添加
    
    CGRect finalFrame = layerFrame;
    UIBezierPath *finalBezierPath = [UIBezierPath bezierPathWithOvalInRect:finalFrame];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = finalBezierPath.CGPath;
    
    if (layerAddType == CJLayerAddTypeSetMask) {
        [self.layer setMask:maskLayer];     //二者选其一
    } else {
        [self.layer addSublayer:maskLayer]; //二者选其一
    }
    
    if (layerAnimated) {
        CGRect startFrame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        UIBezierPath *startBezierPath =  [UIBezierPath bezierPathWithOvalInRect:startFrame];
        
        //添加layer的动画
        CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        maskLayerAnimation.fromValue = (__bridge id)(startBezierPath.CGPath);
        maskLayerAnimation.toValue = (__bridge id)((finalBezierPath.CGPath));
        maskLayerAnimation.duration = 5.0f;
        
        if (updateFrame) {
            maskLayerAnimation.delegate = self;
        }
        
        //防止动画结束后回到初始状态,只需设置removedOnCompletion、fillMode两个属性就可以了(参考：CABasicAnimation使用总结http://www.jianshu.com/p/02c341c748f9)
        maskLayerAnimation.removedOnCompletion = NO;
        maskLayerAnimation.fillMode = kCAFillModeForwards;
        
        [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    }
    
    self.cjMaskLayer = maskLayer;
    self.cjMaskLayerFrame = layerFrame;
    self.cjLayerAddType = layerAddType;
    self.cjSubviewSetupBlockWhenAnimationDidStop = subviewSetupBlock;
}



- (void)animationDidStart:(CAAnimation *)anim {
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    //本视图的缩放动画结束之后，需要
    //需要：①再次设置其frame，使得其与缩放最后的大小一致，还要位置也要一致。这样才能使得本视图不会由于遮挡到后面的视图而影响到了后面视图的一些点击操作
    CGRect layerFrame = self.cjMaskLayerFrame;
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect windowSubviewFrameInKeyWindow = [self convertRect:layerFrame toView:keyWindow];
    [self setFrame:windowSubviewFrameInKeyWindow];
    
    //需要：②由于重新设置了本视图的frame，所以本视图上的layer位置也需要重新设置(虽然大小不用变）
    //方法①：移动self.cjMaskLayer的frame，但会有动画生成，所以不采用此方法
    //CGRect layerFrame3 = CGRectMake(-CGRectGetMinX(layerFrame), -CGRectGetMinY(layerFrame), CGRectGetWidth(layerFrame), CGRectGetHeight(layerFrame));
    //[self.cjMaskLayer setFrame:layerFrame3];
    
    //方法②：删除旧的layer，重新生成满足条件的layer
    CGRect layerFrame2 = CGRectMake(0, 0, CGRectGetWidth(layerFrame), CGRectGetHeight(layerFrame));
    [self cj_addPeiwoLayerWithLayerFrame:layerFrame2];
    
    if (self.cjSubviewSetupBlockWhenAnimationDidStop) {
        self.cjSubviewSetupBlockWhenAnimationDidStop();
    }
}




@end
