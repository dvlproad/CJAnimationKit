//
//  UIView+CJZoomFrame.h
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2017/5/22.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CJLayerAddType) {
    CJLayerAddTypeAddSublayer,
    CJLayerAddTypeSetMask,
};

@interface UIView (CJZoomFrame)

/**
 *  在视图上的置顶位置添加一个layer
 *
 *  @param layerFrame           所添加layer的位置(layer的位置是相对于其superView的)
 *  @param layerAnimated        是否要有layer变化的动画（动画为从原本）
 *  @param layerAddType         layer是以什么方式添加的(方式有AddSublayer和SetMask两种)
 *  @param updateFrame          动画结束的时候是否要将当前视图更新到和layerFrame一样的大小
 *  @param subviewSetupBlock    动画结束的时候对本视图的子视图设置(可以为nil)
 */
- (void)cj_addPeiwoLayerWithLayerFrame:(CGRect)layerFrame
                         layerAnimated:(BOOL)layerAnimated
                          layerAddType:(CJLayerAddType)layerAddType
whenAnimationDidStopUpdateFrameToLayerFrame:(BOOL)updateFrame
                andDoSubviewSetupBlock:(void(^)(void))subviewSetupBlock;

@end
