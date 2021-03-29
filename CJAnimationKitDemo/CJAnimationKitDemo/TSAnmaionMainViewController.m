//
//  TSAnmaionMainViewController.m
//  TSImageFilterDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "TSAnmaionMainViewController.h"

//#import "HomeViewController.h"
#import "QuartzCoreHomeViewController.h"
#import "BaseAnimationViewController.h"
#import "CycleHomeViewController.h"
#import "PopupHomeViewController.h"
#import "RefreshHomeViewController.h"



@interface TSAnmaionMainViewController ()

@end

@implementation TSAnmaionMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray<CQDMTabBarModel *> *tabBarModels = [[NSMutableArray alloc] init];
    {
        CQDMTabBarModel *tabBarModel = [[CQDMTabBarModel alloc] init];
        tabBarModel.title = NSLocalizedString(@"基础动画", nil);
        tabBarModel.classEntry = [BaseAnimationViewController class];
        tabBarModel.isCreateByXib = YES;
        [tabBarModels addObject:tabBarModel];
    }
    {
        CQDMTabBarModel *tabBarModel = [[CQDMTabBarModel alloc] init];
        tabBarModel.title = NSLocalizedString(@"QuartzCore", nil);
        tabBarModel.classEntry = [QuartzCoreHomeViewController class];
        [tabBarModels addObject:tabBarModel];
    }
    {
        CQDMTabBarModel *tabBarModel = [[CQDMTabBarModel alloc] init];
        tabBarModel.title = NSLocalizedString(@"Cycle", nil);
        tabBarModel.classEntry = [CycleHomeViewController class];
        [tabBarModels addObject:tabBarModel];
    }
    {
        CQDMTabBarModel *tabBarModel = [[CQDMTabBarModel alloc] init];
        tabBarModel.title = NSLocalizedString(@"Popup", nil);
        tabBarModel.classEntry = [PopupHomeViewController class];
        [tabBarModels addObject:tabBarModel];
    }
    
    {
        CQDMTabBarModel *tabBarModel = [[CQDMTabBarModel alloc] init];
        tabBarModel.title = NSLocalizedString(@"Refresh", nil);
        tabBarModel.classEntry = [RefreshHomeViewController class];
        [tabBarModels addObject:tabBarModel];
    }
    
    self.tabBarModels = tabBarModels;
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
