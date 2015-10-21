//
//  UIViewController+MVSwitchAnimation.m
//  MVViewSwitchAnimation
//
//  Created by sh219 on 15/10/20.
//  Copyright © 2015年 sh219. All rights reserved.
//

#import "UIViewController+MVSwitchAnimation.h"

@implementation UIViewController (MVSwitchAnimation)
- (void)switchViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    if (flag) {
        SwitchView *switchView = [[SwitchView alloc] init];
        [switchView beginSwitchAnimationWithAppearCompletion:^{
            [self presentViewController:viewControllerToPresent animated:NO completion:nil];
        }dismissCompletion:completion];
    }else{
        [self presentViewController:viewControllerToPresent animated:NO completion:completion];
    }
    
}
- (void)dismissSwitchViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    if (flag) {
        SwitchView *switchView = [[SwitchView alloc] init];
        [switchView beginSwitchAnimationWithAppearCompletion:^{
            [self dismissViewControllerAnimated:NO completion:nil];
        }dismissCompletion:completion];
    }else{
        [self dismissViewControllerAnimated:NO completion:completion];
    }
}
@end
