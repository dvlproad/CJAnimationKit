//
//  CAShapeLayerFactory.h
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2017/5/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  参考文档：[IOS开发之切除你心中的那个图案](http://blog.csdn.net/zhoushuangjian511/article/details/70805164)

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

//①内切圆：如果一个圆与多边形的各边都相切,则这个圆称为这个多边形的内切圆
//②外接圆：如果一个多边形的各个顶点都在同一个圆上,则这个圆叫做这个多边形的外接圆(附:这个多边形称为这个圆的内接多边形)
typedef NS_ENUM(NSUInteger, CJCircleType) {
    CJCircleTypeInscribe,       /**< 内圆(只有视图为正方形时候，才是内切圆) */
    CJCircleTypeCircumcircle,   /**< 外接圆 */
};

@interface CAShapeLayerFactory : NSObject

/**
 *  对某个视图绘制一个圆
 *
 *  @param view         要绘制圆的视图
 *  @param circleType   圆的类型
 */
+ (CAShapeLayer *)cjCircleShapeLayerForView:(UIView *)view circleType:(CJCircleType)circleType;



//1》尖角和半圆角按钮
#pragma mark 箭头按钮
-(void)arrowButtonTager:(UIView*)tagerView;

#pragma mark 半角型按钮
-(void)halfAngleBtn:(UIView*)tagerView;

//2》五角星的绘制
#pragma mark  五角星
-(void)pentagram:(UIView*)tagerView;

//3》心形
#pragma mark  心形绘制
-(void)heart:(UIView*)tagerView;

//4》蝙蝠形
-(void)Bat:(UIView*)tagerView;

//5》邮票绘制
#pragma mark  邮票
-(void)stamps:(UIView*)tagerView;

@end
