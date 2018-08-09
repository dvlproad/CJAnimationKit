//
//  PayCountDownViewController.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2018/7/30.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "PayCountDownViewController.h"

#import <CJBaseUIKit/UINavigationBar+CJChangeBG.h>
#import "CJGraduatedCycleView+Countdown.h"

@interface PayCountDownViewController () <CJGraduatedCycleViewDelegate>

@property (nonatomic, strong) CJGraduatedCycleView *countdownGraduatedCycleView;

@end

@implementation PayCountDownViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self navigationBarReset];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self navigationBarCustomSet];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSInteger maxValue = self.totalSecond;
    NSInteger leaveSecondCount = self.leaveSecond;
    
    [self.countdownGraduatedCycleView setMaxValue:maxValue dividedCount:1];
    [self.countdownGraduatedCycleView beginCountDownWithLeaveSecondCount:leaveSecondCount];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //CGFloat screenHeight = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    //CGFloat statusHeight = screenHeight == 812.0 ? 44 : 20;
    //CGFloat statusHeight = CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[UIImage imageNamed:@"arrow_L_blue"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:closeButton];
//    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view).mas_offset(23);
//        make.top.mas_equalTo(self.view).mas_offset(statusHeight);
//        make.width.mas_equalTo(44);
//        make.height.mas_equalTo(44);
//    }];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    self.navigationItem.leftBarButtonItems = @[leftBarButtonItem];
    
    CJGraduatedCycleView *countdownGraduatedCycleView = [[CJGraduatedCycleView alloc] init];
    countdownGraduatedCycleView.backgroundColor = [UIColor whiteColor];
    countdownGraduatedCycleView.delegate = self;
//    countdownGraduatedCycleView.graduatedCycleBottomStrokeColor = [UIColor colorWithRed:180/255.0 green:195/255.0 blue:208/255.0 alpha:1]; //#cfd4dd
//    countdownGraduatedCycleView.fullCycleBottomStrokeColor = [UIColor lightGrayColor];
    [self.view addSubview:countdownGraduatedCycleView];
    [countdownGraduatedCycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        //make.top.mas_equalTo(self.view).mas_offset(240);
        make.centerY.mas_equalTo(self.view).mas_offset(-80);
        make.height.mas_equalTo(240);
    }];
    countdownGraduatedCycleView.graduatedCycleLineWidth = 16;
    countdownGraduatedCycleView.fullCycleLineWidth = 1;
    countdownGraduatedCycleView.progressLabel.textColor = [UIColor colorWithRed:15/255.0 green:145/255.0 blue:255/255.0 alpha:1]; //#of9aff
    countdownGraduatedCycleView.progressLabel.font = [UIFont systemFontOfSize:36];
    self.countdownGraduatedCycleView = countdownGraduatedCycleView;
    
    
    UILabel *warningLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    warningLabel.text = NSLocalizedString(@"订单将自动取消，请及时完成支付", nil);
    warningLabel.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1];//#4a4a4a
    warningLabel.textAlignment = NSTextAlignmentCenter;
    warningLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:warningLabel];
    [warningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(countdownGraduatedCycleView.mas_bottom).mas_offset(25);
        make.height.mas_equalTo(20);
    }];
    
    CGFloat priceYuan = self.payFen/100.0;
    NSString *payYuanString = [NSString stringWithFormat:@"%.0f", priceYuan];
    NSString *payButtonString = [NSString stringWithFormat:@"%@%@%@", NSLocalizedString(@"立即支付", nil), payYuanString, NSLocalizedString(@"元", nil)];
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [payButton setBackgroundColor:[UIColor colorWithRed:48/255.0 green:128/255.0 blue:255/255.0 alpha:1]];//#3388ff
    [payButton setTitle:payButtonString forState:UIControlStateNormal];
    [payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [payButton.layer setCornerRadius:25];
    [payButton addTarget:self action:@selector(payEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payButton];
    [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(warningLabel.mas_bottom).mas_offset(50);
        make.height.mas_equalTo(50);
    }];
}

- (void)goBack {
    if (self.goBackBlock) {
        self.goBackBlock(self);
    }
    
//    if (self.presentingViewController) { //判断self有没有present方式显示的父视图presentingViewController
//        [self dismissViewControllerAnimated:YES completion:nil];
//    } else {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
}

- (void)payEvent {
    if (self.startPayBlock) {
        self.startPayBlock(self);
    }
}

#pragma mark - CJGraduatedCycleViewDelegate
- (CALayer *)cjGraduatedCycleView:(CJGraduatedCycleView *)graduatedCycleView actualGraduatedCycleBottomLayerWithPossibleBottomLayer:(CAShapeLayer *)graduatedCycleBottomShapeLayer
{
//    graduatedCycleBottomShapeLayer.strokeColor = [UIColor redColor].CGColor;
//    return graduatedCycleBottomShapeLayer;
    
    UIColor *topColor = [UIColor colorWithRed:23/255.0 green:100/255.0 blue:255/255.0 alpha:1];//#186aff
    UIColor *bottomColor = [UIColor colorWithRed:5/255.0 green:180/255.0 blue:254/255.0 alpha:1];//#05cffe
    NSArray *colors = @[(id)topColor.CGColor, (id)bottomColor.CGColor];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colors;
    gradientLayer.shadowPath = graduatedCycleBottomShapeLayer.path;
    gradientLayer.frame = graduatedCycleView.bounds;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    [gradientLayer setMask:graduatedCycleBottomShapeLayer]; // 设置进度layer 颜色 渐变
    
    return gradientLayer;
}

- (CALayer *)cjGraduatedCycleView:(CJGraduatedCycleView *)graduatedCycleView actualGraduatedCycleUpperLayerWithPossibleUpperLayer:(CAShapeLayer *)graduatedCyclePossibleUpperLayer
{
    graduatedCyclePossibleUpperLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    return graduatedCyclePossibleUpperLayer;
}

- (CALayer *)cjGraduatedCycleView:(CJGraduatedCycleView *)graduatedCycleView actualFullCycleBottomLayerWithPossibleBottomLayer:(CAShapeLayer *)fullCyclePossibleBottomLayer
{
    UIColor *topColor = [UIColor colorWithRed:23/255.0 green:100/255.0 blue:255/255.0 alpha:1];//#186aff
    UIColor *bottomColor = [UIColor colorWithRed:5/255.0 green:180/255.0 blue:254/255.0 alpha:1];//#05cffe
    NSArray *colors = @[(id)topColor.CGColor, (id)bottomColor.CGColor];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colors;
    gradientLayer.shadowPath = fullCyclePossibleBottomLayer.path;
    gradientLayer.frame = graduatedCycleView.bounds;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    [gradientLayer setMask:fullCyclePossibleBottomLayer]; // 设置进度layer 颜色 渐变
    
    return gradientLayer;
}

- (CALayer *)cjGraduatedCycleView:(CJGraduatedCycleView *)graduatedCycleView actualFullCycleUpperLayerWithPossibleUpperLayer:(CAShapeLayer *)fullCyclePossibleUpperLayer
{
    fullCyclePossibleUpperLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    return fullCyclePossibleUpperLayer;
}


- (void)cjGraduatedCycleView:(CJGraduatedCycleView *)gradientCycleView updateLabelWithProgressValue:(CGFloat)progressValue {
    self.leaveSecond = gradientCycleView.maxValue - progressValue;
    
    NSInteger leaveSecondCount = (NSInteger)(gradientCycleView.maxValue - progressValue);
    NSInteger secondValue = leaveSecondCount%60;
    NSInteger minuteValue = leaveSecondCount/60;
    NSString *timeString = [NSString stringWithFormat:@"%02ld:%02ld", minuteValue, secondValue];
    NSString *suffixString = NSLocalizedString(@"后", nil);
    NSString *fullString = [NSString stringWithFormat:@"%@%@", timeString, suffixString];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:fullString];
    NSDictionary *timeAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:36],
                                     NSForegroundColorAttributeName:[UIColor colorWithRed:15/255.0 green:145/255.0 blue:255/255.0 alpha:1], //#of9aff
                                     };
    NSDictionary *otherAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12],
                                      NSForegroundColorAttributeName:[UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1], //#4a4a4a
                                      };
    [attributedString addAttributes:timeAttributes range:NSMakeRange(0, timeString.length)];
    [attributedString addAttributes:otherAttributes range:NSMakeRange(timeString.length, suffixString.length)];
    //NSLog(@"second = %@", fullString);
    gradientCycleView.progressLabel.attributedText = attributedString;
}

- (void)cjGraduatedCycleView:(CJGraduatedCycleView *)gradientCycleView didFinishUpdateWithInfo:(CGFloat)progressValue {
    if (self.countDownFinishBlock) {
        self.countDownFinishBlock(self);
    }
}

#pragma mark - 导航栏的设置
///导航栏的重置
- (void)navigationBarReset {
    //[self.navigationController.navigationBar cj_reset];
    [self.navigationController.navigationBar cj_setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setShadowImage:nil];
    
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
//    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
        //改变导航栏的字体
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
//                                                                          NSFontAttributeName:[UIFont systemFontOfSize:21]}];
}

///导航栏在当前页面的自定义
- (void)navigationBarCustomSet {
     [self.navigationController.navigationBar cj_setBackgroundColor:[UIColor clearColor]];//改变导航栏背景色
    [self.navigationController.navigationBar cj_removeUnderline];//删除导航栏的下划线
    //即[self.navigationController.navigationBar setShadowImage:[UIImage new]];
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
