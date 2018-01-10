//
//  QuartzCoreHomeViewController.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "QuartzCoreHomeViewController.h"

#import "ModuleModel.h"

#import "BaseAnimationViewController.h"
#import "RadarAnimationViewController.h"
#import "PeiwoAnimationViewController.h"

#import "ShimmerAnimationViewController.h"

#import "SampleLayerMaskViewController.h"


#import "RefreshAnimateViewController.h"

@interface QuartzCoreHomeViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}

@end

@implementation QuartzCoreHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"Home首页", nil);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    //CoreAnimate
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"CoreAnimate";
        {
            //BaseAnimationDemo
            ModuleModel *baseAnimationModuleModel = [[ModuleModel alloc] init];
            baseAnimationModuleModel.title = @"BaseAnimationDemo";
            baseAnimationModuleModel.classEntry = [BaseAnimationViewController class];
            [sectionDataModel.values addObject:baseAnimationModuleModel];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //CALayer
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"CALayer";
        {
            //RadarAnimation
            ModuleModel *radarAnimationModule = [[ModuleModel alloc] init];
            radarAnimationModule.title = @"RadarAnimation(雷达动画)";
            radarAnimationModule.classEntry = [RadarAnimationViewController class];
            [sectionDataModel.values addObject:radarAnimationModule];
            
            //PeiwoAnimation
            ModuleModel *peiwoAnimationModule = [[ModuleModel alloc] init];
            peiwoAnimationModule.title = @"PeiwoAnimation(陪我动画)";
            peiwoAnimationModule.classEntry = [PeiwoAnimationViewController class];
            [sectionDataModel.values addObject:peiwoAnimationModule];
            
            //ShimmerAnimationViewController
            ModuleModel *shimmerAnimationModule = [[ModuleModel alloc] init];
            shimmerAnimationModule.title = @"shimmerAnimation(闪光动画)";
            shimmerAnimationModule.classEntry = [ShimmerAnimationViewController class];
            [sectionDataModel.values addObject:shimmerAnimationModule];
            
            
            
            //ShimmerAnimationViewController
            ModuleModel *sampleLayerMaskModule = [[ModuleModel alloc] init];
            sampleLayerMaskModule.title = @"切出你心中的那个图案";
            sampleLayerMaskModule.classEntry = [SampleLayerMaskViewController class];
            [sectionDataModel.values addObject:sampleLayerMaskModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //CoreAnimate && CALayer
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"CoreAnimate && CALayer";
        {
            //BaseAnimationDemo
            ModuleModel *refreshAnimateModule = [[ModuleModel alloc] init];
            refreshAnimateModule.title = @"刷新动画";
            refreshAnimateModule.classEntry = [RefreshAnimateViewController class];
            [sectionDataModel.values addObject:refreshAnimateModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionDataModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    NSArray *dataModels = sectionDataModel.values;
    
    return dataModels.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    
    NSString *indexTitle = sectionDataModel.theme;
    return indexTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    NSArray *dataModels = sectionDataModel.values;
    ModuleModel *moduleModel = [dataModels objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = moduleModel.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"didSelectRowAtIndexPath = %ld %ld", indexPath.section, indexPath.row);
    
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    NSArray *dataModels = sectionDataModel.values;
    ModuleModel *moduleModel = [dataModels objectAtIndex:indexPath.row];
    
    Class classEntry = moduleModel.classEntry;
    NSString *nibName = NSStringFromClass(moduleModel.classEntry);
    
    
    UIViewController *viewController = nil;
    
    NSString *clsString = NSStringFromClass(moduleModel.classEntry);
    if ([clsString isEqualToString:NSStringFromClass([UIViewController class])])
    {
        viewController = [[classEntry alloc] init];
        viewController.view.backgroundColor = [UIColor whiteColor];
        
    } else {
        viewController = [[classEntry alloc] initWithNibName:nibName bundle:nil];
    }
    viewController.title = NSLocalizedString(moduleModel.title, nil);
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
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
