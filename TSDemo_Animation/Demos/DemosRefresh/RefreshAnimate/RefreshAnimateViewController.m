//
//  RefreshAnimateViewController.m
//  LADemo
//
//  Created by Ben on 14/11/17.
//  Copyright (c) 2014年 XTeam. All rights reserved.
//

#import "RefreshAnimateViewController.h"
#import "TNActivityIndicator.h"
#import <Masonry/Masonry.h>

static const CFTimeInterval duration = 5.0;

@interface RefreshAnimateViewController ()

@property (nonatomic, strong) TNActivityIndicator *loadingIndicator;
@property (nonatomic, strong) UIImageView *grayHead;
@property (nonatomic, strong) UIImageView *greenHead;
@property (nonatomic, strong) CAShapeLayer *maskLayerUp;
@property (nonatomic, strong) CAShapeLayer *maskLayerDown;

@end

@implementation RefreshAnimateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // loadingIndicator: x=145 y=80 30x30 (相对于375宽度居中)
    self.loadingIndicator = [[TNActivityIndicator alloc] initWithFrame:CGRectZero];
    self.loadingIndicator.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.loadingIndicator];
    [self.loadingIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom).mas_offset(40);
        make.width.height.mas_equalTo(30);
    }];
    
    // grayHead: x=145 y=150 30x30
    self.grayHead = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bull_head_gray" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil]];
    [self.view addSubview:self.grayHead];
    [self.grayHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.loadingIndicator).mas_offset(150);
        make.width.height.mas_equalTo(30);
    }];
    
    // greenHead: x=145 y=150 30x30
    self.greenHead = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bull_head_green" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil]];
    [self.view addSubview:self.greenHead];
    [self.greenHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.loadingIndicator).mas_offset(150);
        make.width.height.mas_equalTo(30);
    }];
    
    self.greenHead.layer.mask = [self greenHeadMaskLayer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.loadingIndicator startAnimating];
    [self startGreenHeadAnimation];
}

- (void)startGreenHeadAnimation {
    CABasicAnimation *downAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    downAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(-5.0f, -5.0f)];
    downAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(10.0f, 10.0f)];
    downAnimation.duration = duration;
    [self.maskLayerUp addAnimation:downAnimation forKey:@"downAnimation"];
    
    CABasicAnimation *upAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    upAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(35.0f, 35.0f)];
    upAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(20.0f, 20.0f)];
    upAnimation.duration = duration;
    [self.maskLayerDown addAnimation:upAnimation forKey:@"upAnimation"];
}

- (CALayer *)greenHeadMaskLayer {
    CALayer *mask = [CALayer layer];
    mask.frame = self.greenHead.bounds;
    
    self.maskLayerUp = [CAShapeLayer layer];
    self.maskLayerUp.bounds = CGRectMake(0, 0, 30.0f, 30.0f);
    self.maskLayerUp.fillColor = [UIColor greenColor].CGColor;
    self.maskLayerUp.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(15.0f, 15.0f)
                                                           radius:15.0f
                                                       startAngle:0
                                                         endAngle:2*M_PI
                                                        clockwise:YES].CGPath;
    self.maskLayerUp.opacity = 0.8f;
    self.maskLayerUp.position = CGPointMake(-5.0f, -5.0f);
    [mask addSublayer:self.maskLayerUp];
    
    self.maskLayerDown = [CAShapeLayer layer];
    self.maskLayerDown.bounds = CGRectMake(0, 0, 30.0f, 30.0f);
    self.maskLayerDown.fillColor = [UIColor greenColor].CGColor;
    self.maskLayerDown.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(15.0f, 15.0f)
                                                             radius:15.0f
                                                         startAngle:0
                                                           endAngle:2*M_PI
                                                          clockwise:YES].CGPath;
    self.maskLayerDown.position = CGPointMake(35.0f, 35.0f);
    [mask addSublayer:self.maskLayerDown];

    return mask;
}

@end
