//
//  ViewController.m
//  CoreAnimationDemo
//
//  Created by 李超前 on 15/10/12.
//  Copyright © 2015年 李超前. All rights reserved.
//

#import "ViewController.h"
#import "BasicAnimationVC.h"
#import "KeyframeAnimationVC.h"

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
