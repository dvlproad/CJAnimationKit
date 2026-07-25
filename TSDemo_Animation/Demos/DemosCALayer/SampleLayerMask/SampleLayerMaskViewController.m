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
#import <CQDemoKit/CQTSRadioButtonsView.h>
#import <CQDemoKit/CQTSRipeButtonCollectionView.h>
#import <CQDemoKit/CQTSSwitchViewFactory.h>

#import <CJAnimationKit/CJPathFactory.h>
#import <CJAnimationKit/CAShapeLayerFactory.h>

@interface SampleLayerMaskViewController ()

@property (nonatomic, strong) UIView *sampleView;
@property (nonatomic, strong) CQTSRadioButtonsView *usageRadioButtons;
@property (nonatomic, strong) CQTSRipeButtonCollectionView *shapeCollectionView;
@property (nonatomic, strong) UIView *animationSwitchView;
@property (nonatomic, strong) UIView *clipsToBoundsSwitchView;
@property (nonatomic, assign) NSInteger selectedShapeIndex;
@property (nonatomic, assign) NSInteger selectedUsageIndex;

@property (nonatomic, strong) CAShapeLayer *addedSublayer; // 存住自己添加的 sublayer，避免误删

@end

@implementation SampleLayerMaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Shape Layer 测试";
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1.0]; //#f4f4f4;
    
    [self setupSampleView];
    
    // 先设置默认值，再设置回调，最后设置默认选中
    self.selectedShapeIndex = -1;
    self.selectedUsageIndex = -1;
    
    [self setupUsageRadioButtons];
    [self setupShapeCollectionView];
    
    // 默认选中 mask（用途），形状不默认选中
    self.selectedUsageIndex = 0;
    [self.usageRadioButtons didSelectItemAtIndex:0];
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
    
    self.selectedShapeIndex = -1;
    self.selectedUsageIndex = -1;
}

- (void)setupUsageRadioButtons {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"用途:";
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sampleView.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.view).mas_offset(20);
    }];
    
    NSArray *titles = @[@"mask (裁剪)", @"sublayer (描边)"];
    
    __weak typeof(self) weakSelf = self;
    self.usageRadioButtons = [[CQTSRadioButtonsView alloc] initWithTitles:titles
                                                                             alongAxis:MASAxisTypeVertical
                                                                          fixedSpacing:8
                                                        didSelectItemAtIndexHandle:^(NSInteger index) {
        weakSelf.selectedUsageIndex = index;
        [weakSelf applyLayerIfNeeded];
    }];
    [self.view addSubview:self.usageRadioButtons];
    [self.usageRadioButtons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(8);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.height.mas_equalTo(2 * 44 + 1 * 8);
    }];
    
    // 动画开关
    UIView *switchView = [CQTSSwitchViewFactory switchViewWithTitle:@"动画:"
                                                           switchOn:YES
                                            switchValueChangedBlock:^(UISwitch *bSwitch) {
        [weakSelf applyLayerIfNeeded];
    }];
    [self.view addSubview:switchView];
    [switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.usageRadioButtons.mas_bottom).mas_offset(12);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.height.mas_equalTo(31);
    }];
    self.animationSwitchView = switchView;
    
    // clipsToBounds 开关（对 mask 无效，仅 sublayer 有效）
    UIView *clipsSwitchView = [CQTSSwitchViewFactory switchViewWithTitle:@"clipsToBounds (对mask无效):"
                                                              switchOn:YES
                                               switchValueChangedBlock:^(UISwitch *bSwitch) {
        [weakSelf applyLayerIfNeeded];
    }];
    [self.view addSubview:clipsSwitchView];
    [clipsSwitchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.animationSwitchView.mas_bottom).mas_offset(8);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.height.mas_equalTo(31);
    }];
    self.clipsToBoundsSwitchView = clipsSwitchView;
}

- (void)setupShapeCollectionView {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"形状:";
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.clipsToBoundsSwitchView.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(self.view).mas_offset(20);
    }];
    
    NSArray *titles = @[@"箭头", @"半角", @"五角星", @"心形", @"蝙蝠", @"邮票", @"圆形(内切)", @"圆形(外接)"];
    
    __weak typeof(self) weakSelf = self;
    self.shapeCollectionView = [[CQTSRipeButtonCollectionView alloc] initWithTitles:titles
                                                                                          perMaxCount:3
                                                                                     widthHeightRatio:88/44.0
                                                                                      scrollDirection:UICollectionViewScrollDirectionVertical
                                                                           didSelectItemAtIndexHandle:^(NSInteger index) {
        weakSelf.selectedShapeIndex = index;
        [weakSelf applyLayerIfNeeded];
    }];
    self.shapeCollectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.shapeCollectionView];
    [self.shapeCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(8);
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.height.mas_equalTo(180);
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)applyLayerIfNeeded {
    if (self.selectedShapeIndex < 0 || self.selectedUsageIndex < 0) return;
    
    CGSize size = self.sampleView.bounds.size;
    if (size.width == 0 || size.height == 0) return;
    
    [self applyLayer];
}

- (void)applyLayer {
    // 清除旧的 layer
    self.sampleView.layer.mask = nil;
    
    // 【危险】禁止使用 [layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)]
    // 原因：makeObjectsPerformSelector: 遍历 sublayers 数组时，每移除一个元素，数组就变一次，
    // 属于遍历中修改容器的未定义行为，会导致后续导航返回时 UIKit 遍历 view hierarchy 触发崩溃。
    // 正确做法：存住自己添加的 sublayer，清理时只移除自己的。
    [self.addedSublayer removeFromSuperlayer];
    self.addedSublayer = nil;
    
    CGSize size = self.sampleView.bounds.size;
    if (size.width == 0 || size.height == 0) return;
    
    CGPathRef path = [self createPathWithSize:size];
    if (!path) return;
    
    BOOL showAnimation = [(UISwitch *)self.animationSwitchView.subviews.firstObject isOn];
    
    switch (self.selectedUsageIndex) {
        case 0: // mask
            [self applyMaskWithPath:path showAnimation:showAnimation];
            break;
        case 1: // sublayer
            BOOL clipsToBounds = [(UISwitch *)self.clipsToBoundsSwitchView.subviews.firstObject isOn];
            [self applySublayerWithPath:path showAnimation:showAnimation clipsToBounds:clipsToBounds];
            break;
    }
    
    CGPathRelease(path);
}

- (CGPathRef)createPathWithSize:(CGSize)size {
    switch (self.selectedShapeIndex) {
        case 0: return [CJPathFactory arrowPathWithSize:size];
        case 1: return [CJPathFactory halfAnglePathWithSize:size];
        case 2: return [CJPathFactory pentagramPathWithSize:size];
        case 3: return [CJPathFactory heartPathWithSize:size];
        case 4: return [CJPathFactory batPathWithSize:size];
        case 5: return [CJPathFactory stampPathWithSize:size];
        case 6: return [CJPathFactory circlePathWithSize:size circleType:CJCircleTypeInscribe];
        case 7: return [CJPathFactory circlePathWithSize:size circleType:CJCircleTypeCircumcircle];
        default: return NULL;
    }
}

- (void)applyMaskWithPath:(CGPathRef)path showAnimation:(BOOL)showAnimation {
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path;
    maskLayer.frame = self.sampleView.bounds;
    self.sampleView.layer.mask = maskLayer;
    
    if (showAnimation) {
        [self addMaskAnimationToLayer:maskLayer];
    }
}

- (void)addMaskAnimationToLayer:(CAShapeLayer *)layer {
    layer.transform = CATransform3DMakeScale(0.01, 0.01, 1.0);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01, 0.01, 1.0)];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.duration = 0.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [layer addAnimation:animation forKey:@"transformAnimation"];
}

- (void)applySublayerWithPath:(CGPathRef)path showAnimation:(BOOL)showAnimation clipsToBounds:(BOOL)clipsToBounds {
    self.sampleView.clipsToBounds = clipsToBounds;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = 3;
    [self.sampleView.layer addSublayer:shapeLayer];
    self.addedSublayer = shapeLayer; // 存住，清理时只移除这一个
    
    if (showAnimation) {
        [self addStrokeAnimationToLayer:shapeLayer];
    }
}

- (void)addStrokeAnimationToLayer:(CAShapeLayer *)layer {
    layer.strokeEnd = 0;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.duration = 2.0;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [layer addAnimation:animation forKey:@"strokeEndAnimation"];
}

@end
