//
//  SampleLayerMaskViewController.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2018/1/11.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "SampleLayerMaskViewController.h"
#import <Masonry/Masonry.h>
#import <CQDemoKit/CQTSButtonFactory.h>

#import <CJAnimationKit/CJPathFactory.h>

@interface SampleLayerMaskViewController ()

@property (nonatomic, strong) UIView *sampleView;

@end

@implementation SampleLayerMaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Shape Layer 测试";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupSampleView];
}

- (void)setupSampleView {
    self.sampleView = [[UIView alloc] init];
    self.sampleView.backgroundColor = [UIColor colorWithRed:0.2 green:0.6 blue:1.0 alpha:1.0];
    [self.view addSubview:self.sampleView];
    [self.sampleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_topLayoutGuideBottom).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
        make.width.height.mas_equalTo(200);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Sample View";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:16];
    [self.sampleView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.sampleView);
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *maskButton = [CQTSButtonFactory themeBGButtonWithTitle:@"mask (裁剪)" actionBlock:^(UIButton * _Nonnull bButton) {
        [weakSelf applyLayer];
    }];
    [self.view addSubview:maskButton];
    [maskButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sampleView.mas_bottom).mas_offset(8);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.height.mas_equalTo(2 * 44 + 1 * 8);
    }];
}

- (void)applyLayer {
    // 清除旧的 mask
    self.sampleView.layer.mask = nil;
    
    CGSize size = self.sampleView.bounds.size;
    if (size.width == 0 || size.height == 0) return;
    
    CGPathRef path = [CJPathFactory batPathWithSize:size];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path;
    maskLayer.frame = self.sampleView.bounds;
    self.sampleView.layer.mask = maskLayer;
    
    CGPathRelease(path);
}

@end
