//
//  BezierPathAnimationVC.h
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 15/10/13.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BezierPathAnimationVC : UIViewController{
    UIBezierPath *pacmanOpenPath;
    UIBezierPath *pacmanClosedPath;
    CAShapeLayer *shapeLayer;
    
}
@property (strong, nonatomic) IBOutlet UIImageView *imageV;

@end
