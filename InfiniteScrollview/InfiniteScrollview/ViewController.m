//
//  ViewController.m
//  InfiniteScrollview
//
//  Created by sh219 on 15/10/14.
//  Copyright © 2015年 sh219. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>{
    UIView *previousView;
    UIView *currentView;
    UIView *nextView;
    NSArray *colorArray;
    NSInteger pageIndex;
    NSUInteger status;
    /*
     page1 : red
     page2 : green
     page3 : blue
     */
}

@end

@implementation ViewController
- (IBAction)pushView:(id)sender {
}
@synthesize InfiniteScrollView;
- (void)viewDidLoad {
    [super viewDidLoad];
    status = 0;
    InfiniteScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, SCREEN_HEIGHT);
    InfiniteScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    InfiniteScrollView.bounces = NO;
    InfiniteScrollView.pagingEnabled = YES;
    InfiniteScrollView.showsHorizontalScrollIndicator = NO;
    colorArray = @[[UIColor redColor],[UIColor blueColor],[UIColor greenColor]];
    
    previousView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    previousView.backgroundColor = colorArray[2];
    [InfiniteScrollView addSubview:previousView];
    
    nextView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    nextView.backgroundColor = colorArray[1];
    [InfiniteScrollView addSubview:nextView];
    
    currentView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    currentView.backgroundColor = colorArray[0];
    [InfiniteScrollView addSubview:currentView];
    
    pageIndex = 0;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 150, 70)];
    [button setBackgroundColor:[UIColor whiteColor]];
    [button setTitle:@"change" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    [button setCenter:CGPointMake(screenSize.width/2, screenSize.height/2)];
    [button addTarget:self action:@selector(changeStatus:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)changeStatus:(UIButton *)sender{
    if (status == 0) {
        status = 1;
    }else{
        status = 0;
    }
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger kCount = colorArray.count-1;
    CGFloat offset = InfiniteScrollView.contentOffset.x;
    UIColor *whiteColor = [UIColor whiteColor];
    
    if (offset == 0) {
        currentView.backgroundColor = previousView.backgroundColor;
        InfiniteScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        previousView.backgroundColor = whiteColor;
        if (pageIndex == 0) {
            pageIndex = kCount;
        }else{
            pageIndex -= 1;
        }
    }
    if (offset == SCREEN_WIDTH*2) {
        currentView.backgroundColor = nextView.backgroundColor;
        InfiniteScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        nextView.backgroundColor = whiteColor;
        if (pageIndex == kCount) {
            pageIndex = 0;
        }else{
            pageIndex += 1;
        }
    }
    if (nextView.backgroundColor == whiteColor || previousView.backgroundColor == whiteColor) {
        NSInteger nextIndex = (pageIndex == kCount ? 0 : pageIndex+1);
        nextView.backgroundColor = (UIColor *)colorArray[nextIndex];
        NSInteger previousIndex = (pageIndex == 0 ? kCount : pageIndex-1);
        previousView.backgroundColor = (UIColor *)colorArray[previousIndex];
    }
    
}

//- (BOOL)prefersStatusBarHidden
//{
//    switch (status) {
//        case 0:
//            return NO;
//            break;
//        case 1:
//            return YES;
//            break;
//        default:
//            return NO;
//            break;
//    }
//    
//    
//    
//}

- (UIStatusBarStyle)preferredStatusBarStyle{
    switch (status) {
        case 0:
            return UIStatusBarStyleDefault;
            break;
        case 1:
            return UIStatusBarStyleLightContent;
            break;
        default:
            return UIStatusBarStyleLightContent;
            break;
    }
    
}

@end
