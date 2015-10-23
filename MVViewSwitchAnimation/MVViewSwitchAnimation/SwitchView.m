//
//  switchView.m
//  MVViewSwitchAnimation
//
//  Created by sh219 on 15/10/20.
//  Copyright © 2015年 sh219. All rights reserved.
//

#import "SwitchView.h"

@interface SwitchView () {
    NSTimer *timer;
    NSInteger times;
    NSInteger animationsCount;
    NSInteger maxCount;
    
    NSMutableArray *begin_changed;
    void (^beginCompletion) (void);
    void (^stopCompletion) (void);
    void (^changeViewBegin) (UIView *);
    void (^changeViewStop) (UIView *);
}

@end
static UIWindow *__sheetWindow = nil;
static CGFloat interval = 0.5;
@implementation SwitchView
int numberOfPages = 10;
- (instancetype)init{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        int arrayCount = numberOfPages*2-1;
        begin_changed = [NSMutableArray arrayWithCapacity:arrayCount];
        for (int i = 0; i < arrayCount; i++) {
            [begin_changed addObject:[NSMutableArray array]];
        }
        /*   坐标系
         ----------->
         |            x轴
         |
         |
         |
         |
         v
         y轴
         */
        // x 坐标 tag/10
        // y 坐标 tag%10
        CGFloat widht = SCREEN_WIDTH/numberOfPages;
        CGFloat height = SCREEN_HEIGHT/numberOfPages;
        for (int x = 0; x < numberOfPages; x++) {
            for (int y = 0; y < numberOfPages; y++) {
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(widht * x, height * y, widht, height)];
                [view setFrame:CGRectMake(view.center.x-1, view.center.y-1, 2, 2)];
                view.tag = x * numberOfPages + y;
                view.backgroundColor = [UIColor blackColor];
                view.alpha = 0.0f;
//                view.hidden = YES;
                [self addSubview:view];
                int diff = y - x;
                [[begin_changed objectAtIndex:(numberOfPages-1-diff)] addObject:view];
            }
        }
        
        changeViewBegin = ^(UIView *view){
            [view setFrame:CGRectMake(view.center.x - widht/2, view.center.y - height/2, widht, height)];
            view.alpha = 1.0f;
//            view.hidden = NO;
        };
        changeViewStop = ^(UIView *view){
            [view setFrame:CGRectMake(view.center.x-1, view.center.y-1, 2, 2)];
            view.alpha = 0.0f;
            
        };
        animationsCount = [self countOfAnimations];
        [self initWindow];
    }
    return self;
}

- (void)initWindow{
    UIWindow *window = [[UIWindow alloc] initWithFrame:(CGRect) {{0.f, 0.f}, [[UIScreen mainScreen] bounds].size}];
    window.backgroundColor = [UIColor clearColor];
    window.windowLevel = UIWindowLevelNormal;
    window.hidden = NO;
    [window addSubview:self];
    __sheetWindow = window;
}

- (NSInteger)countOfAnimations{
    NSInteger sum;
    NSInteger dif;
    NSInteger count;
    for (int a = 1; a < [begin_changed count]; a++) {
        sum += a;
        if (sum >= [begin_changed count]) {
            count = a;
            dif = [begin_changed count] - (sum - a);
            if (dif == 0) {
                maxCount = a;
            }else{
                maxCount = a - 1;
            }
            break;
        }
    }
    count += dif - 1;
    return count;
}

- (void)beginSwitchAnimationWithAppearCompletion:(void (^)(void))Acompletion dismissCompletion:(void (^)(void))Dcompletion{
    if (!__sheetWindow) {
        [self initWindow];
    }
    times = 0;
    CGFloat inte = interval/animationsCount;
    timer = [NSTimer timerWithTimeInterval:inte target:self selector:@selector(beginViewAnimation:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [timer fire];
    beginCompletion = Acompletion;
    stopCompletion = Dcompletion;
}


- (void)beginViewAnimation:(id)sender{
    NSInteger num = 0;
    for (int i = 0; i < times; i++) {
        if (times < animationsCount && maxCount-i <= 0) {
            num += 1;
        }else{
            num += maxCount-i;
        }
        
    }
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < animationsCount; i++) {
        if (times == i && i == animationsCount -1) {
            times++;
            [array addObjectsFromArray:[begin_changed lastObject]];
            [UIView animateWithDuration:interval animations:^{
                for (UIView *view in array) {
                    changeViewBegin(view);
                }
            }completion:^(BOOL finished){
                if (finished) {
                    if (beginCompletion) {
                        beginCompletion();
                        beginCompletion = nil;
                    }
                }
            }];
            return;
        }else if (times == i && maxCount - i > 1) {
            times++;
            for (int j = 0; j < maxCount-i; j++) {
                NSInteger index = j+num;
                [array addObjectsFromArray:[begin_changed objectAtIndex:index]];
            }
            [UIView animateWithDuration:interval animations:^{
                for (UIView *view in array) {
                    changeViewBegin(view);
                }
                
            }completion:nil];
            return;
        }else if (times == i && maxCount - i <= 1){
            times++;
            NSInteger index = num;
            [array addObjectsFromArray:[begin_changed objectAtIndex:index]];
            [UIView animateWithDuration:interval animations:^{
                for (UIView *view in array) {
                    changeViewBegin(view);
                }
            }completion:nil];
            return;
        }else{
            continue;
        }
    }
    [timer invalidate];
    [self performSelector:@selector(stopSwitchAnimation) withObject:nil afterDelay:interval];
}

- (void)stopSwitchAnimation{
    times = 0;
    timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(stopViewAnimation:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [timer fire];
}

- (void)stopViewAnimation:(id)sender{
    NSInteger num = 0;
    for (int i = 0; i < times; i++) {
        if (times < animationsCount && maxCount-i <= 0) {
            num += 1;
        }else{
            num += maxCount-i;
        }
        
    }
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < animationsCount; i++) {
        if (times == i && i == animationsCount -1) {
            times++;
            [array addObjectsFromArray:[begin_changed lastObject]];
            [UIView animateWithDuration:interval animations:^{
                for (UIView *view in array) {
                    changeViewStop(view);
                }
            }completion:^(BOOL finished){
                if (finished) {
//                    for (UIView *view in array) {
//                        view.hidden = YES;
//                    }
                    if (stopCompletion) {
                        stopCompletion();
                        stopCompletion = nil;
                    }
                    [self removeWindow];
                }
            }];
            return;
        }else if (times == i && maxCount - i > 1) {
            times++;
            for (int j = 0; j < maxCount-i; j++) {
                NSInteger index = (j+num);
                [array addObjectsFromArray:[begin_changed objectAtIndex:index]];
            }
            [UIView animateWithDuration:interval animations:^{
                for (UIView *view in array) {
                    changeViewStop(view);
                }
                
            }completion:^(BOOL finished){
//                if (finished) {
//                    for (UIView *view in array) {
//                        view.hidden = YES;
//                    }
//                }
            }];
            return;
        }else if (times == i && maxCount - i <= 1){
            times++;
            NSInteger index = num;
            [array addObjectsFromArray:[begin_changed objectAtIndex:index]];
            [UIView animateWithDuration:interval animations:^{
                for (UIView *view in array) {
                    changeViewStop(view);
                }
            }completion:^(BOOL finished){
//                if (finished) {
//                    for (UIView *view in array) {
//                        view.hidden = YES;
//                    }
//                }
            }];
            return;
        }else{
            continue;
        }
    }
        [timer invalidate];
    
}

- (void)removeWindow{
    __sheetWindow = nil;
}

@end
