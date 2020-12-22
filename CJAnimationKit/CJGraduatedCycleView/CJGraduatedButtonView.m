//
//  CJGraduatedButtonView.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2018/7/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJGraduatedButtonView.h"

@interface CJGraduatedButtonView ()


@end





@implementation CJGraduatedButtonView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.graduatedCycleLineWidth = 25;
    self.fullCycleLineWidth = 10;
    
    self.graduatedCycleUpStrokeColor = [UIColor greenColor];
    self.graduatedCycleBottomStrokeColor = [UIColor lightGrayColor];
    
    self.fullCycleUpStrokeColor = [UIColor greenColor];
    self.fullCycleBottomStrokeColor = [UIColor colorWithRed:180/255.0 green:195/255.0 blue:208/255.0 alpha:1]; //#cfd4dd
}



- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIBezierPath *fullCyclePath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:5];
    CGColorRef fullUpStrokeColor = self.fullCycleUpStrokeColor.CGColor;
    _fullCyclePossibleUpperLayer = [self createFullCycleShapeLayerWithBezierPath:fullCyclePath strokeColor:fullUpStrokeColor];
    _fullCyclePossibleUpperLayer.strokeStart = 0;
    _fullCyclePossibleUpperLayer.strokeEnd =   1;
    CALayer *actualFullCycleUpperLayer = [self gradientLayerToLayer:_fullCyclePossibleUpperLayer];
    [self.layer addSublayer:actualFullCycleUpperLayer ];  // 把bottomlayer 加到自己的layer 上

}


- (CALayer *)gradientLayerToLayer:(CAShapeLayer *)possibleUpperLayer
{
    NSArray *colors = @[(id)[UIColor greenColor].CGColor,
                        (id)[UIColor redColor].CGColor];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colors;
    gradientLayer.shadowPath = possibleUpperLayer.path;
    gradientLayer.frame = possibleUpperLayer.bounds;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    //gradientLayer.locations = @[@0.2, @1];
    
    [gradientLayer setMask:possibleUpperLayer]; // 设置进度layer 颜色 渐变
    
    return gradientLayer;
}


- (CAShapeLayer *)createFullCycleShapeLayerWithBezierPath:(UIBezierPath *)path
                                                   strokeColor:(CGColorRef)strokeColor
{
    NSAssert(strokeColor != nil, @"Error:strokeColor不能为空，否则会导致无法正常添加图层");
    
    CAShapeLayer *graduatedCycleShapeLayer = [[CAShapeLayer alloc] init];
    graduatedCycleShapeLayer.frame = self.bounds;
    
    graduatedCycleShapeLayer.path = path.CGPath;
    //线段的开头为圆角
    graduatedCycleShapeLayer.lineCap = kCALineCapRound;
    
    graduatedCycleShapeLayer.lineWidth = self.fullCycleLineWidth;
    graduatedCycleShapeLayer.strokeColor = strokeColor;
    graduatedCycleShapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    return graduatedCycleShapeLayer;
}




@end
