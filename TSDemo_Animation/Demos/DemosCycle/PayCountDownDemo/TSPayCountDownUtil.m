//
//  TSPayCountDownUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "TSPayCountDownUtil.h"
#import "PayCountDownViewController.h"

@implementation TSPayCountDownUtil


+ (void)presentPayCountDownFromViewController:(UIViewController *)fromViewController {
    PayCountDownViewController *payCountDownViewController = [[PayCountDownViewController alloc] init];
    payCountDownViewController.payFen = 1000;
    payCountDownViewController.totalSecond = 60;
    payCountDownViewController.leaveSecond = 20;
    
    __weak typeof(self)weakSelf = self;
    payCountDownViewController.goBackBlock = ^(PayCountDownViewController *mPayCountDownViewController) {
//            UIViewController *cancelOrderViewController = [[UIViewController alloc] init];
//            cancelOrderViewController.view.backgroundColor = [UIColor redColor];
//            [mPayCountDownViewController.navigationController pushViewController:cancelOrderViewController animated:YES];
        [mPayCountDownViewController dismissViewControllerAnimated:YES completion:nil];
    };
    payCountDownViewController.startPayBlock = ^(PayCountDownViewController *mPayCountDownViewController) {
        [weakSelf goPrepayViewControllerFromViewController:mPayCountDownViewController];
    };
    payCountDownViewController.countDownFinishBlock = ^(PayCountDownViewController *mPayCountDownViewController) {
        UIViewController *cancelOrderViewController = [[UIViewController alloc] init];
        cancelOrderViewController.view.backgroundColor = [UIColor redColor];
        [mPayCountDownViewController.navigationController pushViewController:cancelOrderViewController animated:YES];
    };
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:payCountDownViewController];
    [fromViewController presentViewController:navigationController animated:YES completion:nil];
}

+ (void)goPrepayViewControllerFromViewController:(UIViewController *)viewController {
    UIViewController *prepayViewController = [[UIViewController alloc] init];
    prepayViewController.view.backgroundColor = [UIColor whiteColor];
    prepayViewController.title = NSLocalizedString(@"支付", nil);
    [viewController.navigationController pushViewController:prepayViewController animated:YES];
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
