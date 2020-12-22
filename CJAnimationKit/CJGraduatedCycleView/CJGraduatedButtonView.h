//
//  CJGraduatedButtonView.h
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2018/7/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CJGraduatedButtonView : UIButton {
    
}
@property (nonatomic, strong) CAShapeLayer *fullCyclePossibleUpperLayer;  // 小的进度progressLayer(对外提供)

@property (nonatomic) UIColor *graduatedCycleBottomStrokeColor;
@property (nonatomic) UIColor *graduatedCycleUpStrokeColor;
@property (nonatomic) UIColor *fullCycleBottomStrokeColor;
@property (nonatomic) UIColor *fullCycleUpStrokeColor;

@property (nonatomic, assign) CGFloat graduatedCycleLineWidth; // 线宽
@property (nonatomic, assign) CGFloat fullCycleLineWidth; // 圆进度的线宽

@end
