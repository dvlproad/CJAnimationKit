//
//  PeiwoAnimationViewController.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "PeiwoAnimationViewController.h"
#import <CQDemoResource/CQTSAssetSourceUtil.h>
#import <CQDemoProtocol/CQTSDemoAppDelegateProtocol.h>

#import <CJBaseUIKit/UIView+CJDragAction.h>
//#import <CJBaseUIKit/UIView+CJKeepBounds.h>
#import <CJAnimationKit/UIView+CJZoomFrame.h>

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
        id<CQTSDemoAppDelegateProtocol> delegate = (id<CQTSDemoAppDelegateProtocol>)[UIApplication sharedApplication].delegate;
        delegate.cqtsFloatingWindow.hidden = NO;
        delegate.cqtsFloatingWindow.cjDragEnable = YES;
        [delegate.cqtsFloatingWindow addWindowSubview:self.animationView];
        //delegate.cjFloatingWindow.backgroundColor = [UIColor redColor];
        
        CGRect layerFrame = CGRectMake(100, 100, 100, 200);
        [delegate.cqtsFloatingWindow cj_addPeiwoLayerWithLayerFrame:layerFrame layerAnimated:YES layerAddType:layerAddType whenAnimationDidStopUpdateFrameToLayerFrame:YES andDoSubviewSetupBlock:^{
            for (UIView *subview in delegate.cqtsFloatingWindow.subviews) {
                [subview removeFromSuperview];
            }
            
            CGRect buttonFrame = CGRectMake(0, 0, CGRectGetWidth(layerFrame), CGRectGetHeight(layerFrame));
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:buttonFrame];
            [button setImage:[CQTSAssetSourceUtil localImageAtIndex:0 folderNames:@[@"jpg"]] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor orangeColor]];
            [delegate.cqtsFloatingWindow addSubview:button];
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
