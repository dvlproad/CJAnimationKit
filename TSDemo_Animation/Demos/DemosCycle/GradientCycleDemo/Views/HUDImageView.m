//
//  HUDImageView.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2018/7/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "HUDImageView.h"
#import "UIView+CQHUDRotationAnimation.h"

@implementation HUDImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [UIImage imageNamed:@"av_call"];
        [self cq_addHUDRotationAnimation];
    }
    return self;
}



@end
