//
//  CycleHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CycleHomeViewController.h"

#import "GradientCycleViewController.h"
#import "PayCountDownViewController.h"

@interface CycleHomeViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}

@end

@implementation CycleHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"Cycle首页", nil);
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(88);;
        make.bottom.mas_equalTo(self.view);
    }];
    self.tableView = tableView;
    
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    //GradientCycle
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"GradientCycleModule";
        {
            //BaseAnimationDemo
            CQDMModuleModel *gradientCycleModule = [[CQDMModuleModel alloc] init];
            gradientCycleModule.title = @"圆形渐变旋转圆环";
            gradientCycleModule.classEntry = [GradientCycleViewController class];
            [sectionDataModel.values addObject:gradientCycleModule];
        }
        {
            //BaseAnimationDemo
            CQDMModuleModel *gradientCycleModule = [[CQDMModuleModel alloc] init];
            gradientCycleModule.title = @"圆形渐变旋转圆环(事例)";
            gradientCycleModule.actionBlock = ^{
                [self presentPayCountDown];
            };
            [sectionDataModel.values addObject:gradientCycleModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}




- (void)presentPayCountDown {
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
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)goPrepayViewControllerFromViewController:(UIViewController *)viewController {
    UIViewController *prepayViewController = [[UIViewController alloc] init];
    prepayViewController.view.backgroundColor = [UIColor whiteColor];
    prepayViewController.title = NSLocalizedString(@"支付", nil);
    [viewController.navigationController pushViewController:prepayViewController animated:YES];
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
