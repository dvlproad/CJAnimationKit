//
//  UIView+CJPopupFrameAnimationNormal.m
//  CJBaseUIKit
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "UIView+CJPopupFrameAnimationNormal.h"
#import <objc/runtime.h>

static CGFloat kCJPopupAnimationDuration = 0.3;
static NSString *cjPopupViewHideFrameStringKey = @"cjPopupViewHideFrameString";

@interface UIView () {
    
}

@property (nonatomic, copy) NSString *cjPopupViewHideFrameString;   /**< 弹出视图隐藏时候的frame */

@end




@implementation UIView (CJPopupFrameAnimationNormal)

//cjPopupViewHideFrameString
- (NSString *)cjPopupViewHideFrameString {
    return objc_getAssociatedObject(self, &cjPopupViewHideFrameStringKey);
}

- (void)setCjPopupViewHideFrameString:(NSString *)cjPopupViewHideFrameString {
    return objc_setAssociatedObject(self, &cjPopupViewHideFrameStringKey, cjPopupViewHideFrameString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/*
 *  弹出视图
 *
 *  @param popupViewShowFrame   popupViewShowFrame
 *  @param isToBottom           isToBottom
 *  @param showComplete         showComplete
 */
- (void)cj_animateNormalToShowFrame:(CGRect)popupViewShowFrame
                         isToBottom:(BOOL)isToBottom
                       showComplete:(void(^ _Nullable)(void))showComplete
{
    CGRect popupViewHideFrame = popupViewShowFrame;
    if (isToBottom) {
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow]; //
        popupViewHideFrame.origin.y = CGRectGetMaxY(keyWindow.frame);
    } else {
        popupViewHideFrame.size.height = 0;
    }
    
    
    self.cjPopupViewHideFrameString = NSStringFromCGRect(popupViewHideFrame);
    
    
    self.frame = popupViewHideFrame;
    [UIView animateWithDuration:kCJPopupAnimationDuration animations:^{
        self.alpha = 1.0f; // 修复单例时候，在隐藏过后，想再显示，没法继续显示的问题
        self.frame = popupViewShowFrame;
        !showComplete ?: showComplete();
     }];
}


- (void)cj_animateNormalToHideWithComplete:(void(^ _Nullable)(UIView *bView))hideComplete {
    CGRect popupViewHideFrame = CGRectFromString(self.cjPopupViewHideFrameString);
    if (CGRectEqualToRect(popupViewHideFrame, CGRectZero)) {
        popupViewHideFrame = self.frame;
    }
    
    [UIView animateWithDuration:kCJPopupAnimationDuration animations:^{
        //要设置成0，不设置非零值如0.2，是为了防止在显示出来的时候，在0.3秒内很快按两次按钮，仍有view存在
        self.alpha = 0.0f;
        self.frame = popupViewHideFrame;
         
     } completion:^(BOOL finished) {
         !hideComplete ?: hideComplete(self);
     }];
}



@end
