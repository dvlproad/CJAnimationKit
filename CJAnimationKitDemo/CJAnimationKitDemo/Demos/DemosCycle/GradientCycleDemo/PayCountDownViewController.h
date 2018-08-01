//
//  PayCountDownViewController.h
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2018/7/30.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface PayCountDownViewController : UIViewController

@property (nonatomic, copy) void(^startPayBlock)(PayCountDownViewController *mPayCountDownViewController);

@end
