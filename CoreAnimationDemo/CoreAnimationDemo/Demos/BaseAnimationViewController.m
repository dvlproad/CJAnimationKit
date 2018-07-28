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
}

//
- (IBAction)goUIViewDemo:(id)sender{
    UIViewDemo *vc = [[UIViewDemo alloc]initWithNibName:@"UIViewDemo" bundle:nil];
    vc.title = [sender titleForState:UIControlStateNormal];
    [self.navigationController pushViewController:vc animated:YES];
}


//
- (IBAction)goBasicAnimationVC:(id)sender{
    BasicAnimationVC *vc = [[BasicAnimationVC alloc]initWithNibName:@"BasicAnimationVC" bundle:nil];
    vc.title = [sender titleForState:UIControlStateNormal];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)goKeyframeAnimationVC:(id)sender{
    KeyframeAnimationVC *vc = [[KeyframeAnimationVC alloc]initWithNibName:@"KeyframeAnimationVC" bundle:nil];
    vc.title = [sender titleForState:UIControlStateNormal];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goBezierPathAnimationVC:(id)sender{
    BezierPathAnimationVC *vc = [[BezierPathAnimationVC alloc]initWithNibName:@"BezierPathAnimationVC" bundle:nil];
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
