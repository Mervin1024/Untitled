//
//  ViewController.h
//  InfiniteScrollview
//
//  Created by sh219 on 15/10/14.
//  Copyright © 2015年 sh219. All rights reserved.
//

#import <UIKit/UIKit.h>


#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface MasterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *InfiniteScrollView;

@end

