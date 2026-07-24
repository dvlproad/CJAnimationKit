//
//  CQTSDemoAppDelegateProtocol.m
//  CQDemoKit
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQTSWindow.h"

NS_ASSUME_NONNULL_BEGIN

// 获取的方法:
// id<CQTSDemoAppDelegateProtocol> delegate = (id<CQTSDemoAppDelegateProtocol>)[UIApplication sharedApplication].delegate;
@protocol CQTSDemoAppDelegateProtocol <NSObject>

@property (strong, nonatomic) CQTSWindow *cqtsFloatingWindow; /**< 悬浮的 window：创建的window必须强制持有，且要想window一直不被释放，除了strong，还必须放在AppDelegate上 */

@end

NS_ASSUME_NONNULL_END
