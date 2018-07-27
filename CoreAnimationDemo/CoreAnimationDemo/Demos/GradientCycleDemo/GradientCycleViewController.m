//
//  GradientCycleViewController.m
//  CoreAnimationDemo
//
//  Created by lichq on 2018/7/27.
//  Copyright © 2018年 李超前. All rights reserved.
//

#import "GradientCycleViewController.h"
#import "GradientCycleView.h"
#import "GradientCycleLayer.h"

#import "PercentGraduatedCycleView.h"
#import "CountdownGraduatedCycleView.h"

@interface GradientCycleViewController () //<GraduatedCycleViewDelegate>

@property (nonatomic, strong) PercentGraduatedCycleView *percentGraduatedCycleView;
@property (nonatomic, strong) CountdownGraduatedCycleView *countdownGraduatedCycleView;

@end

@implementation GradientCycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    GradientCycleView *gradientCycleView = [[GradientCycleView alloc] initWithFrame:CGRectZero];
//    [self.view addSubview:gradientCycleView];
//    [gradientCycleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self.view);
//        make.size.mas_equalTo(110);
//    }];
    
    GradientCycleLayer *layer = [GradientCycleLayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor; //圆环底色
    layer.frame = CGRectMake(100, 650, 110, 110);
    [self.view.layer addSublayer:layer];
    
    PercentGraduatedCycleView *percentGraduatedCycleView = [[PercentGraduatedCycleView alloc] init];
    percentGraduatedCycleView.maxValue = 100;
//    percentGraduatedCycleView.delegate = self;
    [self.view addSubview:percentGraduatedCycleView];
    [percentGraduatedCycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(self.view).mas_offset(100);
        make.height.mas_equalTo(200);
    }];
    self.percentGraduatedCycleView = percentGraduatedCycleView;
    
    
    CountdownGraduatedCycleView *countdownGraduatedCycleView = [[CountdownGraduatedCycleView alloc] init];
    countdownGraduatedCycleView.maxValue = 100;
//    countdownGraduatedCycleView.delegate = self;
    [self.view addSubview:countdownGraduatedCycleView];
    [countdownGraduatedCycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(self.view).mas_offset(400);
        make.height.mas_equalTo(200);
    }];
    self.countdownGraduatedCycleView = countdownGraduatedCycleView;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 传入百分比的时候，传入 小数，  0.1 - 1 范围内  <==>  1 - 100
    CGFloat toValue = arc4random_uniform(100 + 1);
    [self.percentGraduatedCycleView changeFromValue:0 toValue:toValue withAnimationDuration:2.0f];
//    [self.percentGraduatedCycleView updateProgressLabelWithAnimation:YES duration:2.0];
    [self.percentGraduatedCycleView updateProgressLabelWithAnimationDuration:2.0f];
    
    NSInteger goneSecondCount = 100-toValue; //已经走了几秒，完整倒计时时候，此值一般是0秒
    CGFloat fromValue2 = goneSecondCount;
    CGFloat toValue2 = self.countdownGraduatedCycleView.maxValue;
    CFTimeInterval duration = toValue2 - fromValue2;
    
//    [self.countdownGraduatedCycleView countDownWithGoneSecondCount:goneSecondCount];
    [self.countdownGraduatedCycleView changeFromValue:fromValue2 toValue:toValue2 withAnimationDuration:duration];
    [self.countdownGraduatedCycleView updateProgressLabelWithAnimationDuration:duration];
}

/*
- (void)graduatedCycleView_updateLabelText:(GraduatedCycleView *)gradientCycleView {
    if (gradientCycleView == self.percentGraduatedCycleView) {
        NSString *string = [NSString stringWithFormat:@"%.0f%%", gradientCycleView.toValue];
        gradientCycleView.progressLabel.text = string;
        
    } else if (gradientCycleView == self.countdownGraduatedCycleView) {
        NSInteger leaveSecondCount = (NSInteger)(gradientCycleView.maxValue - gradientCycleView.labelValue);
        NSInteger secondValue = leaveSecondCount%60;
        NSInteger minuteValue = leaveSecondCount/60;
        NSString *string = [NSString stringWithFormat:@"%02d:%02d", minuteValue, secondValue];
        gradientCycleView.progressLabel.text = string;
    }
}
*/

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
