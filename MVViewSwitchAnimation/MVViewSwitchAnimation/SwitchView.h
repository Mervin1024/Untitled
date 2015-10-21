//
//  switchView.h
//  MVViewSwitchAnimation
//
//  Created by sh219 on 15/10/20.
//  Copyright © 2015年 sh219. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface SwitchView : UIView

- (void)beginSwitchAnimationWithAppearCompletion:(void (^)(void))Acompletion dismissCompletion:(void (^)(void))Dcompletion;
@end
