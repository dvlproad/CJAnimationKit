//
//  WelcomeVCToPopup.h
//  CoreAnimationDemo
//
//  Created by 李超前 on 15/11/14.
//  Copyright © 2015年 李超前. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WelcomeVCToPopup;
@protocol WelcomeVCToPopupDelegate<NSObject>
@optional
- (void)hiddenPopupViewController:(WelcomeVCToPopup *)popupVC;
@end



@interface WelcomeVCToPopup : UIViewController

@property (assign, nonatomic) id <WelcomeVCToPopupDelegate>delegate;
@property (nonatomic, assign) CGRect rect_hide;

@end
