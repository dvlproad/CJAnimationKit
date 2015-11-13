//
//  UIViewDemo.m
//  CoreAnimationDemo
//
//  Created by lichq on 15/11/13.
//  Copyright (c) 2015年 李超前. All rights reserved.
//

#import "UIViewDemo.h"

@interface UIViewDemo ()

@end

@implementation UIViewDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)btnAction_View:(UIButton *)sender{
    CGFloat y = CGRectGetMaxY(sender.frame);
    CGFloat width = 100;
    CGFloat height = 100;
    CGRect rect_hidden = CGRectMake(0, - height, width, height);
    CGRect rect_show = CGRectMake(0, y, width, height);
    
    UIView *customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    customView.backgroundColor = [UIColor greenColor];
    [customView setFrame:rect_hidden];//注意点：setFrame要在此view被addSubview之前调用
    [self.view addSubview:customView];
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [customView setFrame:rect_show];
    } completion:^(BOOL finished){
        
    }];
}


- (IBAction)btnAction_ViewController:(id)sender{
    CGFloat y = 64;
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height - y;
    CGRect rect_hidden = CGRectMake(0, - height, width, height);
    CGRect rect_show = CGRectMake(0, y, width, height);
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [vc.view setFrame:rect_hidden]; //注意点：setFrame要在此view被addSubview之前调用
    [self.view addSubview:vc.view];
    [self addChildViewController:vc];//别漏了
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [vc.view setFrame:rect_show];
        
    } completion:^(BOOL finished){
        
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
