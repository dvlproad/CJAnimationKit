//
//  PayCountDownViewController.m
//  CoreAnimationDemo
//
//  Created by lichq on 2018/7/30.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "PayCountDownViewController.h"
#import "CJGraduatedCycleView+Countdown.h"

@interface PayCountDownViewController () <CJGraduatedCycleViewDelegate>

@property (nonatomic, strong) CJGraduatedCycleView *countdownGraduatedCycleView;

@end

@implementation PayCountDownViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGFloat randValue1 = arc4random_uniform(100 + 1) + 100;
    
    self.countdownGraduatedCycleView.maxValue = randValue1;
    CGFloat leaveSecondCount = arc4random_uniform(randValue1 + 1); //还剩几秒
    NSInteger goneSecondCount = randValue1-leaveSecondCount; //已经走了几秒，完整倒计时时候，此值一般是0秒
    [self.countdownGraduatedCycleView countDownWithGoneSecondCount:goneSecondCount];
    [self.countdownGraduatedCycleView updateProgressLabelWithAnimation:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //CGFloat screenHeight = CGRectGetHeight([[UIScreen mainScreen] bounds]);
    //CGFloat statusHeight = screenHeight == 812.0 ? 44 : 20;
    CGFloat statusHeight = CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]);
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setBackgroundColor:[UIColor colorWithRed:0.4 green:0.3 blue:0.4 alpha:0.5]];
    [closeButton setTitle:NSLocalizedString(@"返回", nil) forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [closeButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(23);
        make.top.mas_equalTo(self.view).mas_offset(statusHeight);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
    
    CJGraduatedCycleView *countdownGraduatedCycleView = [[CJGraduatedCycleView alloc] init];
    countdownGraduatedCycleView.backgroundColor = [UIColor whiteColor];
    countdownGraduatedCycleView.delegate = self;
    [self.view addSubview:countdownGraduatedCycleView];
    [countdownGraduatedCycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(self.view).mas_offset(240);
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
    
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [payButton setBackgroundColor:[UIColor colorWithRed:48/255.0 green:128/255.0 blue:255/255.0 alpha:1]];//#3388ff
    [payButton setTitle:NSLocalizedString(@"立即支付", nil) forState:UIControlStateNormal];
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
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payEvent {
    CGFloat randValue1 = arc4random_uniform(100 + 1) + 100;
    
    self.countdownGraduatedCycleView.maxValue = randValue1;
    CGFloat leaveSecondCount = arc4random_uniform(randValue1 + 1);
    NSInteger goneSecondCount = randValue1-leaveSecondCount;
    [self.countdownGraduatedCycleView countDownWithGoneSecondCount:goneSecondCount];
    [self.countdownGraduatedCycleView updateProgressLabelWithAnimation:YES];
}

#pragma mark - CJGraduatedCycleViewDelegate
- (CAGradientLayer *)cjGraduatedCycleView:(CJGraduatedCycleView *)graduatedCycleView
               gradientLayerForBezierPath:(UIBezierPath *)path
{
    UIColor *topColor = [UIColor colorWithRed:23/255.0 green:100/255.0 blue:255/255.0 alpha:1];//#186aff
    UIColor *bottomColor = [UIColor colorWithRed:5/255.0 green:180/255.0 blue:254/255.0 alpha:1];//#05cffe
    NSArray *colors = @[(id)topColor.CGColor, (id)bottomColor.CGColor];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colors;
    gradientLayer.shadowPath = path.CGPath;
    gradientLayer.frame = graduatedCycleView.bounds;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    
    return gradientLayer;
}

- (void)cjGraduatedCycleView:(CJGraduatedCycleView *)gradientCycleView updateLabelWithProgressValue:(CGFloat)progressValue {
    NSInteger leaveSecondCount = (NSInteger)(gradientCycleView.maxValue - gradientCycleView.labelValue);
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
    NSLog(@"second = %@", fullString);
    gradientCycleView.progressLabel.attributedText = attributedString;
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
