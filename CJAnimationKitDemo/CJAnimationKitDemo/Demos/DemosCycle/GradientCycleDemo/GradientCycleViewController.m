//
//  GradientCycleViewController.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2018/7/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "GradientCycleViewController.h"
#import "GradientCycleView.h"
#import "GradientCycleLayer.h"
#import "HUDLayerView.h"
#import "HUDImageView.h"

#import "CJGraduatedCycleView.h"
#import "CJGraduatedCycleView+Countdown.h"

#import "CQGradientBorderButton.h"

static int testMaxValue1 = 100;
static int testMaxValue2 = 100;

@interface GradientCycleViewController () <CJGraduatedCycleViewDelegate>

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) CJGraduatedCycleView *percentGraduatedCycleView;

@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) CJGraduatedCycleView *countdownGraduatedCycleView;

@end

@implementation GradientCycleViewController

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
//    [self.percentGraduatedCycleView invalidateTimer];
//    [self.countdownGraduatedCycleView invalidateTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    CQGradientBorderButton *buttonView = [[CQGradientBorderButton alloc] initWithCornerRadius:15 shouldEffect:YES];
    [buttonView setTitle:@"测试视图边框颜色渐变" forState:UIControlStateNormal];
    [self.view addSubview:buttonView];
    [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(self.mas_topLayoutGuide).mas_offset(10);
        make.height.mas_equalTo(44);
    }];
    
    //*
    CJGraduatedCycleView *percentGraduatedCycleView = [[CJGraduatedCycleView alloc] init];
    percentGraduatedCycleView.backgroundColor = [UIColor blackColor];
    percentGraduatedCycleView.progressLabel.textColor = [UIColor whiteColor];
    [percentGraduatedCycleView setMaxValue:testMaxValue1 dividedCount:1 clockwise:YES];
    percentGraduatedCycleView.delegate = self;
    [self.view addSubview:percentGraduatedCycleView];
    [percentGraduatedCycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(buttonView.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(200);
    }];
    self.percentGraduatedCycleView = percentGraduatedCycleView;
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectZero];
    label1.backgroundColor = [UIColor greenColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = @"随机到的值";
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(percentGraduatedCycleView.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(20);
    }];
    self.label1 = label1;
    //*/
    
    //*
    CJGraduatedCycleView *countdownGraduatedCycleView = [[CJGraduatedCycleView alloc] init];
    countdownGraduatedCycleView.backgroundColor = [UIColor blackColor];
    countdownGraduatedCycleView.progressLabel.textColor = [UIColor whiteColor];
    [countdownGraduatedCycleView setMaxValue:testMaxValue2 dividedCount:1 clockwise:YES];
    countdownGraduatedCycleView.delegate = self;
    [self.view addSubview:countdownGraduatedCycleView];
    [countdownGraduatedCycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        //make.top.mas_equalTo(label1.mas_bottom).mas_offset(10);
        make.top.mas_equalTo(self.view).mas_offset(400);
        make.height.mas_equalTo(200);
    }];
    self.countdownGraduatedCycleView = countdownGraduatedCycleView;
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectZero];
    label2.backgroundColor = [UIColor greenColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.text = @"随机到的值";
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(countdownGraduatedCycleView.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(20);
    }];
    self.label2 = label2;
    //*/
    
    
//    GradientCycleView *gradientCycleView = [[GradientCycleView alloc] initWithFrame:CGRectZero];
//    [self.view addSubview:gradientCycleView];
//    [gradientCycleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self.view);
//        make.size.mas_equalTo(110);
//    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"按钮111" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop).offset(-20);
        make.left.mas_equalTo(self.view).offset(10);
        make.width.height.mas_equalTo(110);
    }];
        
    GradientCycleLayer *layer = [[GradientCycleLayer alloc] initWithSize:110 cycleLineWidth:10];
    layer.backgroundColor = [UIColor blueColor].CGColor; //圆环底色
    layer.frame = CGRectMake(0, 0, 110, 110);
    [button.layer addSublayer:layer];
    
    HUDLayerView *hudView = [[HUDLayerView alloc] init];
    hudView.backgroundColor = [UIColor magentaColor]; //圆环底色
    [self.view addSubview:hudView];
    [hudView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop).offset(-20);
        make.centerX.mas_equalTo(self.view).offset(0);
        make.width.height.mas_equalTo(110);
    }];
    
    HUDImageView *hudImageView = [[HUDImageView alloc] init];
    hudImageView.backgroundColor = [UIColor clearColor]; //圆环底色
    [self.view addSubview:hudImageView];
    [hudImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottomLayoutGuideTop).offset(-20);
        make.right.mas_equalTo(self.view).offset(-10);
        make.width.height.mas_equalTo(110);
    }];
}

- (void)buttonAction:(UIButton *)button {
    NSString *title = button.titleLabel.text;
    NSLog(@"点击按钮%@", title);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 传入百分比的时候，传入 小数，  0.1 - 1 范围内  <==>  1 - 100
    CGFloat randValue1 = arc4random_uniform(testMaxValue1 + 1);
    CGFloat toValue1 = randValue1;
    self.label1.text = [NSString stringWithFormat:@"随机到的值:%.2f", toValue1];
    [self.percentGraduatedCycleView changeFromValue:0 toValue:toValue1 withAnimationDuration:2.0f];
    
    CGFloat leaveSecondCount = randValue1; //还剩几秒
    self.label2.text = [NSString stringWithFormat:@"随机到的剩余秒数:%.2f", leaveSecondCount];
    [self.countdownGraduatedCycleView beginCountDownWithLeaveSecondCount:leaveSecondCount];
}


#pragma mark - CJGraduatedCycleViewDelegate
- (CALayer *)cjGraduatedCycleView:(CJGraduatedCycleView *)graduatedCycleView actualBottomLayerForCycleType:(CJCycleType)cycleType
{
    CAShapeLayer *possibleBottomLayer = nil;
    if (cycleType == CJCycleTypeGraduated) {
        possibleBottomLayer = graduatedCycleView.graduatedCyclePossibleBottomLayer;
    } else {
        possibleBottomLayer = graduatedCycleView.fullCyclePossibleBottomLayer;
    }
    
    possibleBottomLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    return possibleBottomLayer;
}

- (CALayer *)cjGraduatedCycleView:(CJGraduatedCycleView *)graduatedCycleView actualUpperLayerForCycleType:(CJCycleType)cycleType
{
    CAShapeLayer *possibleUpperLayer = nil;
    if (cycleType == CJCycleTypeGraduated) {
        possibleUpperLayer = graduatedCycleView.graduatedCyclePossibleUpperShapeLayer;
    } else {
        possibleUpperLayer = graduatedCycleView.fullCyclePossibleUpperLayer;
    }
    
    
    NSArray *colors = @[(id)[UIColor greenColor].CGColor,
                        (id)[UIColor whiteColor].CGColor,
                        (id)[UIColor purpleColor].CGColor,
                        (id)[UIColor redColor].CGColor];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colors;
    gradientLayer.shadowPath = possibleUpperLayer.path;
    gradientLayer.frame = possibleUpperLayer.bounds;
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 0);
    //gradientLayer.locations = @[@0.2, @0.5, @0.7, @1];
    
    [gradientLayer setMask:possibleUpperLayer]; // 设置进度layer 颜色 渐变
    
    return gradientLayer;
}


- (void)cjGraduatedCycleView:(CJGraduatedCycleView *)gradientCycleView updateLabelWithProgressValue:(CGFloat)progressValue {
    if (gradientCycleView == self.percentGraduatedCycleView) {
        NSString *string = [NSString stringWithFormat:@"%.0f%%", progressValue];
        //NSLog(@"percent = %@", string);
        gradientCycleView.progressLabel.text = string;
        
    } else if (gradientCycleView == self.countdownGraduatedCycleView) {
        NSInteger leaveSecondCount = (NSInteger)(gradientCycleView.maxValue - progressValue);
        NSInteger secondValue = leaveSecondCount%60;
        NSInteger minuteValue = leaveSecondCount/60;
        NSString *string = [NSString stringWithFormat:@"%02ld:%02ld", minuteValue, secondValue];
        //NSLog(@"second = %@", string);
        gradientCycleView.progressLabel.text = string;
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
