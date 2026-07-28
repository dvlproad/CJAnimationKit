//
//  UIView+CJPopupFrameAnimationNormal.h
//  CJBaseUIKit
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CJPopupFrameAnimationNormal)

- (void)cj_animateNormalToShowFrame:(CGRect)popupViewShowFrame
                         isToBottom:(BOOL)isToBottom
                       showComplete:(void(^ _Nullable)(void))showComplete;


- (void)cj_animateNormalToHideWithComplete:(void(^ _Nullable)(UIView *bView))hideComplete;

@end

NS_ASSUME_NONNULL_END
