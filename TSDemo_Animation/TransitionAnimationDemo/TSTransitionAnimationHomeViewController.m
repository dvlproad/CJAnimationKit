//
//  TSTransitionAnimationHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "TSTransitionAnimationHomeViewController.h"
#import <CQDemoResource/CQTSAssetSourceUtil.h>
#import <CJAnimationKit/UIView+CJTransitionAnimation.h>

@interface TSTransitionAnimationHomeViewController ()

@end

@implementation TSTransitionAnimationHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"View转场动画(UIView+CJTransitionAnimation)", nil);
    
    [self _setupBackgroundImage:0];
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    //UIViewAnimationTransition
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"系统的转场动画";
        {
            CQDMModuleModel *animationModule = [[CQDMModuleModel alloc] init];
            animationModule.title = @"0.None(生硬效果)";
            animationModule.actionBlock = ^{
                [self.tableView cj_systemTransition:UIViewAnimationTransitionNone];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CQDMModuleModel *animationModule = [[CQDMModuleModel alloc] init];
            animationModule.title = @"1.FlipFromLeft(左翻转效果)";
            animationModule.actionBlock = ^{
                [self.tableView cj_systemTransition:UIViewAnimationTransitionFlipFromLeft];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CQDMModuleModel *animationModule = [[CQDMModuleModel alloc] init];
            animationModule.title = @"2.FlipFromRight(右翻转效果)";
            animationModule.actionBlock = ^{
                [self.tableView cj_systemTransition:UIViewAnimationTransitionFlipFromRight];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CQDMModuleModel *animationModule = [[CQDMModuleModel alloc] init];
            animationModule.title = @"3.CurlUp(上翻页效果)";
            animationModule.actionBlock = ^{
                [self.tableView cj_systemTransition:UIViewAnimationTransitionCurlUp];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CQDMModuleModel *animationModule = [[CQDMModuleModel alloc] init];
            animationModule.title = @"4.CurlDown(下翻页效果)";
            animationModule.actionBlock = ^{
                [self.tableView cj_systemTransition:UIViewAnimationTransitionCurlDown];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //CommonTransition:Fade淡入淡出、MoveIn覆盖、Push推挤、Reveal揭开
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"自定义的(常见)转场动画";
        {
            CQDMModuleModel *animationModule = [[CQDMModuleModel alloc] init];
            animationModule.title = @"Fade(淡化效果)";
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_commonTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCommonTypeFade];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CQDMModuleModel *animationModule = [[CQDMModuleModel alloc] init];
            animationModule.title = @"MoveIn(覆盖效果)";
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_commonTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCommonTypeMoveIn];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CQDMModuleModel *animationModule = [[CQDMModuleModel alloc] init];
            animationModule.title = @"Push(推挤效果)";
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_commonTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCommonTypePush];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CQDMModuleModel *animationModule = [[CQDMModuleModel alloc] init];
            animationModule.title = @"Reveal(揭开效果)";
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_commonTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCommonTypeReveal];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //CustomTransition
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"自定义的(不常见)转场动画";
        {
            CQDMModuleModel *animationModule = [[CQDMModuleModel alloc] init];
            animationModule.title = @"Cube(3D立方效果)";
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_customTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCustomTypeCube];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CQDMModuleModel *animationModule = [[CQDMModuleModel alloc] init];
            animationModule.title = @"SuckEffect(吮吸效果)";
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_customTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCustomTypeSuckEffect];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CQDMModuleModel *animationModule = [[CQDMModuleModel alloc] init];
            animationModule.title = @"OglFlip(翻转效果)";
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_customTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCustomTypeOglFlip];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        
        {
            CQDMModuleModel *animationModule = [[CQDMModuleModel alloc] init];
            animationModule.title = @"RippleEffect(波纹效果)";
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_customTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCustomTypeRippleEffect];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CQDMModuleModel *animationModule = [[CQDMModuleModel alloc] init];
            animationModule.title = @"PageCurl(翻页效果)";
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_customTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCustomTypePageCurl];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CQDMModuleModel *animationModule = [[CQDMModuleModel alloc] init];
            animationModule.title = @"PageUnCurl(反翻页效果)";
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_customTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCustomTypePageUnCurl];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CQDMModuleModel *animationModule = [[CQDMModuleModel alloc] init];
            animationModule.title = @"CameraIrisHollowOpen(开镜头效果)";
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_customTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCustomTypeCameraIrisHollowOpen];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        {
            CQDMModuleModel *animationModule = [[CQDMModuleModel alloc] init];
            animationModule.title = @"CameraIrisHollowClose(关镜头效果)";
            animationModule.actionBlock = ^{
                CJTransitionDirection transitionDirection = CJTransitionDirectionFromRight;
                [self.tableView cj_customTransitionFrom:transitionDirection
                                      withAnimationType:CJAnimateCustomTypeCameraIrisHollowClose];
                [self changeBackgroundImage];
            };
            [sectionDataModel.values addObject:animationModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    self.sectionDataModels = sectionDataModels;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CQDMSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    NSArray *dataModels = sectionDataModel.values;
    CQDMModuleModel *moduleModel = [dataModels objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = moduleModel.title;
    cell.detailTextLabel.text = moduleModel.content;
    cell.backgroundColor = [UIColor clearColor]; //确保背景正确
    
    return cell;
}


- (void)changeBackgroundImage {
    static int i = 0;
    if (i == 0) {
        i = 1;
        [self _setupBackgroundImage:i];
        
    } else {
        i = 0;
        [self _setupBackgroundImage:i];
    }
}

- (void)_setupBackgroundImage:(NSInteger)imageIndex {
    if (imageIndex % 2 == 0) {
        UIImage *backgroundImage = [CQTSAssetSourceUtil localImageAtIndex:0 folderNames:@[@"jpg"]];
        self.tableView.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    } else {
        UIImage *backgroundImage = [CQTSAssetSourceUtil localImageAtIndex:1 folderNames:@[@"jpg"]];
        self.tableView.backgroundColor = [UIColor colorWithPatternImage:backgroundImage] ;
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
