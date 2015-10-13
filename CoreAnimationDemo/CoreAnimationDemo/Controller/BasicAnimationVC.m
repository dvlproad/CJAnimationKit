//
//  Demo1.m
//  CoreAnimationDemo
//
//  Created by 李超前 on 15/10/12.
//  Copyright © 2015年 李超前. All rights reserved.
//

#import "BasicAnimationVC.h"
#import <QuartzCore/QuartzCore.h>

@interface BasicAnimationVC ()

@end

@implementation BasicAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initScaleLayer];
    
    [self initGroupLayer];
}

- (IBAction)test:(id)sender{
    BasicAnimationVC *con = [[BasicAnimationVC alloc]initWithNibName:@"BasicAnimationVC" bundle:nil];
    [self.navigationController pushViewController:con animated:YES];
    //初始化
    CALayer *kkLayer = [[CALayer alloc]init];
    kkLayer.backgroundColor = [[UIColor grayColor]CGColor];
    kkLayer.frame = CGRectMake(100, 100, 200, 200);
    // 设定它的frame
    kkLayer.cornerRadius = 5;// 圆角处理
    [self.view.layer addSublayer:kkLayer]; // 增加到UIView的layer上面
    // 移动kkLayer的position
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:kkLayer.position];
    CGPoint toPoint = kkLayer.position; toPoint.x += 180;
    animation.toValue = [NSValue valueWithCGPoint:toPoint];
    // 以x轴进行旋转
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"]; rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:6.0 * M_PI];
    // 对kkLayer进行放大缩小
    CABasicAnimation *scaoleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"]; scaoleAnimation.duration = 3;
    scaoleAnimation.autoreverses = YES;
    scaoleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaoleAnimation.toValue = [NSNumber numberWithFloat:2.5];
    scaoleAnimation.fillMode = kCAFillModeForwards;
}


//layer添加CABasicAnimation：类似心跳的缩放动画
- (void)initScaleLayer
{
    //演员初始化
    CALayer *scaleLayer = [[CALayer alloc] init];
    scaleLayer.backgroundColor = [UIColor blueColor].CGColor;
    scaleLayer.frame = CGRectMake(100, 100, 50, 50);
    scaleLayer.cornerRadius = 10;
    [self.view.layer addSublayer:scaleLayer];
    
    //设定剧本
    //想要实现不同的效果，最关键的地方在于CABasicAnimation对象的初始化方式中keyPath的设定。
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.5];
    scaleAnimation.autoreverses = YES; //是否再回到原来的位置
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.duration = 0.8;
    
    //开演
    [scaleLayer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}


//layer添加CAAnimationGroup，CAAnimationGroup种包含多个CABasicAnimation
- (void)initGroupLayer
{
    //演员初始化
    CALayer *groupLayer = [[CALayer alloc] init];
    groupLayer.frame = CGRectMake(60, 400, 50, 50);
    groupLayer.cornerRadius = 10;
    groupLayer.backgroundColor = [[UIColor purpleColor] CGColor];
    [self.view.layer addSublayer:groupLayer];
    
    //设定剧本
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.5];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.duration = 0.8;
    
    /*
     彻底理解position与anchorPoint：http://blog.csdn.net/yongyinmg/article/details/37927793
     anchorPoint:左上角、右下角的图钉anchorPoint分为为(0,0), (1, 1)
     position是layer中的anchorPoint点在superLayer中的位置坐标。
     */
    CGPoint moveFromPoint = groupLayer.position;//由于图钉anchorPoint默认为(0,0)，所以position这里为(60,400)
    CGPoint moveToPoint = CGPointMake(groupLayer.position.x+180, groupLayer.position.y);
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:moveFromPoint];
    moveAnimation.toValue   = [NSValue valueWithCGPoint:moveToPoint];
    moveAnimation.autoreverses = YES;
    moveAnimation.repeatCount = MAXFLOAT;
    moveAnimation.duration = 2;
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    rotateAnimation.toValue = [NSNumber numberWithFloat:6.0 * M_PI];
    rotateAnimation.autoreverses = YES;
    rotateAnimation.repeatCount = MAXFLOAT;
    rotateAnimation.duration = 2;
    
    CAAnimationGroup *groupAnnimation = [CAAnimationGroup animation];
    groupAnnimation.duration = 2;
    groupAnnimation.autoreverses = YES;
//    groupAnnimation.animations = @[moveAnimation];
//    groupAnnimation.animations = @[scaleAnimation];
//    groupAnnimation.animations = @[rotateAnimation];
    groupAnnimation.animations = @[moveAnimation, scaleAnimation, rotateAnimation];
    groupAnnimation.repeatCount = MAXFLOAT;
    //开演
    [groupLayer addAnimation:groupAnnimation forKey:@"groupAnnimation"];
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
