//
//  ViewController.m
//  CoreAnimationDemo
//
//  Created by lichq on 15/10/13.
//  Copyright (c) 2015年 李超前. All rights reserved.
//

#import "ViewController.h"
#import "BasicAnimationVC.h"
#import "KeyframeAnimationVC.h"
#import "BezierPathAnimationVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)goBasicAnimationVC:(id)sender{
    BasicAnimationVC *con = [[BasicAnimationVC alloc]initWithNibName:@"BasicAnimationVC" bundle:nil];
    [self.navigationController pushViewController:con animated:YES];
}


- (IBAction)goKeyframeAnimationVC:(id)sender{
    KeyframeAnimationVC *con = [[KeyframeAnimationVC alloc]initWithNibName:@"KeyframeAnimationVC" bundle:nil];
    [self.navigationController pushViewController:con animated:YES];
}

- (IBAction)goBezierPathAnimationVC:(id)sender{
    BezierPathAnimationVC *con = [[BezierPathAnimationVC alloc]initWithNibName:@"BezierPathAnimationVC" bundle:nil];
    [self.navigationController pushViewController:con animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
