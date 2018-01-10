//
//  SampleLayerMaskViewController.m
//  CoreAnimationDemo
//
//  Created by 李超前 on 2018/1/11.
//  Copyright © 2018年 李超前. All rights reserved.
//

#import "SampleLayerMaskViewController.h"
#import "CAShapeLayerFactory.h"

@interface SampleLayerMaskViewController ()

@end

@implementation SampleLayerMaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)buttonAction:(id)sender {
    CAShapeLayerFactory *factory = [[CAShapeLayerFactory alloc] init];
    [factory Bat:sender];
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
