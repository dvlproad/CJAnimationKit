//
//  BezierPathAnimationVC.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 15/10/13.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "BezierPathAnimationVC.h"

#define DEGREES_TO_RADIANS(x) (3.14159265358979323846 * x / 180.0)

@interface BezierPathAnimationVC ()

@end

@implementation BezierPathAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self animationInit];//贪吃蛇动画
}


- (void)animationInit
{
    self.view.backgroundColor = [UIColor blackColor];
    
    CGFloat radius = 30.0f;
    CGFloat diameter = radius * 2;
    CGPoint arcCenter = CGPointMake(radius, radius);
    // Create a UIBezierPath for Pacman's open state
    pacmanOpenPath = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                    radius:radius
                                                startAngle:DEGREES_TO_RADIANS(35)
                                                  endAngle:DEGREES_TO_RADIANS(315)
                                                 clockwise:YES];
    
    [pacmanOpenPath addLineToPoint:arcCenter];
    [pacmanOpenPath closePath];
    
    // Create a UIBezierPath for Pacman's close state
    pacmanClosedPath = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                      radius:radius
                                                  startAngle:DEGREES_TO_RADIANS(1)
                                                    endAngle:DEGREES_TO_RADIANS(359)
                                                   clockwise:YES];
    [pacmanClosedPath addLineToPoint:arcCenter];
    [pacmanClosedPath closePath];
    
    // Create a CAShapeLayer for Pacman, fill with yellow
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor yellowColor].CGColor;
    shapeLayer.path = pacmanClosedPath.CGPath;
    shapeLayer.strokeColor = [UIColor grayColor].CGColor;
    shapeLayer.lineWidth = 1.0f;
    shapeLayer.bounds = CGRectMake(0, 0, diameter, diameter);
    shapeLayer.position = CGPointMake(-40, -100);
    [self.view.layer addSublayer:shapeLayer];
    
    SEL startSelector = @selector(startAnimation);
    UIGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:startSelector];
    [self.view addGestureRecognizer:recognizer];
}

- (void)startAnimation {
    // 创建咬牙动画
    CABasicAnimation *chompAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    chompAnimation.duration = 0.25;
    chompAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    chompAnimation.repeatCount = HUGE_VALF;
    chompAnimation.autoreverses = YES;
    // Animate between the two path values
    chompAnimation.fromValue = (id)pacmanClosedPath.CGPath;
    chompAnimation.toValue = (id)pacmanOpenPath.CGPath;
    [shapeLayer addAnimation:chompAnimation forKey:@"chompAnimation"];
    
    // Create digital '2'-shaped path
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 100)];
    [path addLineToPoint:CGPointMake(300, 100)];
    [path addLineToPoint:CGPointMake(300, 200)];
    [path addLineToPoint:CGPointMake(0, 200)];
    [path addLineToPoint:CGPointMake(0, 300)];
    [path addLineToPoint:CGPointMake(300, 300)];
    
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.path = path.CGPath;
    moveAnimation.duration = 8.0f;
    // Setting the rotation mode ensures Pacman's mouth is always forward.  This is a very convenient CA feature.
    moveAnimation.rotationMode = kCAAnimationRotateAuto;
    [shapeLayer addAnimation:moveAnimation forKey:@"moveAnimation"];
}


#pragma mark - 位移操作（position）:用贝塞尔曲线BezierPath
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
- (IBAction)position_QuadCurve:(id)sender{
    CAKeyframeAnimation *animation = [self position_QuadCurve_CAKeyframeAnimation];
    animation.duration = 2;
    [self.imageV.layer addAnimation:animation forKey:nil];
}

- (IBAction)position_Line:(id)sender{
    CAKeyframeAnimation *animation = [self position_Line_CAKeyframeAnimation];
    animation.duration = 2;
    [self.imageV.layer addAnimation:animation forKey:nil];
}

//View曲线移动：用贝塞尔曲线BezierPath把图片移到右下角
- (CAKeyframeAnimation *)position_QuadCurve_CAKeyframeAnimation{
    //画二元曲线，一般和moveToPoint配合使用
    //    - (void)addQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint
    //    参数：
    //endPoint:曲线的终点
    //controlPoint:画曲线的基准点,就相当于是该controlPoint在走BezierPath，而其他点知识跟随着动而已。
    
    //路径曲线
    CGPoint po_from = self.imageV.center;
    CGPoint po_to = CGPointMake(CGRectGetWidth(self.view.frame)-CGRectGetWidth(self.imageV.frame)/2,460);
    CGPoint po_control = CGPointMake(CGRectGetWidth(self.view.frame)-CGRectGetWidth(self.imageV.frame)/2,po_from.x);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:po_from];//设置初始线段的起点。
    [bezierPath addQuadCurveToPoint:po_to controlPoint:po_control];
    
    //关键帧
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = bezierPath.CGPath;
    animation.removedOnCompletion = YES;
    
    return animation;
}

//View直线移动：用贝塞尔曲线BezierPath把图片从原始位置向右移动100
- (CAKeyframeAnimation *)position_Line_CAKeyframeAnimation{
    //设置bezierPath
    CGPoint po_from = self.imageV.center;
    CGPoint po_to = CGPointMake(po_from.x + 100, po_from.y);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:po_from];
    [bezierPath addLineToPoint:po_to];
    
    //将bezierPath设置到animation.path中
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = bezierPath.CGPath;
    return animation;
}
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//







#pragma mark - 缩放操作（transform_Scale）、旋转操作（transform_Rotation）
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
- (IBAction)transform_Scale:(id)sender{
    CABasicAnimation *animation = [self transform_Scale_CABasicAnimation];
    animation.duration = 2;
    [self.imageV.layer addAnimation:animation forKey:nil];
}

- (IBAction)transform_Rotation:(id)sender{
    CABasicAnimation *animation = [self transform_Rotation_CABasicAnimation];
    animation.duration = 2;
    [self.imageV.layer addAnimation:animation forKey:nil];
}


- (CABasicAnimation *)transform_Scale_CABasicAnimation{
    //初始化
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    //设置fromValue
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    //设置toValue (利用CATransform3DMakeScale)
    CATransform3D transform_Scale_XY = CATransform3DMakeScale(0.1, 0.1, 1); ////x,y,z放大缩小倍数（x，y轴缩小到0.1倍,Z 轴不变）
    animation.toValue = [NSValue valueWithCATransform3D:transform_Scale_XY];
    
    animation.removedOnCompletion = YES;
    //animation.repeatCount = MAXFLOAT;//重复次数，未设置时候默认1
    
    return animation;
}

- (CABasicAnimation *)transformScale_CABasicAnimation{
    //初始化
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    //设置fromValue
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    
    //设置toValue (利用CATransform3DMakeScale)
    animation.toValue = [NSNumber numberWithFloat:1.5];
    
    //是否再回到原来的位置
    animation.autoreverses = YES;
    
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT;
    animation.duration = 0.8;
    //animation.removedOnCompletion = YES;
    
    return animation;
}


- (CABasicAnimation *)transform_Rotation_CABasicAnimation{
    //初始化
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    //设置fromValue
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    //设置toValue (利用CATransform3DMakeRotation)
    CATransform3D transform_Rotation_Z = CATransform3DMakeRotation(M_PI, 0, 0, 1);//沿Z轴旋转
    CATransform3D transform_Rotation_Y = CATransform3DMakeRotation(M_PI, 0, 1, 0);//沿Y轴旋转
    CATransform3D transform_Rotation_X = CATransform3DMakeRotation(M_PI, 1, 0, 0);//沿X轴旋转
    animation.toValue = [NSValue valueWithCATransform3D:transform_Rotation_Z];
    
    animation.cumulative = YES;
    animation.duration = 3;
    animation.repeatCount = 2;
    animation.removedOnCompletion = YES;
    
    return animation;
}
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//






#pragma mark - 透明操作（alpha）
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
- (IBAction)alpha:(id)sender{
    CABasicAnimation *animation = [self alpha_CABasicAnimation];
    animation.duration = 2;
    [self.imageV.layer addAnimation:animation forKey:nil];
}

//透明度改变的动画
- (CABasicAnimation *)alpha_CABasicAnimation{
    //透明度变化
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
    opacityAnim.removedOnCompletion = YES;
    
    return opacityAnim;
}
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//







#pragma mark - 组合动画CAAnimationGroup
//①、用贝塞尔曲线BezierPath把图片移到右下角，移动过程中同时进行变小的缩放操作，并且透明度也同时改变
- (IBAction)position_transform_alpha:(id)sender{
    //关键帧，旋转，透明度组合起来执行
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = @[[self position_QuadCurve_CAKeyframeAnimation],
                             [self transform_Scale_CABasicAnimation],
                             [self alpha_CABasicAnimation]];
    animGroup.duration = 1;
    [self.imageV.layer addAnimation:animGroup forKey:nil];
}




//②、旋转并向右移动
- (IBAction)RightRotateAction:(id)sender {
    CAKeyframeAnimation *animation_position_Line = [self position_Line_CAKeyframeAnimation];
    CABasicAnimation *animation_transform_Rotation = [self transform_Rotation_CABasicAnimation];
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = @[animation_position_Line,
                             animation_transform_Rotation];
    animGroup.duration = 6;
    
    [self.imageV.layer addAnimation:animGroup forKey:nil];
}


//旋转并消除边缘锯齿
- (IBAction)Rotate360Action:(id)sender {
    //图片旋转360度
    CABasicAnimation *animation = [ CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D:
                         CATransform3DMakeRotation(M_PI, 0, 0, 1.0) ];
    animation.duration = 3;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = 2;
    
    //在图片边缘添加一个像素的透明区域，去图片锯齿
    CGRect imageRrect = CGRectMake(0, 0, self.imageV.frame.size.width, self.imageV.frame.size.height);
    UIGraphicsBeginImageContext(imageRrect.size);
    [self.imageV.image drawInRect:CGRectMake(1,1,self.imageV.frame.size.width-2,self.imageV.frame.size.height-2)];
    self.imageV.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.imageV.layer addAnimation:animation forKey:nil];
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
