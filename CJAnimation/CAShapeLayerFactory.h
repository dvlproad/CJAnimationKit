//
//  CAShapeLayerFactory.h
//  CoreAnimationDemo
//
//  Created by 李超前 on 2017/5/19.
//  Copyright © 2017年 李超前. All rights reserved.
//

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

@end
