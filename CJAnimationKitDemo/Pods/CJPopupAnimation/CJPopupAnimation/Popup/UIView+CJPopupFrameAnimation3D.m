//
//  UIView+CJPopupFrameAnimation3D.m
//  CJBaseUIKit
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "UIView+CJPopupFrameAnimation3D.h"

static CGFloat kCJPopupAnimationDuration = 0.3;

@implementation UIView (CJPopupFrameAnimation3D)

/*
 *  弹出视图
 *
 *  @param popupViewShowFrame   popupViewShowFrame
 *  @param isToBottom           isToBottom
 *  @param showComplete         showComplete
 */
- (void)cj_animate3DToShowFrame:(CGRect)popupViewShowFrame
                     isToBottom:(BOOL)isToBottom
                   showComplete:(void(^ _Nullable)(void))showComplete
{
    self.alpha = 1.0f; // 修复单例时候，在隐藏过后，想再显示，没法继续显示的问题
    self.frame = popupViewShowFrame;
    
    CATransform3D popupViewShowTransform = CATransform3DIdentity;
    
    CATransform3D rotate = CATransform3DMakeRotation(70.0*M_PI/180.0, 0.0, 0.0, 1.0);
    CATransform3D translate = CATransform3DMakeTranslation(20.0, -500.0, 0.0);
    CATransform3D popupViewHideTransform = CATransform3DConcat(rotate, translate);
    
    self.layer.transform = popupViewHideTransform;
    [UIView animateWithDuration:kCJPopupAnimationDuration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
         self.layer.transform = popupViewShowTransform;
     } completion:^(BOOL finished) {
        !showComplete ?: showComplete();
    }];
}


- (void)cj_animate3DToHideWithComplete:(void(^ _Nullable)(UIView *bView))hideComplete {
    [UIView animateWithDuration:kCJPopupAnimationDuration delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
         CATransform3D rotate = CATransform3DMakeRotation(-70.0 * M_PI / 180.0, 0.0, 0.0, 1.0);
         CATransform3D translate = CATransform3DMakeTranslation(-20.0, 500.0, 0.0);
        self.layer.transform = CATransform3DConcat(rotate, translate);
         
     } completion:^(BOOL finished) {
         !hideComplete ?: hideComplete(self);
     }];
}



@end
