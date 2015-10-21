//
//  UIViewController+MVSwitchAnimation.h
//  MVViewSwitchAnimation
//
//  Created by sh219 on 15/10/20.
//  Copyright © 2015年 sh219. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwitchView.h"

@interface UIViewController (MVSwitchAnimation)
- (void)switchViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion;
- (void)dismissSwitchViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion;
@end
