//
//  UIViewDemo.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 15/11/13.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "UIViewDemo.h"


@interface UIViewDemo ()

@end

@implementation UIViewDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


//Clip SubViews
- (IBAction)btnAction_View_code:(UIButton *)sender{
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


- (IBAction)btnAction_View_xib:(UIButton *)sender{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"WelcomeViewToPopup" owner:nil options:nil];
    WelcomeViewToPopup *popupView = (WelcomeViewToPopup *)[array lastObject];
    popupView.delegate = self;
    [self.view addSubview:popupView];
    
    
//    CGFloat width = CGRectGetWidth(popupView.frame);//采用默认view默认的with
    CGFloat width = CGRectGetWidth(sender.frame);
    CGFloat height = CGRectGetHeight(popupView.frame);
    
    
    CGFloat x_show = CGRectGetMinX(sender.frame);
    CGFloat y_show = CGRectGetMaxY(sender.frame);
    
    CGFloat x_hide = x_show;
    CGFloat y_hide = y_show - height;
    
    CGRect rect_hide = CGRectMake(x_hide, y_hide, width, height);
    CGRect rect_show = CGRectMake(x_show, y_show, width, height);
    
    [popupView setRect_hide:rect_hide];
    [popupView setFrame:rect_hide];
    [popupView setAlpha:0];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [popupView setFrame:rect_show];
        [popupView setAlpha:1];
    } completion:^(BOOL finished){
        
    }];
}




- (IBAction)btnAction_ViewController:(UIButton *)sender{
    WelcomeVCToPopup *popupVC = [[WelcomeVCToPopup alloc] initWithNibName:@"WelcomeVCToPopup" bundle:nil];
    popupVC.delegate = self;
    [self.view addSubview:popupVC.view];
    [self addChildViewController:popupVC];//别漏了
    
    
    CGFloat width = CGRectGetWidth(sender.frame);
    CGFloat height = 100;
    
    
    CGFloat x_show = CGRectGetMinX(sender.frame);
    CGFloat y_show = CGRectGetMaxY(sender.frame);
    
    CGFloat x_hide = x_show;
    CGFloat y_hide = y_show - height;
    
    CGRect rect_hide = CGRectMake(x_hide, y_hide, width, height);
    CGRect rect_show = CGRectMake(x_show, y_show, width, height);
    
    [popupVC setRect_hide:rect_hide];
    [popupVC.view setFrame:rect_hide];
    [popupVC.view setAlpha:0];
    
    
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [popupVC.view setFrame:rect_show];
        [popupVC.view setAlpha:1];
        
    } completion:^(BOOL finished){
        
    }];
}


#pragma mark - 委托
- (void)hiddenPopupView:(WelcomeViewToPopup *)popupView{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        CGRect rect_hidden = popupView.rect_hide;
        [popupView setFrame:rect_hidden];
        
    } completion:^(BOOL finished){
        
        [popupView removeFromSuperview];
        
    }];
}

- (void)hiddenPopupViewController:(WelcomeVCToPopup *)popupVC{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        
        CGRect rect_hidden = popupVC.rect_hide;
        [popupVC.view setFrame:rect_hidden];
        
    } completion:^(BOOL finished){
        
        [popupVC.view removeFromSuperview];
        
    }];
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
