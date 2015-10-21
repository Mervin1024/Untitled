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
    NSMutableArray *begin_changed;
    void (^beginCompletion) (void);
    void (^stopCompletion) (void);
}

@end
static UIWindow *__sheetWindow = nil;
@implementation SwitchView
int numberOfPages = 9;
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
                view.hidden = YES;
                [self addSubview:view];
                int diff = y - x;
                [[begin_changed objectAtIndex:(8-diff)] addObject:view];
            }
        }
//        self.hidden = YES;
        UIWindow *window = [[UIWindow alloc] initWithFrame:(CGRect) {{0.f, 0.f}, [[UIScreen mainScreen] bounds].size}];
        window.backgroundColor = [UIColor clearColor];
        window.windowLevel = UIWindowLevelNormal;
        window.alpha = 1.f;
        window.hidden = YES;
        [window addSubview:self];
        __sheetWindow = window;
    }
    return self;
}

- (void)beginSwitchAnimationWithAppearCompletion:(void (^)(void))Acompletion dismissCompletion:(void (^)(void))Dcompletion{
//    self.hidden = NO;
    __sheetWindow.hidden = NO;
    times = 0;
    timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(beginViewAnimation:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [timer fire];
    beginCompletion = Acompletion;
    stopCompletion = Dcompletion;
}

- (void)beginViewAnimation:(id)sender{
    CGFloat widht = SCREEN_WIDTH/numberOfPages;
    CGFloat height = SCREEN_HEIGHT/numberOfPages;
    
    NSMutableArray *array = [NSMutableArray array];
    if (times == 0) {
        times++;
        [array addObjectsFromArray:begin_changed[0]];
        [array addObjectsFromArray:begin_changed[1]];
        [array addObjectsFromArray:begin_changed[2]];
        [array addObjectsFromArray:begin_changed[3]];
        [array addObjectsFromArray:begin_changed[4]];
        [UIView animateWithDuration:0.5 animations:^{
            for (UIView *view in array) {
                [view setFrame:CGRectMake(view.center.x - widht/2, view.center.y - height/2, widht, height)];
                view.hidden = NO;
            }
            
        }completion:nil];
    }else if (times == 1){
        times++;
        [array addObjectsFromArray:begin_changed[5]];
        [array addObjectsFromArray:begin_changed[6]];
        [array addObjectsFromArray:begin_changed[7]];
        [array addObjectsFromArray:begin_changed[8]];
        [UIView animateWithDuration:0.5 animations:^{
            for (UIView *view in array) {
                [view setFrame:CGRectMake(view.center.x - widht/2, view.center.y - height/2, widht, height)];
                view.hidden = NO;
            }
        }completion:nil];
    }else if (times == 2){
        times++;
        [array addObjectsFromArray:begin_changed[9]];
        [array addObjectsFromArray:begin_changed[10]];
        [array addObjectsFromArray:begin_changed[11]];
        [UIView animateWithDuration:0.5 animations:^{
            for (UIView *view in array) {
                [view setFrame:CGRectMake(view.center.x - widht/2, view.center.y - height/2, widht, height)];
                view.hidden = NO;
            }
        }completion:nil];
    }else if (times == 3){
        times++;
        [array addObjectsFromArray:begin_changed[12]];
        [array addObjectsFromArray:begin_changed[13]];
        [UIView animateWithDuration:0.5 animations:^{
            for (UIView *view in array) {
                [view setFrame:CGRectMake(view.center.x - widht/2, view.center.y - height/2, widht, height)];
                view.hidden = NO;
            }
        }completion:nil];
    }else if (times == 4){
        times++;
        [array addObjectsFromArray:begin_changed[14]];
        [UIView animateWithDuration:0.5 animations:^{
            for (UIView *view in array) {
                [view setFrame:CGRectMake(view.center.x - widht/2, view.center.y - height/2, widht, height)];
                view.hidden = NO;
            }
        }completion:nil];
    }else if (times == 5){
        times++;
        [array addObjectsFromArray:begin_changed[15]];
        [UIView animateWithDuration:0.5 animations:^{
            for (UIView *view in array) {
                [view setFrame:CGRectMake(view.center.x - widht/2, view.center.y - height/2, widht, height)];
                view.hidden = NO;
            }
        }completion:nil];
    }else if (times == 6){
        times++;
        [array addObjectsFromArray:begin_changed[16]];
        [UIView animateWithDuration:0.5 animations:^{
            for (UIView *view in array) {
                [view setFrame:CGRectMake(view.center.x - widht/2, view.center.y - height/2, widht, height)];
                view.hidden = NO;
            }
        }completion:^(BOOL finished){
            if (beginCompletion) {
                beginCompletion();
                beginCompletion = nil;
            }
        }];
    }else{
        [timer invalidate];
        
        [self performSelector:@selector(stopSwitchAnimation) withObject:nil afterDelay:0.5];
    }
}

- (void)stopSwitchAnimation{
    times = 0;
    timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(stopViewAnimation:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [timer fire];
}

- (void)stopViewAnimation:(id)sender{
    NSMutableArray *array = [NSMutableArray array];
    if (times == 0) {
        times++;
        [array addObjectsFromArray:begin_changed[0]];
        [UIView animateWithDuration:0.5 animations:^{
            for (UIView *view in array) {
                [view setFrame:CGRectMake(view.center.x-1, view.center.y-1, 2, 2)];
            }
        }completion:^(BOOL finished){
            if (finished) {
                for (UIView *view in array) {
                    view.hidden = YES;
                }
            }
        }];
    }else if (times == 1){
        times++;
        [array addObjectsFromArray:begin_changed[1]];
        [UIView animateWithDuration:0.5 animations:^{
            for (UIView *view in array) {
                [view setFrame:CGRectMake(view.center.x-1, view.center.y-1, 2, 2)];
            }
        }completion:^(BOOL finished){
            if (finished) {
                for (UIView *view in array) {
                    view.hidden = YES;
                }
            }
        }];
    }else if (times == 2){
        times++;
        [array addObjectsFromArray:begin_changed[2]];
        [UIView animateWithDuration:0.5 animations:^{
            for (UIView *view in array) {
                [view setFrame:CGRectMake(view.center.x-1, view.center.y-1, 2, 2)];
            }
        }completion:^(BOOL finished){
            if (finished) {
                for (UIView *view in array) {
                    view.hidden = YES;
                }
            }
        }];
    }else if (times == 3){
        times++;
        [array addObjectsFromArray:begin_changed[3]];
        [array addObjectsFromArray:begin_changed[4]];
        [UIView animateWithDuration:0.5 animations:^{
            for (UIView *view in array) {
                [view setFrame:CGRectMake(view.center.x-1, view.center.y-1, 2, 2)];
            }
        }completion:^(BOOL finished){
            if (finished) {
                for (UIView *view in array) {
                    view.hidden = YES;
                }
            }
        }];
    }else if (times == 4){
        times++;
        [array addObjectsFromArray:begin_changed[5]];
        [array addObjectsFromArray:begin_changed[6]];
        [array addObjectsFromArray:begin_changed[7]];
        [UIView animateWithDuration:0.5 animations:^{
            for (UIView *view in array) {
                [view setFrame:CGRectMake(view.center.x-1, view.center.y-1, 2, 2)];
            }
        }completion:^(BOOL finished){
            if (finished) {
                for (UIView *view in array) {
                    view.hidden = YES;
                }
            }
        }];
    }else if (times == 5){
        times++;
        [array addObjectsFromArray:begin_changed[8]];
        [array addObjectsFromArray:begin_changed[9]];
        [array addObjectsFromArray:begin_changed[10]];
        [array addObjectsFromArray:begin_changed[11]];
        [UIView animateWithDuration:0.5 animations:^{
            for (UIView *view in array) {
                [view setFrame:CGRectMake(view.center.x-1, view.center.y-1, 2, 2)];
            }
        }completion:^(BOOL finished){
            if (finished) {
                for (UIView *view in array) {
                    view.hidden = YES;
                }
            }
        }];
    }else if (times == 6){
        times++;
        [array addObjectsFromArray:begin_changed[12]];
        [array addObjectsFromArray:begin_changed[13]];
        [array addObjectsFromArray:begin_changed[14]];
        [array addObjectsFromArray:begin_changed[15]];
        [array addObjectsFromArray:begin_changed[16]];
        [UIView animateWithDuration:0.5 animations:^{
            for (UIView *view in array) {
                [view setFrame:CGRectMake(view.center.x-1, view.center.y-1, 2, 2)];
            }
        }completion:^(BOOL finished){
            if (finished) {
                for (UIView *view in array) {
                    view.hidden = YES;
                }
                if (stopCompletion) {
                    stopCompletion();
                    stopCompletion = nil;
                }
            }
            [self removeWindow];
        }];
    }else{
        [timer invalidate];
        
        
    }
}

- (void)removeWindow{
    __sheetWindow.hidden = YES;
    __sheetWindow = nil;
}

@end
