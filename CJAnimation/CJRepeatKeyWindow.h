//
//  CJRepeatKeyWindow.h
//  CoreAnimationDemo
//
//  Created by 李超前 on 2017/5/22.
//  Copyright © 2017年 李超前. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  一个和默认的keyWindow完全重合的window
 */
@interface CJRepeatKeyWindow : UIWindow

///唯一有用的初始化方式（因为frame的设置会在cj_addWindowSubview中）
- (instancetype)init;

/**
 *  将windowSubview从其默认所在的keyWindow上转移添加到和keyWindow大小位置一样的此window上（此操作重置新window的frame，使得其和所添加的windowSubview默认所在的keyWindow重合）
 *
 *  @param windowSubview    要添加的windowSubvie
 */
- (void)cj_addWindowSubview:(UIView *)windowSubview;

@end
