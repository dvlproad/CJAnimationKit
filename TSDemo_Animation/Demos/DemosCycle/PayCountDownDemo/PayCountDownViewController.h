//
//  PayCountDownViewController.h
//  CJAnimationKitDemo
//
//  Created by ciyouzen on 2018/7/30.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface PayCountDownViewController : UIViewController {
    
}
@property (nonatomic, assign) NSInteger payFen;         /**< 待支付的费用(分) */
@property (nonatomic, assign) NSInteger totalSecond;    /**< 倒计时原本总共秒数 */
@property (nonatomic, assign) NSInteger leaveSecond;    /**< 倒计时当前剩余秒数 */

@property (nonatomic, copy) void(^goBackBlock)(PayCountDownViewController *mPayCountDownViewController);  /**< 点击返回，执行的操作 */
@property (nonatomic, copy) void(^startPayBlock)(PayCountDownViewController *mPayCountDownViewController);  /**< 点击"支付"，执行的操作 */
@property (nonatomic, copy) void(^countDownFinishBlock)(PayCountDownViewController *mPayCountDownViewController);   /**< 倒计时结束之后，执行的操作 */

@end
