//
//  ShimmerAnimationViewController.h
//  CJAnimationKitDemo
//
//  Created by lichaoqian on 17/6/13.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Shimmer/FBShimmeringView.h>
#import <Shimmer/FBShimmeringLayer.h>
//! @abstract Set this to YES to start shimming and NO to stop. Defaults to NO.
// 是否闪烁
//@property (nonatomic, assign, readwrite, getter = isShimmering) BOOL shimmering;

//! @abstract The time interval between shimmerings in seconds. Defaults to 0.4.
// 两次闪烁之间的间隔
//@property (assign, nonatomic, readwrite) CFTimeInterval shimmeringPauseDuration;

//! @abstract The opacity of the content while it is shimmering. Defaults to 1.0.
// 闪烁时动画的透明度 1.0就是原始亮度   0-1之间随意选择
//@property (assign, nonatomic, readwrite) CGFloat shimmeringAnimationOpacity;

//! @abstract The opacity of the content before it is shimmering. Defaults to 0.5.
// 闪烁前的透明度，例如默认0.5，那么和上面那个参数对比下，就是0.5-1之间闪烁
//@property (assign, nonatomic, readwrite) CGFloat shimmeringOpacity;

//! @abstract The speed of shimmering, in points per second. Defaults to 230.
// 闪烁的速度
//@property (assign, nonatomic, readwrite) CGFloat shimmeringSpeed;

//! @abstract The highlight length of shimmering. Range of [0,1], defaults to 0.33.
// 闪烁过去的时候那条线的宽度 0 - 1之间的浮点数切换
//@property (assign, nonatomic, readwrite) CGFloat shimmeringHighlightLength;

//! @abstract @deprecated Same as "shimmeringHighlightLength", just for downward compatibility
// 和上面类似
//@property (assign, nonatomic, readwrite, getter = shimmeringHighlightLength, setter = setShimmeringHighlightLength:) CGFloat shimmeringHighlightWidth;

//! @abstract The direction of shimmering animation. Defaults to FBShimmerDirectionRight.
// 闪烁的方向，这个枚举有上下左右四个方向
//@property (assign, nonatomic, readwrite) FBShimmerDirection shimmeringDirection;

//! @abstract The duration of the fade used when shimmer begins. Defaults to 0.1.
// 开始闪烁的时间间隔
//@property (assign, nonatomic, readwrite) CFTimeInterval shimmeringBeginFadeDuration;

//! @abstract The duration of the fade used when shimmer ends. Defaults to 0.3.
// 结束闪烁的时间间隔
//@property (assign, nonatomic, readwrite) CFTimeInterval shimmeringEndFadeDuration;

/**
 @abstract The absolute CoreAnimation media time when the shimmer will fade in.
 @discussion Only valid after setting {@ref shimmering} to NO.
 */
// 闪烁到shimmeringAnimationOpacity的时候fade需要多久
//@property (assign, nonatomic, readonly) CFTimeInterval shimmeringFadeTime;


@interface ShimmerAnimationViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *cjShimmerLabel;

@end
