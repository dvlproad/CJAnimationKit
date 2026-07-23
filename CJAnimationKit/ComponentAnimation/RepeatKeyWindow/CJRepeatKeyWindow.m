//
//  CJRepeatKeyWindow.m
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2017/5/22.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJRepeatKeyWindow.h"

@interface CJRepeatKeyWindow ()

@property (nonatomic, strong) UIView *windowSubview;

@end

@implementation CJRepeatKeyWindow

- (instancetype)init {
    self = [super init];
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
    self.windowLevel = UIWindowLevelAlert + 1;  //如果想在 alert 之上，则改成 + 2
    [self makeKeyAndVisible];
}

/* 完整的描述请参见文件头部 */
- (void)cj_addWindowSubview:(UIView *)windowSubview {
    if ([windowSubview isKindOfClass:[UIWindow class]]) {
        NSAssert(NO, @"windowSubview本身已经是window水平了，不需要将windowSubview从其superView上转移添加到此window上");
        return;
    }
    
    
    NSAssert(windowSubview.superview != nil, @"请先将当前视图添加到视图上，再执行此方法");
    self.backgroundColor = [UIColor clearColor]; //设置成透明，确保转以后看不出来windowSubview其已经被转移到另一个视图上
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    self.frame = keyWindow.frame;
    [self addSubview:windowSubview];
    self.windowSubview = windowSubview;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
