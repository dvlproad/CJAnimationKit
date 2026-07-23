//
//  RefreshHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "RefreshHomeViewController.h"

#import "RefreshAnimateViewController.h"

@interface RefreshHomeViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}

@end

@implementation RefreshHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"Refresh首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    //Refresh
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"Refresh";
        {
            //BaseAnimationDemo
            CQDMModuleModel *refreshAnimateModule = [[CQDMModuleModel alloc] init];
            refreshAnimateModule.title = @"刷新动画";
            refreshAnimateModule.classEntry = [RefreshAnimateViewController class];
            [sectionDataModel.values addObject:refreshAnimateModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
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
