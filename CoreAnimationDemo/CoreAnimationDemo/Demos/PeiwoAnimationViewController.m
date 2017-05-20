//
//  PeiwoAnimationViewController.m
//  CoreAnimationDemo
//
//  Created by 李超前 on 2017/5/20.
//  Copyright © 2017年 李超前. All rights reserved.
//

#import "PeiwoAnimationViewController.h"

@interface PeiwoAnimationViewController ()

@property (nonatomic, strong) CAShapeLayer *maskLayer;

@end

@implementation PeiwoAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.useMaskLayerSwitch addTarget:self action:@selector(removeAddedLayer) forControlEvents:UIControlEventValueChanged];
}

- (void)removeAddedLayer {
    if (self.maskLayer) {
        [self.maskLayer removeFromSuperlayer];
    }
}


- (IBAction)doAnimation:(id)sender {
    [self circleSmallerWithView:self.animationView];
}


- (void)circleSmallerWithView:(UIView *)view {
    [self removeAddedLayer];
    
    CGRect startFrame = CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));
    UIBezierPath *startBezierPath =  [UIBezierPath bezierPathWithOvalInRect:startFrame];
    
    CGFloat radius = 100;
    CGRect finalFrame = CGRectMake(100, 100, radius, radius);
    UIBezierPath *finalBezierPath = [UIBezierPath bezierPathWithOvalInRect:finalFrame];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = finalBezierPath.CGPath;
    
    if (self.useMaskLayerSwitch.isOn) {
        [view.layer setMask:maskLayer];     //二者选其一
    } else {
        [view.layer addSublayer:maskLayer]; //二者选其一
    }
    
    //添加layer的动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(startBezierPath.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((finalBezierPath.CGPath));
    maskLayerAnimation.duration = 2.0f;
    
    //防止动画结束后回到初始状态,只需设置removedOnCompletion、fillMode两个属性就可以了(参考：CABasicAnimation使用总结http://www.jianshu.com/p/02c341c748f9)
    maskLayerAnimation.removedOnCompletion = NO;
    maskLayerAnimation.fillMode = kCAFillModeForwards;
    
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
    self.maskLayer = maskLayer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
