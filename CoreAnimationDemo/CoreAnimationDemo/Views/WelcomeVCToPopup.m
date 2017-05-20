//
//  WelcomeVCToPopup.m
//  CoreAnimationDemo
//
//  Created by 李超前 on 15/11/14.
//  Copyright © 2015年 李超前. All rights reserved.
//

#import "WelcomeVCToPopup.h"

@interface WelcomeVCToPopup ()

@end

@implementation WelcomeVCToPopup

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)close:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(hiddenPopupViewController:)]) {
        [self.delegate hiddenPopupViewController:self];
    }
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
