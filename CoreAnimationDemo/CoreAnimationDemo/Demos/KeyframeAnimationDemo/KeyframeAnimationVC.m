//
//  KeyframeAnimationVC.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 15/10/13.
//  Copyright © 2015年 dvlproad. All rights reserved.
//


#import "KeyframeAnimationVC.h"

//参考：CoreAnimation动画系列教程（二）：CAKeyFrameAnimation【包会】http://www.cnblogs.com/wengzilin/p/4256468.html


@interface KeyframeAnimationVC ()

@end

@implementation KeyframeAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initRectLayer];
}


#pragma mark - 重要知识点阅读
/*
 CABasicAnimation算是CAKeyFrameAnimation的特殊情况，即不考虑中间变换过程，只考虑起始点与目标点就可以了。而CAKeyFrameAnimation则更复杂一些，允许我们在起点与终点间自定义更多内容来达到我们的实际应用需求！比如，手机淘宝中，当你添加物品到购物车后会出现将物品抛到购物车的效果，这种效果实现起来也不难，无非是先绘制抛物线在执行position以及scale的GroupAnimation而已
 */
//绕矩形循环跑(效果：实现“小圆球绕矩形跑道循环跑动”为目标开始对CAKeyFrameAnimation的介绍，如图2所示。小圆球的运动轨迹可分为四段，每段的运动速度不同，第一段中先慢后快再慢。)
- (void)initRectLayer
{
    CALayer *rectLayer = [[CALayer alloc] init];
    rectLayer.frame = CGRectMake(0, 200, 30, 30);
    rectLayer.cornerRadius = 15;
    rectLayer.backgroundColor = [[UIColor blackColor] CGColor];
    [self.view.layer addSublayer:rectLayer];
    CAKeyframeAnimation *rectRunAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //设定关键帧位置，必须含起始与终止位置
    CGFloat x = CGRectGetWidth(rectLayer.frame)/2;
    CGFloat y = CGRectGetMidY(rectLayer.frame);
    CGPoint point0 = CGPointMake(x, y);             //左上角点
    CGPoint point1 = CGPointMake(320 - x, y);       //右上角点
    CGPoint point2 = CGPointMake(320 - x, y+100);   //右下角点
    CGPoint point3 = CGPointMake(x, y+100);         //左下角点
    rectRunAnimation.values = @[[NSValue valueWithCGPoint:point0],
                                [NSValue valueWithCGPoint:point1],
                                [NSValue valueWithCGPoint:point2],
                                [NSValue valueWithCGPoint:point3],
                                [NSValue valueWithCGPoint:point0]];
    
                                
    //设定每个关键帧的时长，如果没有显式地设置，则默认每个帧的时间=总duration/(values.count - 1)
    rectRunAnimation.keyTimes = @[[NSNumber numberWithFloat:0.0],
                                  [NSNumber numberWithFloat:0.6],
                                  [NSNumber numberWithFloat:0.7],
                                  [NSNumber numberWithFloat:0.8],
                                  [NSNumber numberWithFloat:1]];
    rectRunAnimation.timingFunctions =
            @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
              [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
              [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear],
              [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    
    rectRunAnimation.repeatCount = 1000;
    rectRunAnimation.autoreverses = NO;
    rectRunAnimation.calculationMode = kCAAnimationLinear;
    rectRunAnimation.duration = 4;
    [rectLayer addAnimation:rectRunAnimation forKey:@"rectRunAnimation"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
