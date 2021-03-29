//
//  TSShakeViewController.m
//  CJAnimationKitDemo
//
//  Created by qian on 2021/3/29.
//  Copyright © 2021 dvlproad. All rights reserved.
//

#import "TSShakeViewController.h"
#import <CQDemoKit/CQTSButtonFactory.h>

#define kShakingRadian(R) ((R) / 180.0 * M_PI)


@interface TSShakeViewController ()

@end

@implementation TSShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // [iOS 仿射变换CGAffineTransform](https://www.jianshu.com/p/c40e4bbb3ae2)
    __weak typeof(self)weakSelf = self;
    UIButton *shakeView = [CQTSButtonFactory themeBGButtonWithTitle:@"点击视图抖动" actionBlock:^(UIButton * _Nonnull bButton) {
        [TSShakeViewController addAnimationShakeWithView:bButton];
    }];
    shakeView.backgroundColor = [UIColor redColor];
    [self.view addSubview:shakeView];
    [shakeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(100);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mas_topLayoutGuide).mas_offset(100);
        make.height.mas_equalTo(400);
    }];
    
//    shakeView.transform = CGAffineTransformMakeRotation(30/ 180.0 * M_PI);
//    shakeView.layer.transform = CATransform3DMakeRotation(80/ 180.0 * M_PI, 0, 0, 1);
}

#pragma mark - 添加抖动动画
+ (void)addAnimationShakeWithView:(UIView *)view {
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    theAnimation.duration=4;
    theAnimation.removedOnCompletion = YES;
    theAnimation.fromValue = [NSNumber numberWithFloat:0];
    theAnimation.toValue = [NSNumber numberWithFloat:50/ 180.0 * M_PI];
     [view.layer addAnimation:theAnimation forKey:@"animateTransform"];
    
    
    return;
    
//    view.layer.transform = CATransform3DMakeRotation(30/ 180.0 * M_PI, 0, 1, 0);
    
    [UIView animateWithDuration:3
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
    //你想绕哪个轴哪个轴就为 1，其中的参数（角度， x, y, z）
                            view.layer.transform=CATransform3DMakeRotation(-80/ 180.0 * M_PI, 0, -1, 0);
                         }
                         completion:^(BOOL finished) {
    //你想绕哪个轴哪个轴就为 1，其中的参数（角度， x, y, z）
//                             view.layer.transform=CATransform3DMakeRotation(80/ 180.0 * M_PI, 0, 1, 0);
                         }];

    
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//
//    animation.keyPath = @"transform.rotation.y";
//
//    CGFloat angel = 70;
////    animation.values = @[@(kShakingRadian(-0)), @(kShakingRadian(angel)), @(kShakingRadian(-0)), @(kShakingRadian(angel)), @(kShakingRadian(-0))];
//    animation.values = @[@(kShakingRadian(-0)), @(70/ 180.0 * M_PI), @(kShakingRadian(-0)), @(-70/ 180.0 * M_PI), @0];
//
//    animation.duration = 5;
//
//    // 动画的重复执行次数
//    animation.repeatCount = 1;
//
//    // 保持动画执行完毕后的状态
////    animation.removedOnCompletion = NO;
//
////    animation.fillMode = kCAFillModeForwards;
//
//    [view.layer addAnimation:animation forKey:@"sh_animation_shake"];
    
    
    
    
//    CABasicAnimation* rotationAnimation;
//    //绕哪个轴，那么就改成什么：这里是绕y轴 ---> transform.rotation.y
//    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
//    //旋转角度
//    rotationAnimation.toValue = [NSNumber numberWithFloat: 30/ 180.0 * M_PI];
//    //每次旋转的时间（单位秒）
//    rotationAnimation.duration = 2;
//    rotationAnimation.cumulative = YES;
//    //重复旋转的次数，如果你想要无数次，那么设置成MAXFLOAT
//    rotationAnimation.repeatCount = 2;
//    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

#pragma mark - 移除抖动动画
+ (void)removeAnimationShakeWithView:(UIView *)view{
    
    //结束动画
    [view.layer removeAnimationForKey:@"sh_animation_shake"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
