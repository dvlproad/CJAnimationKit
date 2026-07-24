//
//  RadarAnimationViewController.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2017/5/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "RadarAnimationViewController.h"
#import <Masonry/Masonry.h>
#import <CQDemoKit/CJUIKitToastUtil.h>
#import <CQDemoKit/CJUIKitAlertUtil.h>
#import <CQDemoKit/UIButton+CQTSMoreProperty.h>

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
    
    // radarButton1
    UIButton *radarButton1 = [self __baseRadarButton];
    [radarButton1 setTitle:[@[
        @"成品前的测试",
        @"每点击一下产生一圈雷达波纹(未封装)",
        @"(必须保证 layer.masksToBounds = NO;)",
    ] componentsJoinedByString:@"\n"] forState:UIControlStateNormal];
    [radarButton1 setCqtsTouchUpInsideBlock:^(UIButton * _Nonnull bButton) {
        CAShapeLayer *circleShape = [CAShapeLayerFactory cjCircleShapeLayerForView:bButton circleType:CJCircleTypeInscribe];
        CAAnimationGroup *radarAnimationGroup = [CJAnimationFactory cjRadarAnimationWithScale:5 duration:3];
        radarAnimationGroup.repeatCount = 1;
        [circleShape addAnimation:radarAnimationGroup forKey:nil];
        
        [bButton.layer addSublayer:circleShape];
    }];
    [self.view addSubview:radarButton1];
    [radarButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(163);
        make.height.mas_equalTo(88);
    }];
    self.radarButton1 = radarButton1;
    
    // radarButton2
    UIButton *radarButton2 = [self createLongPresRadarButton];
    [self.view addSubview:radarButton2];
    [radarButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(radarButton1);
        make.top.mas_equalTo(radarButton1.mas_bottom).mas_offset(20);
    }];
    self.radarButton2 = radarButton2;
    
    // radarButton3
    UIButton *radarButton3 = [self __baseRadarButton];
    [radarButton3 setTitle:[@[
        @"已封装的成品",
        @"封装好的【雷达波纹】组件",
        @"(必须保证 layer.masksToBounds = NO;)",
    ] componentsJoinedByString:@"\n"] forState:UIControlStateNormal];
    radarButton3.cjRadarAnimationType = CJRadarAnimationTypeOnlyDown;
    [self.view addSubview:radarButton3];
    [radarButton3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(radarButton1);
        make.top.mas_equalTo(radarButton2.mas_bottom).mas_offset(100);
    }];
    self.radarButton3 = radarButton3;
    
    // cjRadarAnimationType 测试
    NSArray<NSString *> *titles = @[
        @"None(无动画)",
        @"OnlyDown(按下触发)",
        @"EveryTouch(每次触发)",
    ];
    __weak typeof(self) weakSelf = self;
    UIView *radioButtonsView = [CQTSRipeButtonCollectionView columnRadioButtonsWithWidth:200 height:3*50 titles:titles didSelectItemAtIndexHandle:^(NSInteger index) {
        [weakSelf setRadarTypeWithIndex:index];
    }];
    [self.view addSubview:radioButtonsView];
    [radioButtonsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(radarButton3.mas_bottom).mas_offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(3*50);
    }];
}

#pragma mark - 按住的时候产生雷达波纹(未封装)
- (UIButton *)createLongPresRadarButton {
    UIButton *radarButton2 = [self __baseRadarButton];
    [radarButton2 setTitle:[@[
        @"成品前的测试",
        @"按住的时候产生雷达波纹(未封装)",
        @"(必须保证 layer.masksToBounds = NO;)",
    ] componentsJoinedByString:@"\n"] forState:UIControlStateNormal];
    [radarButton2 addTarget:self action:@selector(longPressRadarAnimationStart:) forControlEvents:UIControlEventTouchDown];
    [radarButton2 addTarget:self action:@selector(longPressRadarAnimationStop:) forControlEvents:UIControlEventTouchUpInside];
    
    return radarButton2;
}

- (void)longPressRadarAnimationStart:(UIButton *)button {
    [self performSelector:@selector(_buttonAnimation) withObject:nil afterDelay:0.5]; //需要延迟执行，因为有可能它只是点击操作，而不是按住操作
}

- (void)longPressRadarAnimationStop:(UIButton *)button {
    //①处理抬起事件
    [self _stopAnimation];
    
    //②处理点击事件
    [CJUIKitToastUtil showMessage:@"点击了按钮"];
}

- (void)_buttonAnimation {
    CAShapeLayer *circleShape = [CAShapeLayerFactory cjCircleShapeLayerForView:self.radarButton2 circleType:CJCircleTypeInscribe];
    CAAnimationGroup *radarAnimationGroup = [CJAnimationFactory cjRadarAnimationWithScale:5 duration:3];
    [circleShape addAnimation:radarAnimationGroup forKey:nil];
    [self.radarButton2.layer addSublayer:circleShape];
    
    self.cycleRadarShapeLayer = circleShape;
}

- (void)_stopAnimation {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_buttonAnimation) object:nil];
    
    if (self.cycleRadarShapeLayer) {
        [self.cycleRadarShapeLayer removeFromSuperlayer];
    }
}

#pragma mark - 封装好的【雷达波纹】组件
- (void)setRadarTypeWithIndex:(NSInteger)index {
    switch (index) {
        case 0: self.radarButton3.cjRadarAnimationType = CJRadarAnimationTypeNone; break;
        case 1: self.radarButton3.cjRadarAnimationType = CJRadarAnimationTypeOnlyDown; break;
        case 2: self.radarButton3.cjRadarAnimationType = CJRadarAnimationTypeEveryTouch; break;
        default: break;
    }
}


#pragma mark - Private Method
- (UIButton *)__baseRadarButton {
    UIButton *radarButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    radarButton.backgroundColor = [UIColor colorWithRed:0.996 green:0.780 blue:0.369 alpha:1.0];
    radarButton.titleLabel.numberOfLines = 0;
    radarButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    //[radarButton setTitle:title forState:UIControlStateNormal];
    return radarButton;
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
