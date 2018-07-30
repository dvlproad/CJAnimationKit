//
//  PeiwoAnimationViewController.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "PeiwoAnimationViewController.h"
#import "AppDelegate.h"

#import <CJBaseUIKit/UIView+CJDragAction.h>
#import <CJBaseUIKit/UIView+CJKeepBounds.h>

#import "UIView+CJZoomFrame.h"

@interface PeiwoAnimationViewController ()

@property (nonatomic, assign) CJLayerAddType layerAddType;

@end

@implementation PeiwoAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.    
}

- (IBAction)testClick:(id)sender {
    NSLog(@"点击了按钮");
}

- (IBAction)doAnimation:(id)sender {
    CJLayerAddType layerAddType = CJLayerAddTypeSetMask;
    //CJLayerAddType layerAddType = CJLayerAddTypeAddSublayer;
    
    if (self.testLayerInFloatingWindowSwitch.isOn == NO) {
        CGRect layerFrame = CGRectMake(100, 100, 100, 200);
        [self.animationView cj_addPeiwoLayerWithLayerFrame:layerFrame layerAnimated:YES layerAddType:layerAddType whenAnimationDidStopUpdateFrameToLayerFrame:YES andDoSubviewSetupBlock:nil];
        
    } else {
        AppDelegate *deleage = (AppDelegate *)[UIApplication sharedApplication].delegate;
        deleage.cjFloatingWindow.hidden = NO;
        deleage.cjFloatingWindow.cjDragEnable = YES;
        [deleage.cjFloatingWindow cj_addWindowSubview:self.animationView];
        //deleage.cjFloatingWindow.backgroundColor = [UIColor redColor];
        
        CGRect layerFrame = CGRectMake(100, 100, 100, 200);
        [deleage.cjFloatingWindow cj_addPeiwoLayerWithLayerFrame:layerFrame layerAnimated:YES layerAddType:layerAddType whenAnimationDidStopUpdateFrameToLayerFrame:YES andDoSubviewSetupBlock:^{
            for (UIView *subview in deleage.cjFloatingWindow.subviews) {
                [subview removeFromSuperview];
            }
            
            CGRect buttonFrame = CGRectMake(0, 0, CGRectGetWidth(layerFrame), CGRectGetHeight(layerFrame));
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:buttonFrame];
            [button setImage:[UIImage imageNamed:@"bg.jpg"] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor orangeColor]];
            [deleage.cjFloatingWindow addSubview:button];
        }];

    }
    
    
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
