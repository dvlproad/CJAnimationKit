//
//  PopupHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "PopupHomeViewController.h"
#import "BasicAnimationVC.h"

@interface PopupHomeViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}

@end

@implementation PopupHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"Popup首页", nil);

    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    //CoreAnimate
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"CoreAnimate";
        {
            //BaseAnimationDemo
            CQDMModuleModel *baseAnimationModuleModel = [[CQDMModuleModel alloc] init];
            baseAnimationModuleModel.title = @"BaseAnimationDemo";
            baseAnimationModuleModel.classEntry = [BasicAnimationVC class];
            [sectionDataModel.values addObject:baseAnimationModuleModel];
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
