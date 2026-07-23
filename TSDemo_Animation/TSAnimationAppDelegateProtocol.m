//
//  TSAnimationAppDelegateProtocol.m
//  TSDemo_Animation
//
//  Created by dvlproad on 2026/7/23.
//  Copyright © 2026 dvlproad. All rights reserved.
//

#import "TSAnimationAppDelegateProtocol.h"

@implementation UIWindow (TSAnimationAppDelegate)

+ (id<TSAnimationAppDelegateProtocol>)ts_animationAppDelegate {
    return (id<TSAnimationAppDelegateProtocol>)[UIApplication sharedApplication].delegate;
}

@end
