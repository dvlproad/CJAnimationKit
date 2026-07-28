//
//  BaseAnimationViewController.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2017/5/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "BaseAnimationViewController.h"

#import "UIViewDemo.h"

#import "BasicAnimationVC.h"
#import "KeyframeAnimationVC.h"
#import "BezierPathAnimationVC.h"

@interface BaseAnimationViewController ()

@end

@implementation BaseAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"基础动画首页", nil);
}

//
- (IBAction)goUIViewDemo:(UIButton *)sender{
    CGFloat width = CGRectGetWidth(sender.frame);
    CGFloat height = 100;
    
    CGFloat x_show = CGRectGetMinX(sender.frame);
    CGFloat y_show = CGRectGetMaxY(sender.frame);
    
    CGFloat x_hide = x_show;
    CGFloat y_hide = y_show - height;
    
    CGRect rect_hide = CGRectMake(x_hide, y_hide, width, height);
    CGRect rect_show = CGRectMake(x_show, y_show, width, height);
    
    
    UIView *popupView = [[UIView alloc]initWithFrame:rect_show];
    popupView.backgroundColor = [UIColor redColor];
    [self.view addSubview:popupView];
    
    [popupView setFrame:rect_hide];
    [popupView setAlpha:0];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [popupView setFrame:rect_show];
        [popupView setAlpha:1];
    } completion:^(BOOL finished){
        
    }];
}


//
- (IBAction)goBasicAnimationVC:(id)sender{
    BasicAnimationVC *vc = [[BasicAnimationVC alloc]initWithNibName:@"BasicAnimationVC" bundle:[NSBundle bundleForClass:[self class]]];
    vc.title = [sender titleForState:UIControlStateNormal];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)goKeyframeAnimationVC:(id)sender{
    KeyframeAnimationVC *vc = [[KeyframeAnimationVC alloc]initWithNibName:@"KeyframeAnimationVC" bundle:[NSBundle bundleForClass:[self class]]];
    vc.title = [sender titleForState:UIControlStateNormal];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goBezierPathAnimationVC:(id)sender{
    BezierPathAnimationVC *vc = [[BezierPathAnimationVC alloc]initWithNibName:@"BezierPathAnimationVC" bundle:[NSBundle bundleForClass:[self class]]];
    vc.title = [sender titleForState:UIControlStateNormal];
    [self.navigationController pushViewController:vc animated:YES];
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
