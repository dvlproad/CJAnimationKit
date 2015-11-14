//
//  ViewController.m
//  CoreAnimationDemo
//
//  Created by lichq on 15/10/13.
//  Copyright (c) 2015年 李超前. All rights reserved.
//

#import "ViewController.h"

#import "UIViewDemo.h"

#import "BasicAnimationVC.h"
#import "KeyframeAnimationVC.h"
#import "BezierPathAnimationVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = NSLocalizedString(@"View自身的动画", nil);
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

@end
