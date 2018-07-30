//
//  QuartzCoreHomeViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <CJBaseUtil/CJSectionDataModel.h>
#import <CJBaseUtil/CJModuleModel.h>

@interface QuartzCoreHomeViewController : UIViewController {
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<CJSectionDataModel *> *sectionDataModels;

@end
