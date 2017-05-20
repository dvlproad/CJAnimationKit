//
//  RadarAnimationViewController.m
//  CoreAnimationDemo
//
//  Created by 李超前 on 2017/5/19.
//  Copyright © 2017年 李超前. All rights reserved.
//

#import "RadarAnimationViewController.h"

#import "CJAnimationFactory.h"
#import "CAShapeLayerFactory.h"

#import "UIControl+CJRadarAnimation.h"

@interface RadarAnimationViewController ()

@end

@implementation RadarAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.radarButton1 addTarget:self action:@selector(radarAnimation1:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.radarButton2 addTarget:self action:@selector(radarAnimation2:) forControlEvents:UIControlEventTouchDown];
    [self.radarButton2 addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside]; //点击事件，其实包含了抬起事件，所以需需要处理与TouchDown相对应的事件
    [self.radarButton2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside]; //点击事件，其实包含了抬起事件，所以需需要处理与TouchDown相对应的事件
    
//    [self.radarButton2 addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil]; //观察者是self
    
    self.radarButton3.cjRadarAnimationType = CJRadarAnimationTypeOnlyDown;
}

- (void)radarAnimation1:(UIButton *)button {
    CAShapeLayer *circleShape = [CAShapeLayerFactory cjCircleShapeLayerForView:button circleType:CJCircleTypeInscribe];
    CAAnimationGroup *radarAnimationGroup = [CJAnimationFactory cjRadarAnimationWithScale:5 duration:3];
    radarAnimationGroup.repeatCount = 1;
    [circleShape addAnimation:radarAnimationGroup forKey:nil];
    
    [self.radarButton1.layer addSublayer:circleShape];
}

- (void)radarAnimation2:(UIButton *)button {
    [self performSelector:@selector(buttonAnimation) withObject:nil afterDelay:0.5]; //需要延迟执行，因为有可能它只是点击操作，而不是按住操作
}

- (void)buttonAnimation {
    CAShapeLayer *circleShape = [CAShapeLayerFactory cjCircleShapeLayerForView:self.radarButton2 circleType:CJCircleTypeInscribe];
    CAAnimationGroup *radarAnimationGroup = [CJAnimationFactory cjRadarAnimationWithScale:5 duration:3];
    [circleShape addAnimation:radarAnimationGroup forKey:nil];
    [self.radarButton2.layer addSublayer:circleShape];
    
    self.cycleRadarShapeLayer = circleShape;
}

- (void)click2 {
    [[[UIAlertView alloc] initWithTitle:@"点击了按钮2" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
}

- (void)click {
    //①处理抬起事件
    [self stopAnimation];
    
    //②处理点击事件
    [[[UIAlertView alloc] initWithTitle:@"点击了按钮" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
}

- (void)stopAnimation {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(buttonAnimation) object:nil];
    
    if (self.cycleRadarShapeLayer) {
        [self.cycleRadarShapeLayer removeFromSuperlayer];
    }
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
