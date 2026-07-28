//
//  UIView+CJPopupFrameAnimation3D.h
//  CJBaseUIKit
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CJPopupFrameAnimation3D)

- (void)cj_animate3DToShowFrame:(CGRect)popupViewShowFrame
                     isToBottom:(BOOL)isToBottom
                   showComplete:(void(^ _Nullable)(void))showComplete;


- (void)cj_animate3DToHideWithComplete:(void(^ _Nullable)(UIView *bView))hideComplete;

@end

NS_ASSUME_NONNULL_END
