//
//  ViewBController.m
//  MVViewSwitchAnimation
//
//  Created by sh219 on 15/10/20.
//  Copyright © 2015年 sh219. All rights reserved.
//

#import "ViewBController.h"
#import "UIViewController+MVSwitchAnimation.h"

@interface ViewBController ()

@end

@implementation ViewBController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self dismissSwitchViewControllerAnimated:YES completion:nil];
}

@end
