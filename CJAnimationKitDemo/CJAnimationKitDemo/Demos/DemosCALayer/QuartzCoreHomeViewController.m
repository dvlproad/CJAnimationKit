//
//  QuartzCoreHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "QuartzCoreHomeViewController.h"

#import "TSShakeViewController.h"

#import "RadarAnimationViewController.h"
#import "PeiwoAnimationViewController.h"
#import "ShimmerAnimationViewController.h"
#import "SampleLayerMaskViewController.h"

@interface QuartzCoreHomeViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}

@end

@implementation QuartzCoreHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"Home首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // 视图抖动动画
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"视图抖动动画";
        {
            CQDMModuleModel *module = [[CQDMModuleModel alloc] init];
            module.title = @"视图抖动动画";
            module.classEntry = [TSShakeViewController class];
            [sectionDataModel.values addObject:module];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //CALayer
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"CALayer";
        {
            //RadarAnimation
            CQDMModuleModel *radarAnimationModule = [[CQDMModuleModel alloc] init];
            radarAnimationModule.title = @"RadarAnimation(雷达动画)";
            radarAnimationModule.classEntry = [RadarAnimationViewController class];
            [sectionDataModel.values addObject:radarAnimationModule];
            
            //PeiwoAnimation
            CQDMModuleModel *peiwoAnimationModule = [[CQDMModuleModel alloc] init];
            peiwoAnimationModule.title = @"PeiwoAnimation(陪我动画)";
            peiwoAnimationModule.classEntry = [PeiwoAnimationViewController class];
            [sectionDataModel.values addObject:peiwoAnimationModule];
            
            //ShimmerAnimationViewController
            CQDMModuleModel *shimmerAnimationModule = [[CQDMModuleModel alloc] init];
            shimmerAnimationModule.title = @"shimmerAnimation(闪光动画)";
            shimmerAnimationModule.classEntry = [ShimmerAnimationViewController class];
            [sectionDataModel.values addObject:shimmerAnimationModule];
            
            //ShimmerAnimationViewController
            CQDMModuleModel *sampleLayerMaskModule = [[CQDMModuleModel alloc] init];
            sampleLayerMaskModule.title = @"切出你心中的那个图案";
            sampleLayerMaskModule.classEntry = [SampleLayerMaskViewController class];
            [sectionDataModel.values addObject:sampleLayerMaskModule];
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
