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

static int testMaxValue1 = 100;
static int testMaxValue2 = 60;

@interface GradientCycleViewController () //<GraduatedCycleViewDelegate>

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) PercentGraduatedCycleView *percentGraduatedCycleView;

@property (nonatomic, strong) UILabel *label2;
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
    
    //*
    PercentGraduatedCycleView *percentGraduatedCycleView = [[PercentGraduatedCycleView alloc] init];
    percentGraduatedCycleView.maxValue = testMaxValue1;
//    percentGraduatedCycleView.delegate = self;
    [self.view addSubview:percentGraduatedCycleView];
    [percentGraduatedCycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(self.view).mas_offset(100);
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
    CountdownGraduatedCycleView *countdownGraduatedCycleView = [[CountdownGraduatedCycleView alloc] init];
    countdownGraduatedCycleView.maxValue = testMaxValue2;
//    countdownGraduatedCycleView.delegate = self;
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
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 传入百分比的时候，传入 小数，  0.1 - 1 范围内  <==>  1 - 100
    //*
    CGFloat randValue1 = arc4random_uniform(testMaxValue1 + 1);
    //CGFloat fromValue1 = 0;
    CGFloat toValue1 = randValue1;
//    self.label1.text = [NSString stringWithFormat:@"随机到的值:%.2f", toValue1];
    [self.percentGraduatedCycleView changeFromValue:0 toValue:toValue1 withAnimationDuration:2.0f];
    //[self.percentGraduatedCycleView testStartChangeToValue:toValue1];
//    [self.percentGraduatedCycleView updateProgressLabelWithAnimation:YES duration:2.0];
    [self.percentGraduatedCycleView updateProgressLabelWithAnimationDuration:2.0f];
    //[self.percentGraduatedCycleView updateProgressLabelWithAnimationSpeed:3.00f/testMaxValue1];
    //*/
    
    //*
    CGFloat leaveSecondCount = arc4random_uniform(testMaxValue2 + 1); //还剩几秒
    //leaveSecondCount = testMaxValue2;
    //self.label2.text = [NSString stringWithFormat:@"随机到的剩余秒数:%.2f", leaveSecondCount];//添上此行会导致圆环无法从fromValue显示
    NSInteger goneSecondCount = testMaxValue2-leaveSecondCount; //已经走了几秒，完整倒计时时候，此值一般是0秒
    CGFloat fromValue2 = goneSecondCount;
    CGFloat toValue2 = self.countdownGraduatedCycleView.maxValue;
    CFTimeInterval duration = toValue2 - fromValue2;
//    [self.countdownGraduatedCycleView countDownWithGoneSecondCount:goneSecondCount];
    [self.countdownGraduatedCycleView changeFromValue:fromValue2 toValue:toValue2 withAnimationDuration:duration];
    [self.countdownGraduatedCycleView updateProgressLabelWithAnimationDuration:duration];
    //*/
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
