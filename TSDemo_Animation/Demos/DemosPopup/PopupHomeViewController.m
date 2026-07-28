//
//  PopupHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "PopupHomeViewController.h"

#import <TSDemo_PopupAnimation/TSBaseAnimationHomeViewController.h>

#import "UIViewDemo.h"

@interface PopupHomeViewController () {
    
}

@end

@implementation PopupHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"Popup首页", nil);

    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    //PopupAnimate
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"PopupAnimate";
        {
            CQDMModuleModel *baseAnimationModuleModel = [[CQDMModuleModel alloc] init];
            baseAnimationModuleModel.title = @"PopupBaseAnimate";
            baseAnimationModuleModel.classEntry = [TSBaseAnimationHomeViewController class];
            [sectionDataModel.values addObject:baseAnimationModuleModel];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"PopupAnimate";
        {
            CQDMModuleModel *baseAnimationModuleModel = [[CQDMModuleModel alloc] init];
            baseAnimationModuleModel.title = @"下拉的视图";
            baseAnimationModuleModel.classEntry = [UIViewDemo class];
            baseAnimationModuleModel.isCreateByXib = YES;
            baseAnimationModuleModel.xibBundle = [NSBundle bundleForClass:[UIViewDemo class]];
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
