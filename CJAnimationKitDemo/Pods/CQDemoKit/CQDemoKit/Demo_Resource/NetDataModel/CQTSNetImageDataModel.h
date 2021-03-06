//
//  CQTSNetImageDataModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CQTSNetImageDataModel : NSObject

@property (nonatomic, assign) BOOL haveLoadImage;  /**< 设置此model的时候，是否已经下载了图片 */
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, strong) UIImage *imagePlaceholderImage;
@property (nonatomic, assign) NSInteger badgeCount;

//+ (void)setupImageView:(UIImageView *)imageView withImageUrl:(NSString *)imageUrl;

@end
