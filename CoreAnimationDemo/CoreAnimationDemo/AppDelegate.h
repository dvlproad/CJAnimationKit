//
//  AppDelegate.h
//  CoreAnimationDemo
//
//  Created by lichq on 15/10/13.
//  Copyright (c) 2015年 李超前. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJRepeatKeyWindow.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CJRepeatKeyWindow *cjFloatingWindow; /**< 创建的window必须强制持有，且要想window一直不被释放，除了strong，还必须放在AppDelegate上 */


@end

