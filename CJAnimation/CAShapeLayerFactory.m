//
//  CAShapeLayerFactory.m
//  CoreAnimationDemo
//
//  Created by 李超前 on 2017/5/19.
//  Copyright © 2017年 李超前. All rights reserved.
//

#import "CAShapeLayerFactory.h"

@implementation CAShapeLayerFactory

/* 完整的描述请参见文件头部 */
+ (CAShapeLayer *)cjCircleShapeLayerForView:(UIView *)view circleType:(CJCircleType)circleType {
    CAShapeLayer *circleShape = [CAShapeLayer layer];
    
    CGFloat width = CGRectGetWidth(view.frame);
    CGFloat height = CGRectGetHeight(view.frame);
    
    CGFloat diameter = 0;   //圆的直径
    if (circleType == CJCircleTypeInscribe) {
        diameter = MIN(width, height);
    } else {
        diameter = sqrt(width*width + height*height);
    }
    CGFloat radius = diameter/2;
    
    CGPoint center = CGPointMake(width/2, height/2);
    CGRect frame = CGRectMake(center.x-radius, center.y-radius, diameter, diameter);
    
    //layer①使用frame的时候，颜色使用backgroundColor设置，②使用path的时候，颜色使用fillColor(填充色)和strokeColor(边框色)设置，边框大小通过lineWidth设置
    //circleShape.frame = frame;
    //circleShape.backgroundColor = [UIColor cyanColor].CGColor;
    
    
    circleShape.path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:radius].CGPath;
    circleShape.fillColor = [UIColor purpleColor].CGColor; //填充色设为透明
    circleShape.strokeColor = [UIColor purpleColor].CGColor;
    circleShape.lineWidth = 1;
    
    circleShape.opacity = 0; //显示的透明度(值为[0-1]，则0为透明即不显示)
    //要使用雷达radar效果的话必须有下面两行代码
    circleShape.position = center;
    circleShape.bounds = frame;
    
    return circleShape;
}







//1》尖角和半圆角按钮
#pragma mark 箭头按钮
-(void)arrowButtonTager:(UIView*)tagerView{
    CAShapeLayer  * shareLayer = [CAShapeLayer layer];
    /**
     创建动态可变的路径
     */
    CGMutablePathRef pathRef =CGPathCreateMutable();
    /**
     获取按钮的宽度&高度
     */
    CGFloat weightBtn = tagerView.bounds.size.width;
    CGFloat heightBtn = tagerView.bounds.size.height;
    /**
     开始设置路径的走向
     */
    CGPathMoveToPoint(pathRef,NULL, 0,0);
    /**
     开始添加路径
     */
    CGPathAddLineToPoint(pathRef,NULL, weightBtn- heightBtn *0.5, 0.0);
    CGPathAddLineToPoint(pathRef,NULL, weightBtn, heightBtn *0.5);
    CGPathAddLineToPoint(pathRef,NULL, weightBtn- heightBtn *0.5, heightBtn);
    CGPathAddLineToPoint(pathRef,NULL, 0.0, heightBtn);
    CGPathAddLineToPoint(pathRef,NULL, 0.0,0.0);
    /**
     闭合路径
     */
    CGPathCloseSubpath(pathRef);
    /**
     进行路径的渲染
     */
    shareLayer.path = pathRef;
    tagerView.layer.mask =  shareLayer;
    /**
     从新绘制
     */
    [tagerView setNeedsDisplay];
}

#pragma mark 半角型按钮
-(void)halfAngleBtn:(UIView*)tagerView{
    CAShapeLayer  * shareLayer = [CAShapeLayer layer];
    /**
     创建动态可变的路径
     */
    CGMutablePathRef pathRef =CGPathCreateMutable();
    /**
     获取按钮的宽度&高度
     */
    CGFloat weightBtn = tagerView.bounds.size.width;
    CGFloat heightBtn = tagerView.bounds.size.height;
    /**
     开始设置路径的走向
     */
    CGPathMoveToPoint(pathRef,NULL, 0,0);
    /**
     开始添加路径
     */
    CGPathAddLineToPoint(pathRef,NULL, weightBtn- heightBtn *0.5, 0.0);
    /**
     进行弧度变形
     */
    CGPathAddArc(pathRef,NULL, weightBtn-heightBtn *0.5, heightBtn * 0.5, heightBtn *0.5,M_PI_2, M_PI_2 *3, YES);
    CGPathAddLineToPoint(pathRef,NULL, weightBtn- heightBtn *0.5, heightBtn);
    CGPathAddLineToPoint(pathRef,NULL, 0.0, heightBtn);
    /**
     闭合路径
     */
    CGPathCloseSubpath(pathRef);
    /**
     进行路径的渲染
     */
    shareLayer.path = pathRef;
    tagerView.layer.mask =  shareLayer;
    /**
     从新绘制
     */
    [tagerView setNeedsDisplay];
}

//2》五角星的绘制
#pragma mark  五角星
-(void)pentagram:(UIView*)tagerView{
    /**
     创建一个显示层
     */
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    /**
     创建可变路径
     */
    CGMutablePathRef pathRef  =CGPathCreateMutable();
    /**
     获取按钮的宽度&高度
     */
    CGFloat weightBtn = tagerView.bounds.size.width;
    CGFloat heightBtn = tagerView.bounds.size.height;
    /**
     选择最小的
     */
    CGFloat minValue =MIN(weightBtn, heightBtn);
    /**
     圆的半径
     */
    CGFloat radiusValue  = minValue *0.5;
    /**
     五角星内接圆半径
     */
    CGFloat inscribedRadiusValue = radiusValue *sinf(18*M_PI/180 )/sinf(54*M_PI/180 );
    /**
     起始点
     */
    CGPathMoveToPoint(pathRef,NULL, weightBtn * 0.5, heightBtn*0.5 - radiusValue);
    /**
     第二个点
     */
    CGPathAddLineToPoint(pathRef,NULL, weightBtn* 0.5 +sinf(36*M_PI/180)*inscribedRadiusValue, heightBtn*0.5 -cosf(36*M_PI/180)* inscribedRadiusValue);
    /**
     第三个点
     */
    CGPathAddLineToPoint(pathRef,NULL, weightBtn * 0.5+cosf(18 *M_PI/180)*radiusValue, heightBtn*0.5 -sinf(18 *M_PI/180)*radiusValue);
    /**
     第四个点
     */
    CGPathAddLineToPoint(pathRef,NULL, weightBtn* 0.5 +cosf(18 *M_PI/180)* inscribedRadiusValue, heightBtn*0.5 +sinf(18*M_PI/180)*inscribedRadiusValue);
    /**
     第五个点
     */
    CGPathAddLineToPoint(pathRef,NULL, weightBtn * 0.5+cosf(54*M_PI/180)*radiusValue, heightBtn*0.5 + sinf(54*M_PI/180)* radiusValue);
    /**
     插入点
     */
    CGPathAddLineToPoint(pathRef,NULL, weightBtn * 0.5, heightBtn*0.5 + inscribedRadiusValue);
    /**
     第六个点
     */
    CGPathAddLineToPoint(pathRef,NULL, weightBtn * 0.5-cosf(54*M_PI/180)*radiusValue, heightBtn*0.5 + sinf(54*M_PI/180)* radiusValue);
    /**
     第七个点
     */
    CGPathAddLineToPoint(pathRef,NULL, weightBtn* 0.5 -cosf(18 *M_PI/180)* inscribedRadiusValue, heightBtn*0.5 +sinf(18*M_PI/180)*inscribedRadiusValue);
    /**
     第八个点
     */
    CGPathAddLineToPoint(pathRef,NULL, weightBtn * 0.5-cosf(18 *M_PI/180)*radiusValue, heightBtn*0.5 -sinf(18 *M_PI/180)*radiusValue);
    /**
     第九个点
     */
    CGPathAddLineToPoint(pathRef,NULL, weightBtn* 0.5 - sinf(36*M_PI/180)*inscribedRadiusValue, heightBtn*0.5 -cosf(36*M_PI/180)* inscribedRadiusValue);
    /**
     闭合路径
     */
    CGPathCloseSubpath(pathRef);
    /**
     进行渲染
     */
    shapeLayer.path = pathRef;
    tagerView.layer.mask = shapeLayer;
    /**
     绘制
     */
    [tagerView setNeedsDisplay];
}




//3》心形
#pragma mark  心形绘制
-(void)heart:(UIView*)tagerView{
    /**
     创建一个显示层
     */
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    /**
     创建可变路径
     */
    CGMutablePathRef pathRef  =CGPathCreateMutable();
    /**
     获取按钮的宽度&高度
     */
    CGFloat weightBtn = tagerView.bounds.size.width;
    CGFloat heightBtn = tagerView.bounds.size.height;
    /**
     曲线路径
     */
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineWidth =0.5;
    /**
     起始点
     */
    [bezierPath moveToPoint:CGPointMake(weightBtn*0.5, heightBtn*0.5-5)];
    /**
     绘制曲线
     */
    [bezierPath addCurveToPoint:CGPointMake(weightBtn*0.5, heightBtn*0.5+60)controlPoint1:CGPointMake(weightBtn*0.5+15,heightBtn*0.5-40)controlPoint2:CGPointMake(weightBtn*0.5+80,heightBtn * 0.5+10)];
    CGPathAddPath(pathRef,NULL, bezierPath.CGPath);
    /**
     曲线路径
     */
    UIBezierPath * bezierPath2 = [UIBezierPath bezierPath];
    bezierPath2.lineWidth =0.5;
    /**
     起始点
     */
    [bezierPath2 moveToPoint:CGPointMake(weightBtn*0.5, heightBtn*0.5+60)];
    /**
     绘制曲线
     */
    [bezierPath2 addCurveToPoint:CGPointMake(weightBtn*0.5, heightBtn*0.5-5)controlPoint1:CGPointMake(weightBtn*0.5-80, heightBtn * 0.5+10)controlPoint2:CGPointMake(weightBtn*0.5-15,heightBtn*0.5-40)];
    CGPathAddPath(pathRef,NULL, bezierPath2.CGPath);
    /**
     闭合路径
     */
    CGPathCloseSubpath(pathRef);
    /**
     进行渲染
     */
    shapeLayer.path = pathRef;
    tagerView.layer.mask = shapeLayer;
    /**
     绘制
     */
    [tagerView setNeedsDisplay];
}

//4》蝙蝠形
-(void)Bat:(UIView*)tagerView{
    /**
     创建一个显示层
     */
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    /**
     创建可变路径
     */
    CGMutablePathRef pathRef  =CGPathCreateMutable();
    /**
     获取按钮的宽度&高度
     */
    CGFloat weightBtn = tagerView.bounds.size.width;
    CGFloat heightBtn = tagerView.bounds.size.height;
    /**
     绘制蝙蝠轮廓
     */
    UIBezierPath * LeftBezierPath = [UIBezierPath bezierPath];
    /**
     起始点
     */
    [LeftBezierPath moveToPoint:CGPointMake(weightBtn*0.5-140, heightBtn*0.5 + 40)];
    /**
     轮廓线1
     */
    [LeftBezierPath addCurveToPoint:CGPointMake(weightBtn*0.5-10, heightBtn * 0.5) controlPoint1:CGPointMake(weightBtn*0.5-90, heightBtn*0.5-50)controlPoint2:CGPointMake(weightBtn*0.5-30, heightBtn*0.5)];
    [LeftBezierPath addLineToPoint:CGPointMake(weightBtn*0.5-5, heightBtn * 0.5)];
    [LeftBezierPath addLineToPoint:CGPointMake(weightBtn*0.5-10, heightBtn * 0.5-15)];
    [LeftBezierPath addLineToPoint:CGPointMake(weightBtn*0.5,heightBtn*0.5-13)];
    [LeftBezierPath addArcWithCenter:CGPointMake(weightBtn*0.5+5, heightBtn*0.5-4)radius:11 startAngle:5/3 *M_PI endAngle:5.1/3.0 *M_PI clockwise:YES];
    [LeftBezierPath addLineToPoint:CGPointMake(weightBtn*0.5+18,heightBtn*0.5-20)];
    [LeftBezierPath addLineToPoint:CGPointMake(weightBtn*0.5+20,heightBtn*0.5-0)];
    [LeftBezierPath addCurveToPoint:CGPointMake(weightBtn*0.5+150, heightBtn * 0.5 -40)controlPoint1:CGPointMake(weightBtn*0.5+50, heightBtn*0.5-10)controlPoint2:CGPointMake(weightBtn*0.5+40, heightBtn*0.5-70)];
    /**
     绘制翅膀的图形
     */
    [LeftBezierPath addArcWithCenter:CGPointMake(weightBtn*0.5+130, heightBtn*0.5-15.5)radius:27 startAngle:4.8/3 *M_PI endAngle:3/3.0 *M_PI clockwise:NO];
    [LeftBezierPath addArcWithCenter:CGPointMake(weightBtn*0.5+95, heightBtn*0.5+10)radius:25 startAngle:4.8/3 *M_PI endAngle:3/3.0 *M_PI clockwise:NO];
    [LeftBezierPath addArcWithCenter:CGPointMake(weightBtn*0.5+65, heightBtn*0.5+30.5)radius:20 startAngle:4.8/3 *M_PI endAngle:3/3.0 *M_PI clockwise:NO];
    [LeftBezierPath addArcWithCenter:CGPointMake(weightBtn*0.5+35, heightBtn*0.5+35)radius:10 startAngle:4.8/3 *M_PI endAngle:3.2/3.0 *M_PI clockwise:NO];
    [LeftBezierPath addLineToPoint:CGPointMake(weightBtn*0.5+20,heightBtn*0.5+45)];
    [LeftBezierPath addLineToPoint:CGPointMake(weightBtn*0.5+10,heightBtn*0.5+35)];
    /**
     左边翅膀
     */
    [LeftBezierPath addArcWithCenter:CGPointMake(weightBtn*0.5, heightBtn*0.5+40)radius:10 startAngle:5.3/3 *M_PI endAngle:3.5/3.0 *M_PI clockwise:NO];
    [LeftBezierPath addArcWithCenter:CGPointMake(weightBtn*0.5-30, heightBtn*0.5+50.5)radius:20 startAngle:5.5/3 *M_PI endAngle:4.3/3.0 *M_PI clockwise:NO];
    [LeftBezierPath addArcWithCenter:CGPointMake(weightBtn*0.5-55, heightBtn*0.5+44)radius:25 startAngle:5.5/3 *M_PI endAngle:4.0/3.0 *M_PI clockwise:NO];
    [LeftBezierPath addArcWithCenter:CGPointMake(weightBtn*0.5-105, heightBtn*0.5+45.5)radius:30 startAngle:5.6/3 *M_PI endAngle:3.5/3.0 *M_PI clockwise:NO];
    /**
     组合路线
     */
    CGPathAddPath(pathRef,NULL, LeftBezierPath.CGPath);
    /**
     闭合路径
     */
    CGPathCloseSubpath(pathRef);
    /**
     进行渲染
     */
    shapeLayer.path = pathRef;
    tagerView.layer.mask = shapeLayer;
    /**
     绘制
     */
    [tagerView setNeedsDisplay];
}


//5》邮票绘制
#pragma mark  邮票
-(void)stamps:(UIView*)tagerView{
    /**
     创建一个显示层
     */
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    /**
     创建可变路径
     */
    CGMutablePathRef pathRef  =CGPathCreateMutable();
    /**
     获取按钮的宽度&高度
     */
    CGFloat weightBtn = tagerView.bounds.size.width;
    CGFloat heightBtn = tagerView.bounds.size.height;
    CGPathMoveToPoint(pathRef,NULL, 0,10);
    for (unsigned i =0; i<weightBtn/20; i++) {
        CGPathAddArc(pathRef,NULL, 10 + i*20,10, 10,0, M_PI,YES);
    }
    CGPathAddArc(pathRef,NULL, weightBtn-10,10, 10,M_PI, M_PI_2 *3, YES);
    for (unsigned i =0; i<heightBtn/20; i++) {
        CGPathAddArc(pathRef,NULL, weightBtn-10,30 + i*20,10, M_PI_2,M_PI_2*3,YES);
    }
    CGPathAddArc(pathRef,NULL, weightBtn-10,heightBtn-10, 10,M_PI_2 * 3,M_PI_2 * 4,YES);
    for (unsigned i =0; i<weightBtn/20; i++) {
        CGPathAddArc(pathRef,NULL,weightBtn- (30 + i*20),heightBtn-10, 10,M_PI, M_PI*2, YES);
    }
    CGPathAddArc(pathRef,NULL,10,heightBtn-10, 10,M_PI_2 * 4,M_PI_2 * 5,YES);
    for (unsigned i =0; i<heightBtn/20; i++) {
        CGPathAddArc(pathRef,NULL,10,heightBtn-(30 + i*20),10, M_PI_2*3, M_PI_2*5,YES);
    }
    CGPathAddArc(pathRef,NULL,10,10,10, M_PI_2 *3, M_PI_2 *4, YES);
    
    /**
     闭合路径
     */
    CGPathCloseSubpath(pathRef);
    /**
     进行渲染
     */
    shapeLayer.path = pathRef;
    tagerView.layer.mask = shapeLayer;
    /**
     绘制
     */
    [tagerView setNeedsDisplay];
}

@end
