//
//  AppDelegate.h
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 15/10/13.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CQDemoProtocol/CQTSDemoAppDelegateProtocol.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, CQTSDemoAppDelegateProtocol>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CQTSWindow *cqtsFloatingWindow; /**< 创建的window必须强制持有，且要想window一直不被释放，除了strong，还必须放在AppDelegate上 */


@end

