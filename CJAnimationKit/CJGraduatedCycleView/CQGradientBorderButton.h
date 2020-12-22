//
//  CQGradientBorderButton.h
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2018/7/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CQGradientBorderButton : UIButton {
    
}
@property (nonatomic) UIColor *fullCycleUpStrokeColor;

@property (nonatomic, assign) CGFloat fullCycleLineWidth; // 圆进度的线宽

- (instancetype)initWithCornerRadius:(CGFloat)cornerRadius shouldEffect:(BOOL)shouldEffect NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
+ (instancetype)buttonWithType:(UIButtonType)buttonType NS_UNAVAILABLE;

@end
