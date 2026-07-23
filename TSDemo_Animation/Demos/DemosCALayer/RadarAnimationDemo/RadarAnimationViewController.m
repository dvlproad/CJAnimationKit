//
//  RadarAnimationViewController.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2017/5/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "RadarAnimationViewController.h"
#import <Masonry/Masonry.h>

#import "CJAnimationFactory.h"
#import "CAShapeLayerFactory.h"

#import "UIControl+CJRadarAnimation.h"
#import <CQDemoKit/CQTSRipeButtonCollectionView.h>

@interface RadarAnimationViewController ()

@end

@implementation RadarAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIColor *buttonColor = [UIColor colorWithRed:0.996 green:0.780 blue:0.369 alpha:1.0];
    
    // radarButton1
    UIButton *radarButton1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    radarButton1.backgroundColor = buttonColor;
    [radarButton1 setTitle:@"每点击一下产生一圈雷达波纹" forState:UIControlStateNormal];
    [radarButton1 addTarget:self action:@selector(radarAnimation1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:radarButton1];
    self.radarButton1 = radarButton1;
    
    // radarButton2
    UIButton *radarButton2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    radarButton2.backgroundColor = buttonColor;
    [radarButton2 setTitle:@"按住的时候产生雷达波纹" forState:UIControlStateNormal];
    [radarButton2 addTarget:self action:@selector(radarAnimation2:) forControlEvents:UIControlEventTouchDown];
    [radarButton2 addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [radarButton2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:radarButton2];
    self.radarButton2 = radarButton2;
    
    // radarButton3
    UIButton *radarButton3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    radarButton3.backgroundColor = buttonColor;
    [radarButton3 setTitle:@"雷达波纹" forState:UIControlStateNormal];
    radarButton3.cjRadarAnimationType = CJRadarAnimationTypeOnlyDown;
    [self.view addSubview:radarButton3];
    self.radarButton3 = radarButton3;
    
    // cjRadarAnimationType 测试
    NSArray<NSString *> *titles = @[
        @"None(无动画)",
        @"OnlyDown(按下触发)",
        @"EveryTouch(每次触发)",
    ];
    __weak typeof(self) weakSelf = self;
    CQTSRipeButtonCollectionView *collectionView = [CQTSRipeButtonCollectionView columnRadioButtonsWithWidth:200 height:3*50 titles:titles didSelectItemAtIndexHandle:^(NSInteger index) {
        [weakSelf setRadarTypeWithIndex:index];
    }];
    [self.view addSubview:collectionView];
    
    // Masonry 布局
    [radarButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(65);
        make.right.mas_equalTo(self.view).mas_offset(-65);
        make.top.mas_equalTo(self.view).mas_offset(163);
        make.height.mas_equalTo(72);
    }];
    [radarButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(radarButton1);
        make.top.mas_equalTo(radarButton1.mas_bottom).mas_offset(96);
    }];
    [radarButton3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(radarButton1);
        make.top.mas_equalTo(radarButton2.mas_bottom).mas_offset(37);
    }];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(radarButton3.mas_bottom).mas_offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(3*50);
    }];
    
    [collectionView reloadData];
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


- (void)setRadarTypeWithIndex:(NSInteger)index {
    switch (index) {
        case 0: self.radarButton3.cjRadarAnimationType = CJRadarAnimationTypeNone; break;
        case 1: self.radarButton3.cjRadarAnimationType = CJRadarAnimationTypeOnlyDown; break;
        case 2: self.radarButton3.cjRadarAnimationType = CJRadarAnimationTypeEveryTouch; break;
        default: break;
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
