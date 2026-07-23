//
//  TSAnimationAppDelegateProtocol.h
//  TSDemo_Animation
//
//  Created by dvlproad on 2026/7/23.
//  Copyright © 2026 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CJAnimationKit/CJRepeatKeyWindow.h>

@protocol TSAnimationAppDelegateProtocol <NSObject>

@property (nonatomic, strong, readonly) CJRepeatKeyWindow *cjFloatingWindow;

@end

@interface UIWindow (TSAnimationAppDelegate)

+ (id<TSAnimationAppDelegateProtocol>)ts_animationAppDelegate;

@end
