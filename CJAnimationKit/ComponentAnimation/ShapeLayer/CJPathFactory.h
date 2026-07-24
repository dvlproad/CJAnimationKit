//
//  CJPathFactory.h
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2017/5/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

//①内切圆：如果一个圆与多边形的各边都相切,则这个圆称为这个多边形的内切圆
//②外接圆：如果一个多边形的各个顶点都在同一个圆上,则这个圆叫做这个多边形的外接圆(附:这个多边形称为这个圆的内接多边形)
typedef NS_ENUM(NSUInteger, CJCircleType) {
    CJCircleTypeInscribe,       /**< 内圆(只有视图为正方形时候，才是内切圆) */
    CJCircleTypeCircumcircle,   /**< 外接圆 */
};

@interface CJPathFactory : NSObject

#pragma mark - Circle

+ (CGPathRef)circlePathWithSize:(CGSize)size circleType:(CJCircleType)circleType;

#pragma mark - Shape

+ (CGPathRef)arrowPathWithSize:(CGSize)size;
+ (CGPathRef)halfAnglePathWithSize:(CGSize)size;
+ (CGPathRef)pentagramPathWithSize:(CGSize)size;
+ (CGPathRef)heartPathWithSize:(CGSize)size;
+ (CGPathRef)batPathWithSize:(CGSize)size;
+ (CGPathRef)stampPathWithSize:(CGSize)size;

@end
