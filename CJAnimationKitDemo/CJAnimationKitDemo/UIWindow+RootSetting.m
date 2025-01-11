//
//  UIWindow+RootSetting.m
//  TSImageFilterDemo
//
//  Created by ciyouzen on 2018/4/12.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "UIWindow+RootSetting.h"
#import "TSAnmaionMainViewController.h"

@implementation UIWindow (RootSetting)

- (void)settingRoot {
    [self setBackgroundColor:[UIColor whiteColor]];
    // 只直接测试某个页面（OC控制器）
    //UIViewController *rootViewController = [[UINavigationController alloc] initWithRootViewController:[[NSClassFromString(@"TSShakeViewController") alloc] init]];
    
    // 只直接测试某个页面（Swift控制器）
//    UIViewController *viewController = [[TSSnapViewController alloc] init];
//    UIViewController *rootViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    // 测试全部页面
    UIViewController *rootViewController = [[TSAnmaionMainViewController alloc] init];
    
    self.rootViewController = rootViewController;
    [self makeKeyAndVisible];
}

@end
