//
//  RadarAnimationViewController.h
//  CoreAnimationDemo
//
//  Created by 李超前 on 2017/5/19.
//  Copyright © 2017年 李超前. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadarAnimationViewController : UIViewController {
    
}
@property (nonatomic, weak) IBOutlet UIButton *radarButton1;
@property (nonatomic, weak) IBOutlet UIButton *radarButton2;
@property (nonatomic, weak) IBOutlet UIButton *radarButton3;

@property (nonatomic, strong) CAShapeLayer *cycleRadarShapeLayer;

@end
