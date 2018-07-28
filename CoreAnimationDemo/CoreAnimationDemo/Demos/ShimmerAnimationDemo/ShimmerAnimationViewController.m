//
//  ShimmerAnimationViewController.m
//  CJAnimationKitDemo
//
//  Created by lichaoqian on 17/6/13.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ShimmerAnimationViewController.h"
#import "UIView+CJShimmering.h"

@interface ShimmerAnimationViewController () {
    
}
@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView;

@property (nonatomic, strong) IBOutlet FBShimmeringView *textShimmeringView;
@property (nonatomic, strong) IBOutlet UILabel *textLabel;

@property (nonatomic, strong) FBShimmeringView *imageShimmeringView;
@property (nonatomic, strong) UIImageView *headImageView;

@end

@implementation ShimmerAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    //①、文字闪光
    self.textShimmeringView.shimmering = YES;
    self.textShimmeringView.shimmeringOpacity = 0;
    self.textShimmeringView.shimmeringBeginFadeDuration = 0.3;
    self.textShimmeringView.shimmeringEndFadeDuration = 2;
    self.textShimmeringView.shimmeringAnimationOpacity = 0.6;
    
    self.textLabel.text = @"路漫漫其修远兮";
//    self.textShimmeringView.contentView = self.textLabel; //这里由于使用xib，导致textLabel重复被addSubview了
    ((FBShimmeringLayer *)self.textShimmeringView.layer).contentLayer = self.textLabel.layer;
    
    //②、图片闪光
    self.imageShimmeringView = [[FBShimmeringView alloc] initWithFrame:CGRectMake(140, 400, 80, 80)];
    self.imageShimmeringView.shimmering = YES;
    self.imageShimmeringView.shimmeringOpacity = 1;
    self.imageShimmeringView.shimmeringDirection = FBShimmerDirectionLeft;
    self.imageShimmeringView.shimmeringBeginFadeDuration = 0.3;
    self.imageShimmeringView.shimmeringPauseDuration = 2;
    self.imageShimmeringView.shimmeringHighlightWidth = 0.9;
    self.imageShimmeringView.shimmeringSpeed = 150;
    self.imageShimmeringView.layer.cornerRadius = 40;
    self.imageShimmeringView.clipsToBounds = YES;
    self.imageShimmeringView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageShimmeringView];
    
    self.headImageView = [[UIImageView alloc] initWithFrame:self.imageShimmeringView.bounds];
    self.headImageView.image = [UIImage imageNamed:@"bgRainbow.jpg"];
    self.headImageView.contentMode = UIViewContentModeScaleToFill;
    self.headImageView.layer.cornerRadius = 40;
    self.headImageView.clipsToBounds = YES;
    self.imageShimmeringView.contentView = self.headImageView;
    
    
    self.cjShimmerLabel.cjShimmering = YES;
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
