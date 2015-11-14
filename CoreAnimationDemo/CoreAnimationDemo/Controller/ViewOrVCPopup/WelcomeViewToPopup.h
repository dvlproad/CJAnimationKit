//
//  WelcomeViewToPopup.h
//  CJPopupViewDemo
//
//  Created by lichq on 6/22/15.
//  Copyright (c) 2015 ciyouzen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WelcomeViewToPopup;
@protocol WelcomeViewToPopupDelegate<NSObject>
@optional
- (void)hiddenPopupView:(WelcomeViewToPopup *)popupView;
@end



@interface WelcomeViewToPopup : UIView{

}
@property (assign, nonatomic) id <WelcomeViewToPopupDelegate>delegate;
@property (nonatomic, assign) CGRect rect_hide;

@end
