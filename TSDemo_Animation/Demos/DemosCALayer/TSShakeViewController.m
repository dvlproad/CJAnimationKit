//
//  TSShakeViewController.m
//  CJAnimationKitDemo
//
//  Created by qian on 2021/3/29.
//  Copyright © 2021 dvlproad. All rights reserved.
//

#import "TSShakeViewController.h"
#import <CQDemoKit/CQTSButtonFactory.h>
#import <CQDemoKit/CQTSRipeButtonCollectionView.h>
#import <CJAnimationKit/UIView+CJShake.h>

#define kDegreesToRadians(degrees) ((degrees) / 180.0 * M_PI)

@interface TSShakeViewController ()

@property (nonatomic, strong) UIView *shakeView;

@end

@implementation TSShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视图抖动动画";

    // 待抖动的视图
    UIButton *shakeView = [CQTSButtonFactory themeBGButtonWithTitle:@"我是按钮上的文字" actionBlock:^(UIButton * _Nonnull bButton) {
        [bButton cjStopShake];
    }];
    UIImage *normalBGImage = cqts_buttonBGImage(UIColor.redColor);
    [shakeView setBackgroundImage:normalBGImage forState:UIControlStateNormal];
    [self.view addSubview:shakeView];
    [shakeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuide).offset(20);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(100);
    }];
    self.shakeView = shakeView;

    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"点击下方按钮测试不同抖动效果";
    tipLabel.textColor = [UIColor grayColor];
    tipLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.shakeView.mas_bottom).offset(16);
    }];

    // 多种抖动动画测试
    NSArray<NSString *> *titles = @[
        @"绕X轴旋转(CABasic)",
        @"绕Y轴旋转(CABasic)",
        @"绕Z轴旋转(CABasic)",
        @"绕Y轴旋转(UIView)",
        @"关键帧左右摇摆",
        @"关键帧多角度",
        @"绕Y轴重复旋转",
        @"X轴来回弹跳",
        @"[库] cjShake(短抖)",
        @"[库] cjShakeKeeping(持续抖动)",
    ];

    __weak typeof(self) weakSelf = self;
    CQTSRipeButtonCollectionView *collectionView =
        [[CQTSRipeButtonCollectionView alloc] initWithTitles:titles
                                                perMaxCount:2
                                           widthHeightRatio:88 / 44.0
                                            scrollDirection:UICollectionViewScrollDirectionVertical
                                 didSelectItemAtIndexHandle:^(NSInteger index) {
                                     [weakSelf shakeWithIndex:index];
                                 }];
    collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(tipLabel.mas_bottom).mas_offset(16);
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop).mas_offset(0);
    }];
}

- (void)shakeWithIndex:(NSInteger)index {
    // 先清除旧动画
    [self.shakeView.layer removeAllAnimations];
    self.shakeView.transform = CGAffineTransformIdentity;

    switch (index) {
        case 0: [self shakeRotationX]; break;
        case 1: [self shakeRotationY]; break;
        case 2: [self shakeRotationZ]; break;
        case 3: [self shakeUIViewRotationY]; break;
        case 4: [self shakeKeyframeSwing]; break;
        case 5: [self shakeKeyframeMultiAngle]; break;
        case 6: [self shakeRotationYRepeat]; break;
        case 7: [self shakeBounceX]; break;
        case 8: [self.shakeView cjShake]; break;
        case 9: [self.shakeView cjShakeKeeping]; break;
        default: break;
    }
}

#pragma mark - CABasicAnimation 绕X轴旋转
- (void)shakeRotationX {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    anim.fromValue = @(0);
    anim.toValue = @(kDegreesToRadians(50));
    anim.duration = 0.5;
    anim.repeatCount = 3;
    anim.autoreverses = YES;
    [self.shakeView.layer addAnimation:anim forKey:@"shake_x"];
}

#pragma mark - CABasicAnimation 绕Y轴旋转
- (void)shakeRotationY {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    anim.fromValue = @(0);
    anim.toValue = @(kDegreesToRadians(30));
    anim.duration = 0.3;
    anim.repeatCount = 4;
    anim.autoreverses = YES;
    [self.shakeView.layer addAnimation:anim forKey:@"shake_y"];
}

#pragma mark - CABasicAnimation 绕Z轴旋转
- (void)shakeRotationZ {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim.fromValue = @(kDegreesToRadians(-10));
    anim.toValue = @(kDegreesToRadians(10));
    anim.duration = 0.15;
    anim.repeatCount = 6;
    anim.autoreverses = YES;
    [self.shakeView.layer addAnimation:anim forKey:@"shake_z"];
}

#pragma mark - UIView Animation 绕Y轴旋转
- (void)shakeUIViewRotationY {
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        self.shakeView.layer.transform = CATransform3DMakeRotation(kDegreesToRadians(-80), 0, 1, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.shakeView.layer.transform = CATransform3DIdentity;
        }];
    }];
}

#pragma mark - CAKeyframeAnimation 左右摇摆
- (void)shakeKeyframeSwing {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation.z";
    anim.values = @[
        @(kDegreesToRadians(0)),
        @(kDegreesToRadians(-15)),
        @(kDegreesToRadians(15)),
        @(kDegreesToRadians(-10)),
        @(kDegreesToRadians(10)),
        @(kDegreesToRadians(0)),
    ];
    anim.duration = 0.6;
    [self.shakeView.layer addAnimation:anim forKey:@"shake_keyframe_swing"];
}

#pragma mark - CAKeyframeAnimation 多角度
- (void)shakeKeyframeMultiAngle {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation.z";
    anim.values = @[
        @(kDegreesToRadians(0)),
        @(kDegreesToRadians(-30)),
        @(kDegreesToRadians(0)),
        @(kDegreesToRadians(30)),
        @(kDegreesToRadians(0)),
    ];
    anim.duration = 1.0;
    anim.repeatCount = 2;
    [self.shakeView.layer addAnimation:anim forKey:@"shake_keyframe_multi"];
}

#pragma mark - CABasicAnimation 绕Y轴重复旋转
- (void)shakeRotationYRepeat {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    anim.toValue = @(kDegreesToRadians(360));
    anim.duration = 1.0;
    anim.repeatCount = 3;
    anim.cumulative = YES;
    [self.shakeView.layer addAnimation:anim forKey:@"shake_y_repeat"];
}

#pragma mark - CAKeyframeAnimation X轴来回弹跳
- (void)shakeBounceX {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.rotation.x";
    anim.values = @[
        @(kDegreesToRadians(0)),
        @(kDegreesToRadians(-20)),
        @(kDegreesToRadians(15)),
        @(kDegreesToRadians(-10)),
        @(kDegreesToRadians(5)),
        @(kDegreesToRadians(0)),
    ];
    anim.duration = 0.8;
    [self.shakeView.layer addAnimation:anim forKey:@"shake_bounce_x"];
}

@end
